#!/bin/bash


# скрипт для логирования трафика через openvpn для каждого пользователя в отдельном файле используя iptables
# для одного пользователя:
#LOGDIR="/root/Openvpn_LOG"
#DATE=$(date +%Y-%m)
#TS=$(date '+%Y-%m-%d %H:%M:%S')

## Получаем байты из цепочки
#BYTES=$(iptables -L DenzelArch -v -n | awk 'NR==3 {print $2}')
#MB=$(echo "$BYTES / 1024 / 1024" | bc -l)

## Пишем в файл по месяцу
#echo "$TS  bytes=$BYTES  MB=$(printf %.2f "$MB")" >> "$LOGDIR/$DATE.log"

## Обнуляем счётчик
#iptables -Z DenzelArch


# для всех пользователей:
set -euo pipefail

LOGDIR="/root/Openvpn_LOG"
IPP_FILE="/etc/openvpn/ipp.txt"

DATE=$(date +%Y-%m)
TS=$(date '+%Y-%m-%d %H:%M:%S')

mkdir -p "$LOGDIR"

# один общий лог на месяц
OUT="$LOGDIR/${DATE}.log"

while IFS=',' read -r CN IP4 IP6; do
  [ -z "$CN" ] && continue

  CHAIN="OVPN_$(echo "$CN" | tr '-' '_' )"

  # читаем байты для этого клиента
  BYTES=$(iptables -L "$CHAIN" -v -n 2>/dev/null | awk 'NR==3 {print $2}')
  # если цепочки нет или нет счётчиков - пропустим
  [ -z "$BYTES" ] && continue

  MB=$(echo "$BYTES / 1024 / 1024" | bc -l)

  printf "%s CN=%s bytes=%s MB=%.2f\n" "$TS" "$CN" "$BYTES" "$MB" >> "$OUT"

  # обнуляем счётчик только этой цепочки
  iptables -Z "$CHAIN" || true
done < "$IPP_FILE"
