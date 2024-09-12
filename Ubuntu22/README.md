# My Personal Ubuntu Environment Setup with i3WM
1. Environment
2. What to do after installing Ubuntu
3. Alacritty
4. i3wm customisation

Everything is based on my taste and preferences so follow it on your own risk!  

## Environment
- Ubuntu 22.04 (I prefer Fedora but I have to use Ubuntu because of my work environment...)
- i3WM
    - Rofi
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
    - A fix for AppImages to work
    - Clean packages at the end
    - I recommend a reboot after this step
```shell
sudo add-apt-repository universe

sudo apt update -y
sudo apt upgrade -y
sudo ubuntu-drivers install

snap-store --quit && sudo snap refresh snap-store
```  

2. Configure PPAs and install all required packages
    - i3WM development package is used below
```shell
curl https://baltocdn.com/i3-window-manager/signing.asc | sudo apt-key add -
sudo apt install apt-transport-https --yes
echo "deb https://baltocdn.com/i3-window-manager/i3/i3-autobuild-ubuntu/ all main" | sudo tee /etc/apt/sources.list.d/i3-autobuild.list
sudo add-apt-repository ppa:git-core/ppa
sudo apt-add-repository ppa:fish-shell/release-3

sudo apt update

sudo apt install fzf \
blueman \
fish \
git \
pasystray \
flameshot \
feh \
thunar \
rofi \
cbatticon \
libfuse2 \
curl \
build-essential \
arandr \
i3 -y

sudo apt remove dunst -y
sudo apt autoremove -y

curl -sS https://starship.rs/install.sh | sh

sudo snap install nvim --classic

wget https://github.com/ryanoasis/nerd-fonts/releases/download/v3.2.1/Hack.zip
mkdir ~/.fonts
unzip Hack.zip -d ~/.fonts
fc-cache -fv
rm Hack.zip

echo "inode/directory=thunar.desktop
x-directory/normal=thunar.desktop" | tee ~/.local/share/applications/mimeapps.list
echo "Xft.dpi: 192" | tee .Xresources
```  


3. [Build Picom to get the latest version](https://github.com/yshui/picom/tree/stable/11)

4. [Build Dunst to get the latest version](https://github.com/dunst-project/dunst)

5. [Build Alacritty](https://github.com/alacritty/alacritty/blob/master/INSTALL.md)

6. Eye candy stuff:
    - https://github.com/catppuccin
    - Walpapper https://4kwallpapers.com/fantasy/lofi-night-city-14857.html

7. Coding IA
    - Download https://ollama.com/download
    - Install the model from https://qwen.readthedocs.io/en/latest/run_locally/ollama.html
    - Install the Extension for Jetbrains (available for VSCode as well): https://plugins.jetbrains.com/plugin/22707-continue
        - Guide for configuration https://docs.continue.dev/intro
