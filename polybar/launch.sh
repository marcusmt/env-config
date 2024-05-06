#!/usr/bin/env bash

xrandr --output eDP-1-1 --mode 1920x1080 --scale 1x1 --primary --pos 0x0 --output HDMI-0 --mode 3840x2160 --pos 3840x0
# need to sleep to give xrandr time to organize the screen
sleep 10
i3-msg restart

polybar-msg cmd quit

polybar -c $HOME/.config/polybar/config.ini laptop  &
polybar -c $HOME/.config/polybar/config.ini monitor &

nitrogen --restore
