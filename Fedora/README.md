# My Personal Fedora Environment Setup with i3WM
1. Environment
2. What to do after installing Fedora i3 Spin
3. AwesomeWM customisation

Everything is based on my taste and preferences so follow it on your own risk!
Fedora setup below is using Nvidia driver which requires a lot of restarts.

## Environment
- Fedora 40
- i3
    - Rofi
    - Picom
    - Dunst
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
sudo dnf upgrade -y
sudo dnf install akmod-nvidia \
xorg-x11-drv-nvidia-cuda \
nvidia-vaapi-driver \
libva-utils \
vdpauinfo -y
sudo akmods --force
sudo dracut --force
```

```shell
sudo cp -p /usr/share/X11/xorg.conf.d/nvidia.conf /etc/X11/xorg.conf.d/nvidia.conf
then add the property below in Section "OutputClass"
Option "PrimaryGPU" "yes"
```

4. Install the needed packages then roboot
```shell
wget -O code.rpm "https://code.visualstudio.com/sha/download?build=stable&os=linux-rpm-x64"
sudo dnf install ./code.rpm -y
rm -rf code.rpm

sudo dnf install git \
fish \
alacritty \
blueman \
picom \
polybar \
rofi \
neovim \
pasystray \
dunst \
arandr \
flameshot \
feh \
thunar \
i3 -y

curl -sS https://starship.rs/install.sh | sh
wget https://github.com/ryanoasis/nerd-fonts/releases/download/v3.2.1/Hack.zip
mkdir ~/.fonts
unzip Hack.zip -d ~/.fonts
fc-cache -fv
rm Hack.zip
echo "Xft.dpi: 192" | tee .Xresources
```  

5. Eye candy stuff:
    - Themes from Dracula: https://draculatheme.com/
    - When installing GTK, put everything in the .config folder as well: https://draculatheme.com/gtk
    - Walpapper https://4kwallpapers.com/fantasy/lofi-night-city-14857.html

6. Coding AI
    - Download https://ollama.com/download
    - Install the model from https://qwen.readthedocs.io/en/latest/run_locally/ollama.html
    - Install the Extension for Jetbrains (available for VSCode as well): https://plugins.jetbrains.com/plugin/22707-continue
        - Guide for configuration https://docs.continue.dev/intro