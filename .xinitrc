xrdb -load .Xresources
export GOPATH="$HOME/go"
export PATH="$HOME/bin:$GOPATH/bin:/opt/atlassian/plugin-sdk/bin:$HOME/.local/bin:$HOME/deadfiles/bin:$PATH:$HOME/Scripts"

systemctl --user import-environment DISPLAY
sudo systemctl import-environment DISPLAY

xkbcomp -w 0 -I$HOME/.xkb -R$HOME/.xkb $HOME/.xkbrc $DISPLAY &
sudo shift-shift -first CAPSLOCK -second RIGHTSHIFT -match '(?i)razer|keyboard|storm|microelectronics|COMPANY|Apple|Keychron K2' &
xbindkeys &
low-battery-notify &
xset r rate 150 170 &

keynav &

sudo ntpdate pool.ntp.org &

xset -dpms; xset s off; xset s noexpose; xset s noblank

.screenlayout/hdmi_and_display_port.sh &

exec i3