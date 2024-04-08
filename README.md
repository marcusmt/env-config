# env-config
Scripts and configurations for my environment

Good source to start:
https://itsfoss.com/i3-customization/
https://github.com/Murzchnvok/polybar-collection/blob/master/themes/gruvbox/config.ini


Terminal
https://snapcraft.io/alacritty
themes: https://github.com/alacritty/alacritty-theme


NeoVim
https://snapcraft.io/nvim


Download fonts from Nerd Font. They contain icons so it's easy to use
https://www.nerdfonts.com/font-downloads

To install fonts:

mkdir ~/.fonts
cd .fonts
unzip Meslo.zip -d ~/.fonts
fc-cache -fv

Wallpaper
https://4kwallpapers.com/technology/hello-world-pixel-15168.html

Polybar
https://github.com/polybar/polybar?tab=readme-ov-file#installation

mkdir -p ~/.config/polybar/
after downloading the files:
chmod +x $HOME/.config/polybar/launch.sh

For the backligh to work, use the following commands:
sudo nvim /etc/udev/rules.d/backlight.rules
Paste:
ACTION=="add", SUBSYSTEM=="backlight", KERNEL=="intel_backlight", RUN+="/usr/bin/chgrp video /sys/class/backlight/intel_backlight/brightness"
ACTION=="add", SUBSYSTEM=="backlight", KERNEL=="intel_backlight", RUN+="/usr/bin/chmod g+w /sys/class/backlight/intel_backlight/brightness"

And run:
sudo usermod -aG video $LOGNAME

After just reboot


Rofi
https://github.com/davatorium/rofi/blob/next/INSTALL.md


Picom
sudo apt install picom

Flameshot - Screenshot
sudo apt install flameshot


i3 download:
Follow the steps in https://i3wm.org/docs/repositories.html

    How to get windows class https://www.tuxtips.info/linux/how-to-find-applications-window-class-in-i3-window-manager
Then use the previous apps already configured

To define default browser
xdg-settings set default-web-browser microsoft-edge.desktop
