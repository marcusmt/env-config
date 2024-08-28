# My Personal Ubuntu Environment Setup with i3WM
1. Environment
2. What to do after installing Ubuntu
3. AwesomeWM customisation

Everything is based on my taste and preferences so follow it on your own risk!  

## Environment
- Ubuntu 24.04 (I prefer Fedora but I have to use Ubuntu because of my work environment...)
- i3
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
    - Reboot
```shell
sudo apt update -y
sudo apt upgrade -y
sudo ubuntu-drivers install
snap-store --quit && sudo snap refresh snap-store
```  

## What to do after installing Ubuntu
2. Install required packages
```shell
sudo add-apt-repository ppa:git-core/ppa -y
sudo apt-add-repository ppa:fish-shell/release-3 -y
sudo add-apt-repository universe -y
/usr/lib/apt/apt-helper download-file https://debian.sur5r.net/i3/pool/main/s/sur5r-keyring/sur5r-keyring_2024.03.04_all.deb keyring.deb SHA256:f9bb4340b5ce0ded29b7e014ee9ce788006e9bbfe31e96c09b2118ab91fca734
sudo apt install ./keyring.deb
echo "deb http://debian.sur5r.net/i3/ $(grep '^DISTRIB_CODENAME=' /etc/lsb-release | cut -f2 -d=) universe" | sudo tee /etc/apt/sources.list.d/sur5r-i3.list
sudo apt install fish \
git \
curl \
build-essential \
arandr \
blueman \
pavucontrol \
pasystray \
brightnessctl \
libfuse2 \
flameshot \
feh
i3 -y
rm -rf keyring.deb
sudo apt remove dunst -y
curl -sS https://starship.rs/install.sh | sh
sudo snap install nvim --classic
sudo snap install alacritty --classic
sudo snap install pinta
wget https://github.com/ryanoasis/nerd-fonts/releases/download/v3.2.1/Hack.zip
mkdir ~/.fonts
unzip Hack.zip -d ~/.fonts
fc-cache -fv
rm Hack.zip
echo "Xft.dpi: 192" | tee .Xresources
sudo apt autoremove -y
sudo usermod -aG video ${USER}
```  

3. [Build Polybar to get the latest version](https://github.com/polybar/polybar/wiki/Compiling)
    - Use the build.sh file instead of the commands described in the GitHub page
```shell
./build.sh --all-features
```  

4. [Build Picom to get the latest version](https://github.com/yshui/picom/tree/stable/11)

5. [Build Dunst to get the latest version](https://github.com/dunst-project/dunst)

6. Eye candy stuff:
    - https://github.com/catppuccin
    - Walpapper https://www.pexels.com/photo/rock-formation-close-up-photography-2646237/

7. Coding AI
    - Download https://ollama.com/download
    - Install the model from https://qwen.readthedocs.io/en/latest/run_locally/ollama.html
    - Install the Extension for Jetbrains (available for VSCode as well): https://plugins.jetbrains.com/plugin/22707-continue
        - Guide for configuration https://docs.continue.dev/intro