#!/bin/bash

direction=$1 # Expect 'up' or 'down'
max_volume=150
increment=10

current_volume=$(pactl list sinks | grep '^[[:space:]]Volume:' | head -n 1 | awk '{print $5}' | sed 's/%//g')

if [ "$direction" == "up" ]; then
    if [ "$current_volume" -lt "$max_volume" ]; then
        pactl set-sink-volume @DEFAULT_SINK@ +${increment}%
        new_volume=$((current_volume + increment))
        new_volume=$(($new_volume>150 ? 150 : $new_volume))
    fi
elif [ "$direction" == "down" ]; then
    pactl set-sink-volume @DEFAULT_SINK@ -${increment}%
    new_volume=$((current_volume - increment))
    new_volume=$(($new_volume<0 ? 0 : $new_volume))
fi

# Use notify-send to display the current volume
notify-send "Volume" "Volume set to $new_volume%" -h int:value:$new_volume -h string:synchronous:volume-change
