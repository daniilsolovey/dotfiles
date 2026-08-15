#!/bin/bash

USB_C_STATUS=$(xrandr --query | awk '/^DP-3 / {print $2}')
HDMI_STATUS=$(xrandr --query | awk '/^HDMI-1 / {print $2}')

if [ "$USB_C_STATUS" = "connected" ] && [ "$HDMI_STATUS" = "connected" ]; then
    "$HOME/.screenlayout/usb-c-hdmi.sh"
elif [ "$USB_C_STATUS" = "connected" ]; then
    "$HOME/.screenlayout/usb-c.sh"
else
    "$HOME/.screenlayout/laptop.sh"
fi