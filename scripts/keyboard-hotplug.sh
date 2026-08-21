#!/bin/bash

apply_keyboard() {
    xkbcomp -w 0 \
        -I"$HOME/.xkb" \
        -R"$HOME/.xkb" \
        "$HOME/.xkbrc" \
        "$DISPLAY"

    xset r rate 170 170
}

xinput test-xi2 --root |
while IFS= read -r line; do
    case "$line" in
        *HierarchyChanged*)
            sleep 1
            apply_keyboard
            ;;
    esac
done