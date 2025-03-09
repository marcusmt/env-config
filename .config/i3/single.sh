#!/bin/sh

xrandr --output DP-4 --primary
nvidia-settings --assign CurrentMetaMode="DP-4: 2560x1600_165 +0+0 {ForceCompositionPipeline=On, ForceFullCompositionPipeline=On}"

feh --bg-fil $HOME/Pictures/wall.jpg