# My Personal Ubuntu Environment Setup with i3WM
1. Environment
2. What to do after installing Ubuntu
3. Alacritty
4. i3wm customisation

Everything is based on my taste and preferences so follow it on your own risk!  

## Environment
- Ubuntu 20.04
- Nvidia GPU (worth to mention because of drivers and X11. In case you have an AMD gpu then maybe Wayland is an option)
- i3WM
    - Rofi
    - Polybar
- Alacritty
    - Fish
    - Starship
    - NeoVim
- IntelliJ (I'm a Java deloper \o/ )
- All OpenJDK (plain JDK, no specific vendor) you need! 

## What to do after installing Ubuntu
Well, Ubuntu doesn't include curl by default. So let's install it first of all since it will be much needed later:
```shell
sudo apt install curl -y
```  

1. Install Nvidia driver
```shell
sudo ubuntu-drivers install
```  
2. [Install Google Chrome](https://www.google.fr/intl/en_us/chrome/)
3. [Install i3wm](https://i3wm.org/docs/repositories.html)
```shell
/usr/lib/apt/apt-helper download-file https://debian.sur5r.net/i3/pool/main/s/sur5r-keyring/sur5r-keyring_2024.03.04_all.deb keyring.deb SHA256:f9bb4340b5ce0ded29b7e014ee9ce788006e9bbfe31e96c09b2118ab91fca734
sudo apt install ./keyring.deb
echo "deb http://debian.sur5r.net/i3/ $(grep '^DISTRIB_CODENAME=' /etc/lsb-release | cut -f2 -d=) universe" | sudo tee /etc/apt/sources.list.d/sur5r-i3.list
sudo apt update
sudo apt install i3 -y
rm -rf keyring.deb
```  
4. [Install Alacritty](https://snapcraft.io/alacritty)
    - Yes, I'm using Snap. People said it's slow compared to .deb packages but I couldn't notice any slowness so I'm using it.
```shell
sudo snap install alacritty --classic
```  
5. [Install a Nerd Font to have icons included](https://www.nerdfonts.com/font-downloads)
    - I'm using Hack https://www.programmingfonts.org/#hack
```shell
mkdir ~/.fonts
unzip ~/Downloads/Hack.zip -d ~/.fonts
fc-cache -fv
```  
5. Fix annoying error message in Ubuntu Software caused by Snap app
```shell
snap-store --quit && sudo snap refresh snap-store
```  
6. [Fix missing support for AppImage](https://github.com/AppImage/AppImageKit/wiki/FUSE)
```shell
sudo add-apt-repository universe
sudo apt install libfuse2 -y
```  
7. Update whatever you want in Ubuntu Software. For example, GNOME.
8. And the last step is to remove the apps you're not going to use. My list was:
    - Firefox
    - Terminal


And this is the basic setup needed to start ricing the environment.  
And even more important is for you to try and find what works for you.  
Environment setup is like a hobby :)

## Alacritty
I chose Alacritty because it's simple and fast. No tabs, menus or any other distraction.  
The terminal itself is already totally clean and higly customisable.  
With Alacritty already installed, let's customise it.

1. [Install Fish](https://fishshell.com/)
```shell
sudo apt-add-repository ppa:fish-shell/release-3
sudo apt update
sudo apt install fish -y
```  
2. Install Fisher for plugins management
```shell
curl -sL https://raw.githubusercontent.com/jorgebucaran/fisher/main/functions/fisher.fish | source && fisher install jorgebucaran/fisher

Then the theme

fisher install catppuccin/fish
fish_config theme save "Catppuccin Frappe"
```  
3. [Install NeoVim](https://snapcraft.io/nvim)
```shell
sudo snap install nvim --classic
```  
4. [Install Starship](https://starship.rs/guide/#%F0%9F%9A%80-installation)
```shell
curl -sS https://starship.rs/install.sh | sh
```  

## i3wm customisation
1. Install Rofi
```shell
sudo apt install rofi -y
```  
2. Install Screenshot tool
```shell
sudo apt install maim xclip -y
```  
3. Polybar
```shell
sudo apt install polybar -y
```  
4. For the backligh to work, use the following commands:
```shell
Create a file
sudo nvim /etc/udev/rules.d/backlight.rules
Paste the following
ACTION=="add", SUBSYSTEM=="backlight", KERNEL=="intel_backlight", RUN+="/usr/bin/chgrp video /sys/class/backlight/intel_backlight/brightness"
ACTION=="add", SUBSYSTEM=="backlight", KERNEL=="intel_backlight", RUN+="/usr/bin/chmod g+w /sys/class/backlight/intel_backlight/brightness"
sudo usermod -aG video $LOGNAME
reboot
```
