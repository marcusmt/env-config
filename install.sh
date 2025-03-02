#!/bin/bash

sudo pacman -Syu --noconfirm --needed \
arandr \
base-devel \
blueman \
bluez \
bluez-utils \
brightnessctl \
cbatticon \
dunst \
feh \
fish \
flameshot \
fprintd \
fuse2 \
git \
gnome-themes-extra \
jq \
k9s \
kubectx \
less \
neovim \
nvidia-settings \
pasystray \
pavucontrol \
picom \
polkit-gnome \
starship \
unzip \
xorg-xrandr \
xorg-xkill

systemctl enable bluetooth
systemctl start bluetooth

cd $HOME/Downloads
git clone https://aur.archlinux.org/yay.git
cd yay
makepkg -si --noconfirm
cd ..

rm -rf *
yay -S --noconfirm google-chrome

git clone --depth 1 https://github.com/junegunn/fzf.git $HOME/.fzf
$HOME/.fzf/install --all

wget https://github.com/ryanoasis/nerd-fonts/releases/latest/download/Hack.zip
mkdir $HOME/.fonts
unzip Hack.zip -d $HOME/.fonts
fc-cache -fv
rm Hack.zip

wget -qO- https://git.io/papirus-icon-theme-install | sh
echo "Xft.dpi: 192" >> $HOME/.Xresources
sudo sed -i "\$aGTK_THEME=\"Adwaita-dark\"" /etc/environment
wget -O $HOME/Pictures/wall.jpg https://gruvbox-wallpapers.pages.dev/wallpapers/irl/kace-rodriguez-p3OzJuT_Dks.jpg
cd $HOME/Downloads/

# Need to test this in next setup
cp -r env-config-arch-i3/i3 $HOME/.config/
cp -r env-config-arch-i3/picom $HOME/.config/
cp -r env-config-arch-i3/dunst $HOME/.config/
cp -r env-config-arch-i3/fish $HOME/.config/
cp -r env-config-arch-i3/.wezterm.lua $HOME/
