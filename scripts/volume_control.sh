#!/bin/bash

direction=$1 # Expect 'up' or 'down'
max_volume=150
increment=10 # We adjust by 10% increments for clean rounding

# Function to get the current volume of a given sink
get_current_volume() {
    pactl list sinks | grep -A 15 "Name: $1" | grep '^[[:space:]]Volume:' | head -n 1 | awk '{print $5}' | sed 's/%//g'
}

# Function to round the volume to the nearest 10
round_volume() {
    local volume=$1
    local rounded_volume=$(( (volume + 5) / 10 * 10 ))
    echo $rounded_volume
}

# Function to send a notification with the volume level
send_notification() {
    local volume=$1
    notify-send "Volume" "Volume set to ${volume}%" -h int:value:"$volume" -h string:synchronous:volume-change
}

# Find the sink associated with a headset, if available
headset_sink=$(pactl list short sinks | grep -Ei '(headset|headphone)' | awk '{print $2}' | head -n 1)

# Fallback to default sink if no headset is found
if [ -z "$headset_sink" ]; then
    headset_sink=$(pactl info | grep 'Default Sink' | cut -d' ' -f3)
fi

# Get the current volume for the active sink
current_volume=$(get_current_volume "$headset_sink")

# Calculate new volume based on direction and round it
if [ "$direction" == "up" ]; then
    new_volume=$((current_volume + increment))
    new_volume=$(($new_volume>max_volume ? max_volume : $new_volume))
    new_volume=$(round_volume $new_volume)
    pactl set-sink-volume "$headset_sink" ${new_volume}%
elif [ "$direction" == "down" ]; then
    new_volume=$((current_volume - increment))
    new_volume=$(($new_volume<0 ? 0 : $new_volume))
    new_volume=$(round_volume $new_volume)
    pactl set-sink-volume "$headset_sink" ${new_volume}%
fi

send_notification $new_volume
