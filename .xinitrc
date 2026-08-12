xrdb -load .Xresources
export GOPATH="$HOME/go"
export PATH="$HOME/bin:$GOPATH/bin:/opt/atlassian/plugin-sdk/bin:$HOME/.local/bin:$HOME/deadfiles/bin:$PATH:$HOME/Scripts"



systemctl --user import-environment DISPLAY

xkbcomp -w 0 -I$HOME/.xkb -R$HOME/.xkb $HOME/.xkbrc $DISPLAY &
shift-shift -first CAPSLOCK -second RIGHTSHIFT -match '(?i)razer|keyboard|storm|microelectronics|COMPANY|Apple|Keychron K2' &
xbindkeys &

xset b off &
xset r rate 150 170 &


keynav &




exec i3
