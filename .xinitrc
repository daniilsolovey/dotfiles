xrdb -load .Xresources
export GOPATH="$HOME/go"
export PATH="$HOME/bin:$GOPATH/bin:/opt/atlassian/plugin-sdk/bin:$HOME/.local/bin:$HOME/deadfiles/bin:$PATH"

systemctl --user import-environment DISPLAY
sudo systemctl import-environment DISPLAY

autorandr --change
xkbcomp -w 0 -I$HOME/.xkb -R$HOME/.xkb $HOME/.xkbrc $DISPLAY &
sudo shift-shift -first CAPSLOCK -second RIGHTSHIFT -match '(?i)razer|keyboard|storm|microelectronics|COMPANY' &
keynav &
xbindkeys &
low-battery-notify &
xset r rate 150 170 &

sudo ntpdate pool.ntp.org &

exec i3