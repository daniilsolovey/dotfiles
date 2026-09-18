#!/bin/bash

STATE="${XDG_RUNTIME_DIR}/screenshot-keyboard"
DIR="/home/operator/Deepin-Screenshots"

mkdir -p "$STATE"
mkdir -p "$DIR"

eval "$(xdotool getmouselocation --shell)"

if [ ! -f "$STATE/start" ]; then
    echo "$X $Y" > "$STATE/start"
    notify-send "Screenshot" "Первая точка: $X,$Y"
    exit 0
fi

read X1 Y1 < "$STATE/start"
X2=$X
Y2=$Y

# левая верхняя точка
if [ "$X1" -lt "$X2" ]; then
    RX=$X1
    W=$((X2 - X1))
else
    RX=$X2
    W=$((X1 - X2))
fi

if [ "$Y1" -lt "$Y2" ]; then
    RY=$Y1
    H=$((Y2 - Y1))
else
    RY=$Y2
    H=$((Y1 - Y2))
fi

rm -rf "$STATE"

[ "$W" -gt 0 ] || exit 1
[ "$H" -gt 0 ] || exit 1

FILE="$DIR/Screenshot_$(date +%Y-%m-%d_%H-%M-%S).png"

maim -g "${W}x${H}+${RX}+${RY}" "$FILE" || exit 1

xclip -selection clipboard -t image/png -i "$FILE"

notify-send "Скриншот сохранён" "$FILE"

# выйти из keynav
xdotool key F24