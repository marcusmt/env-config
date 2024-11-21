# My Personal Ubuntu Environment Setup with i3WM
1. Environment
2. What to do after installing Ubuntu
3. Alacritty
4. i3wm customisation

Everything is based on my taste and preferences so follow it on your own risk!  

## Environment
- Ubuntu 22.04 (I prefer Fedora but I have to use Ubuntu because of my work environment...)
- i3WM
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
flameshot \
feh \
libfuse2 \
curl \
build-essential \
arandr \
lxappearance \
policykit-1-gnome \
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

echo "Xft.dpi: 192" | tee .Xresources
```  


3. [Build Picom to get the latest version](https://github.com/yshui/picom/tree/stable/11)

4. [Build Dunst to get the latest version](https://github.com/dunst-project/dunst)

5. [Build Alacritty](https://github.com/alacritty/alacritty/blob/master/INSTALL.md)

6. Eye candy stuff:
    - https://draculatheme.com/
    - Walpapper https://4kwallpapers.com/black-dark/dark-abstract-18134.html

