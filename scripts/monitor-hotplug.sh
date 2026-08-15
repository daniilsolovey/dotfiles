#!/bin/bash

sleep 2
"$HOME/Scripts/monitor-auto.sh"

udevadm monitor --udev --subsystem-match=drm | while read -r line; do
    if echo "$line" | grep -q "change"; then
        sleep 2
        "$HOME/Scripts/monitor-auto.sh"
    fi
done