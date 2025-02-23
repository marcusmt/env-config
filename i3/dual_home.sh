#!/bin/sh

nvidia-settings --assign CurrentMetaMode="DP-4: 2560x1600_165 +0+0 {viewportin=3840x2400, ForceCompositionPipeline=On, ForceFullCompositionPipeline=On}, DP-3: nvidia-auto-select +3840+0 {ForceCompositionPipeline=On, ForceFullCompositionPipeline=On}"

feh --bg-fil $HOME/Pictures/wall.jpg