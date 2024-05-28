#!/usr/bin/env bash
polybar-msg cmd quit

#polybar -c $HOME/.config/polybar/config_top.ini top  &
polybar -c $HOME/.config/polybar/config_bottom.ini bottom  &
