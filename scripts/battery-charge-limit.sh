#!/bin/sh

BAT="/sys/class/power_supply/BAT0"

case "$1" in
    safe)
        echo 40 | sudo tee "$BAT/charge_control_start_threshold" >/dev/null
        echo 50 | sudo tee "$BAT/charge_control_end_threshold" >/dev/null

        echo "Battery charge limits: 40% -> 50%"
        ;;

    full)
        echo 0 | sudo tee "$BAT/charge_control_start_threshold" >/dev/null
        echo 100 | sudo tee "$BAT/charge_control_end_threshold" >/dev/null

        echo "Battery charge limits: 0% -> 100%"
        ;;

    status)
        START=$(cat "$BAT/charge_control_start_threshold")
        END=$(cat "$BAT/charge_control_end_threshold")
        CAPACITY=$(cat "$BAT/capacity")
        STATUS=$(cat "$BAT/status")

        echo "Start threshold: ${START}%"
        echo "End threshold:   ${END}%"
        echo "Battery:         ${CAPACITY}%"
        echo "Status:          $STATUS"
        ;;

    *)
        echo "Usage: $0 {safe|full|status}"
        exit 1
        ;;
esac