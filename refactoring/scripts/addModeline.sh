#!/bin/sh

# 1280 x 720
modeline=$(cvt -v 1280 720 | grep Modeline | sed -e "s/Modeline //")
modename=$(echo $modeline | awk '{ print $1; }')
sudo xrandr --newmode $modeline
xrandr --addmode eDP-1 $modename

# 1600 x 900 
modeline=$(cvt -v 1600 900 | grep Modeline | sed -e "s/Modeline //")
modename=$(echo $modeline | awk '{ print $1; }')
sudo xrandr --newmode $modeline
xrandr --addmode eDP-1 $modename
