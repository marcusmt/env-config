#!/usr/bin/env bash

xrandr --output eDP-1-1 --mode 1920x1080 --scale 1x1 --primary --output HDMI-0 --off
# need to sleep to give xrandr time to organize the screen
sleep 10
i3-msg restart

polybar-msg cmd quit

polybar -c $HOME/.config/polybar/config.ini laptop_only  &

nitrogen --restore
