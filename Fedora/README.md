# My Personal Fedora Environment Setup with i3WM
1. Environment
2. What to do after installing Fedora i3 Spin
3. AwesomeWM customisation

Everything is based on my taste and preferences so follow it on your own risk!
Fedora setup below is using Nvidia driver which requires a lot of restarts.

## Environment
- Fedora 40
- AwesomeWM
- Alacritty
    - Fish Shell
    - Starship
    - NeoVim

## What to do after installing FEdora
1. Update to the latest packages and then reboot
```shell
sudo dnf upgrade -y
```  

2. Install Nvidia drivers. Then reboot. After the restart, configure nvidia in the nvidia-settings software and reboot again.
```shell
sudo dnf install https://mirrors.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm https://mirrors.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm
sudo rpm --import https://packages.microsoft.com/keys/microsoft.asc
sudo dnf upgrade -y
sudo dnf install akmod-nvidia \
xorg-x11-drv-nvidia-cuda \
nvidia-vaapi-driver \
libva-utils \
vdpauinfo -y
sudo akmods --force
sudo dracut --force
```

3. Wait for up to 10 minutes and then execute:
```shell
sudo akmods --force
sudo dracut --force
```

4. Create the file /etc/X11/xorg.conf.d/nvidia.conf and paste:
```shell
Section "OutputClass"
	Identifier "nvidia"
	MatchDriver "nvidia-drm"
	Driver "nvidia"
	Option "AllowEmptyInitialConfiguration"
	Option "SLI" "Auto"
	Option "BaseMosaic" "on"
	Option "PrimaryGPU" "yes"
EndSection

Section "ServerLayout"
	Identifier "layout"
	Option "AllowNVIDIAGPUScreens"
EndSection
```

5. Install the needed packages then roboot
```shell
sudo dnf install git \
fish \
alacritty \
blueman \
neovim \
arandr \
flameshot \
network-manager-applet \
code -y

curl -sS https://starship.rs/install.sh | sh
wget https://github.com/ryanoasis/nerd-fonts/releases/download/v3.2.1/Hack.zip
mkdir ~/.fonts
unzip Hack.zip -d ~/.fonts
fc-cache -fv
rm Hack.zip
echo "Xft.dpi: 192

*background: #1e1e2e
*foreground: #cdd6f4
*cursorColor: #f5e0dc

! black
*color0: #45475a
*color8: #585b70

! red
*color1: #f38ba8
*color9: #f38ba8

! green
*color2: #a6e3a1
*color10: #a6e3a1

! yellow
*color3: #f9e2af
*color11: #f9e2af

! blue
*color4: #89b4fa
*color12: #89b4fa

! magenta
*color5: #f5c2e7
*color13: #f5c2e7

! cyan
*color6: #94e2d5
*color14: #94e2d5

! white
*color7: #bac2de
*color15: #a6adc8" | tee .Xresources
```  

5. Eye candy stuff:
    - Catppucchin themes https://github.com/catppuccin
    - Walpapper https://www.pexels.com/photo/rock-formation-close-up-photography-2646237/

6. Coding AI
    - Download https://ollama.com/download
    - Install the model from https://qwen.readthedocs.io/en/latest/run_locally/ollama.html
    - Install the Extension for Jetbrains (available for VSCode as well): https://plugins.jetbrains.com/plugin/22707-continue
        - Guide for configuration https://docs.continue.dev/intro