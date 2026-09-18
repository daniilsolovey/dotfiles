#!/bin/sh

STATE="${XDG_RUNTIME_DIR:-/tmp}/keyboard-mouse-drag"

if [ -f "$STATE" ]; then
    xdotool mouseup 1
    rm -f "$STATE"
else
    xdotool mousedown 1
    touch "$STATE"
fi
