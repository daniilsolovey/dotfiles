#!/bin/bash

dir="/home/operator/Deepin-Screenshots"
file="$dir/Screenshot_$(date +%Y-%m-%d_%H-%M-%S).png"

mkdir -p "$dir"

maim -s "$file" || exit 1

xclip -selection clipboard -t image/png -i "$file"
notify-send "Скриншот сохранён" "$file"
