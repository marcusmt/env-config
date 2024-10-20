# My Personal Ubuntu Environment Setup with i3WM
1. Environment
2. What to do after installing Ubuntu
3. AwesomeWM customisation

Everything is based on my taste and preferences so follow it on your own risk!  

## Environment
- Ubuntu 24.04 (I prefer Fedora but I have to use Ubuntu because of my work environment...)
- i3
    - Picom
    - Dunst
- Alacritty
    - Fish Shell
    - Starship
    - NeoVim

## What to do after installing Ubuntu
1. Ubuntu first steps.
    - Update and upgrade to get latest packages
    - Check if Nvidia is updated
    - Reboot
```shell
sudo add-apt-repository ppa:git-core/ppa -y
sudo apt-add-repository ppa:fish-shell/release-3 -y
sudo add-apt-repository universe -y
curl https://baltocdn.com/i3-window-manager/signing.asc | sudo apt-key add -
sudo apt install apt-transport-https --yes
echo "deb https://baltocdn.com/i3-window-manager/i3/i3-autobuild-ubuntu/ all main" | sudo tee /etc/apt/sources.list.d/i3-autobuild.list
sudo apt update -y
sudo apt upgrade -y
sudo ubuntu-drivers install
snap-store --quit && sudo snap refresh snap-store
```  

## What to do after installing Ubuntu
2. Install required packages
```shell
sudo apt install fish \
git \
arandr \
blueman \
brightnessctl \
libfuse2 \
flameshot \
feh \
lxappearance \
build-essential \
cmake \
i3 -y

curl -sS https://starship.rs/install.sh | sh
sudo snap install nvim --classic

wget https://github.com/ryanoasis/nerd-fonts/releases/download/v3.2.1/Hack.zip
mkdir ~/.fonts
unzip Hack.zip -d ~/.fonts
fc-cache -fv
rm Hack.zip

echo "Xft.dpi: 192" | tee .Xresources
sudo apt autoremove -y

sudo usermod -aG video ${USER}
```  

3. [Build Picom to get the latest version](https://github.com/yshui/picom/tree/stable/11)

4. [Build Dunst to get the latest version](https://github.com/dunst-project/dunst)

5. [Build Alacritty](https://github.com/alacritty/alacritty/blob/master/INSTALL.md)

6. Eye candy stuff:
    - https://github.com/catppuccin
    - Walpapper https://www.pexels.com/photo/rock-formation-close-up-photography-2646237/

7. Coding AI
    - Download https://ollama.com/download
    - Install the model from https://qwen.readthedocs.io/en/latest/run_locally/ollama.html
    - Install the Extension for Jetbrains (available for VSCode as well): https://plugins.jetbrains.com/plugin/22707-continue
        - Guide for configuration https://docs.continue.dev/intro