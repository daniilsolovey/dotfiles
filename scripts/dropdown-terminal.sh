#!/bin/bash

if ! pgrep -f "urxvt -name dropdown" >/dev/null; then
    urxvt -name dropdown -e tmux new-session -A -s dropdown &
    pid=$!

    # Если терминал закрыли через Ctrl+D / exit,
    # возвращаем i3 из dropdown-terminal mode
    (
        while kill -0 "$pid" 2>/dev/null; do
            sleep 0.1
        done

        current_mode=$(i3-msg -t get_binding_state | sed -n 's/.*"name":"\([^"]*\)".*/\1/p')

        if [ "$current_mode" = "dropdown-terminal" ]; then
            i3-msg 'mode "default"' >/dev/null
        fi
    ) &

    # Ждём появления окна
    for _ in {1..20}; do
        if i3-msg -t get_tree | grep -q '"instance":"dropdown"'; then
            break
        fi
        sleep 0.05
    done

    i3-msg '[instance="dropdown"] move scratchpad'
fi

i3-msg '[instance="dropdown"] scratchpad show'
i3-msg 'mode "dropdown-terminal"'