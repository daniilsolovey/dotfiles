#!/bin/bash
xkbcomp -w 0 -I$HOME/.xkb -R$HOME/.xkb $HOME/.xkbrc $DISPLAY &
sudo shift-shift -first CAPSLOCK -second RIGHTSHIFT -match '(?i)razer|keyboard|storm|microelectronics|COMPANY|Apple|Keychron K2' &
xbindkeys &
xset r rate 150 170 &