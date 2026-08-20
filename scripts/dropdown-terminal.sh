#!/bin/bash

if ! pgrep -f "urxvt -name dropdown" >/dev/null; then
    urxvt -name dropdown &
    sleep 0.2
fi

i3-msg '[instance="dropdown"] scratchpad show'