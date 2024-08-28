# My Personal Fedora Environment Setup with i3WM
1. Environment
2. What to do after installing Fedora i3 Spin
3. AwesomeWM customisation

Everything is based on my taste and preferences so follow it on your own risk!  

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
sudo dnf upgrade
```  

2. Install Nvidia drivers and configure it. Then reboot
```shell
sudo dnf install https://mirrors.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm https://mirrors.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm
sudo dnf config-manager --enable fedora-cisco-openh264
sudo dnf install akmod-nvidia \
xorg-x11-drv-nvidia-cuda \
nvidia-vaapi-driver \
libva-utils \
vdpauinfo
sudo akmods --force
sudo dracut --force
echo "Xft.dpi: 192" | tee .Xresources
```  

3. Open the nvidia-settings and configure the monitors accordingly then copy the default config
```shell
sudo cp -p /usr/share/X11/xorg.conf.d/nvidia.conf /etc/X11/xorg.conf.d/nvidia.conf
```  

then paste the configuration from nvidia-settings into it adding the folling line to the OutputClass section of it.:

```shell
Option "PrimaryGPU" "yes"
```  

reboot again to make the settings available

4. Install the needed packages
```shell
sudo dnf install git \
fish \
alacritty \
blueman \
pasystray \
picom \
polybar \
rofi \
neovim -y
curl -sS https://starship.rs/install.sh | sh
wget https://github.com/ryanoasis/nerd-fonts/releases/download/v3.2.1/Hack.zip
mkdir ~/.fonts
unzip Hack.zip -d ~/.fonts
fc-cache -fv
rm Hack.zip
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