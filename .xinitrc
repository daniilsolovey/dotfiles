#!/bin/bash

xrdb -load "$HOME/.Xresources"

export GOPATH="$HOME/go"
export PATH="$HOME/bin:$GOPATH/bin:/opt/atlassian/plugin-sdk/bin:$HOME/.local/bin:$HOME/deadfiles/bin:$PATH:$HOME/Scripts"

systemctl --user import-environment DISPLAY

# Применить раскладку при старте X
xkbcomp -w 0 \
    -I"$HOME/.xkb" \
    -R"$HOME/.xkb" \
    "$HOME/.xkbrc" \
    "$DISPLAY" &

# Обработка CapsLock + RightShift
shift-shift \
    -first CAPSLOCK \
    -second RIGHTSHIFT \
    -match '(?i)razer|keyboard|storm|microelectronics|COMPANY|Apple|Keychron' &

xbindkeys &

xset b off &
xset r rate 170 170 &

# Автоматически переустанавливать раскладку
# при подключении Bluetooth/USB клавиатуры
"$HOME/Scripts/keyboard-hotplug.sh" &

xinput set-prop \
    "ELAN067B:00 04F3:31F8 Touchpad" \
    "libinput Accel Speed" 0.2 &

low-battery-notify &
keynav &

"$HOME/Scripts/monitor-hotplug.sh" &

exec i3
