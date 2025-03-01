#!/bin/bash

sudo pacman -Syu --noconfirm
sudo pacman -S --noconfirm --needed base-devel nvidia-settings git

cd $HOME/Downloads
git clone https://aur.archlinux.org/yay.git
cd yay
makepkg -si --noconfirm
cd ..

curl -sS https://downloads.1password.com/linux/keys/1password.asc | gpg --import
git clone https://aur.archlinux.org/1password.git
cd 1password
makepkg -si --noconfirm
cd ..

rm -rf *
yay -S --noconfirm google-chrome

# Kwallet config for keyring to work
mkdir -p $HOME/.local/share/dbus-1/services/
echo "[D-BUS Service]
Name=org.freedesktop.secrets
Exec=/usr/bin/kwalletd6" >> $HOME/.local/share/dbus-1/services/org.freedesktop.secrets.service

echo "Xft.dpi: 192" >> $HOME/.Xresources