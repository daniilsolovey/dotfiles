#!/usr/bin/env bash
set -euo pipefail

IPP_FILE="/etc/openvpn/ipp.txt"
MAX_CHAIN_LEN=27
# скрипт для инициализации iptables для каждого пользователя в отдельной цепочке используя iptables
# для одного пользователя:
#CHAIN="OVPN_UserName"
#iptables -N "$CHAIN"
#iptables -A "$CHAIN" -j RETURN
#iptables -I FORWARD 1 -s 10.8.0.1 -j "$CHAIN"
#iptables -I FORWARD 1 -d 10.8.0.1 -j "$CHAIN"

# читаем список клиентов
while IFS=',' read -r CN IP4 IP6; do
  # пропуск пустых строк
  [ -z "$CN" ] && continue

  # нормализуем имя цепочки: OVPN_<CN>, заменяя '-' на '_'
  CHAIN="OVPN_$(echo "$CN" | tr '-' '_' )"

    # ➜ проверка длины
  if [ ${#CHAIN} -gt $MAX_CHAIN_LEN ]; then
    CHAIN="${CHAIN:0:$MAX_CHAIN_LEN}"
  fi

  echo "==> Настраиваю клиента $CN (цепочка $CHAIN, IP4=$IP4, IP6=$IP6)"

  # создаём цепочку, если её ещё нет
  if ! iptables -L "$CHAIN" -n &>/dev/null; then
    iptables -N "$CHAIN"
    # добавляем RETURN, чтобы цепочка только считала и возвращала
    iptables -A "$CHAIN" -j RETURN
  fi

  # если есть IPv4 — добавляем правила в FORWARD (idempotent: сначала проверяем)
  if [ -n "${IP4:-}" ]; then
    if ! iptables -C FORWARD -s "$IP4" -j "$CHAIN" &>/dev/null; then
      iptables -I FORWARD 1 -s "$IP4" -j "$CHAIN"
    fi
    if ! iptables -C FORWARD -d "$IP4" -j "$CHAIN" &>/dev/null; then
      iptables -I FORWARD 1 -d "$IP4" -j "$CHAIN"
    fi
  fi

  # если хочешь ещё и IPv6 — аналогично через ip6tables:
  if [ -n "${IP6:-}" ]; then
    if ! ip6tables -L "$CHAIN" -n &>/dev/null; then
      ip6tables -N "$CHAIN"
      ip6tables -A "$CHAIN" -j RETURN
    fi
    if ! ip6tables -C FORWARD -s "$IP6" -j "$CHAIN" &>/dev/null; then
      ip6tables -I FORWARD 1 -s "$IP6" -j "$CHAIN"
    fi
    if ! ip6tables -C FORWARD -d "$IP6" -j "$CHAIN" &>/dev/null; then
      ip6tables -I FORWARD 1 -d "$IP6" -j "$CHAIN"
    fi
  fi

done < "$IPP_FILE"
