#!/bin/bash

# Add RPMFusion repo
sudo dnf -y install https://mirrors.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm https://mirrors.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm
sudo dnf -y config-manager setopt fedora-cisco-openh264.enabled=1


# VS Code
sudo rpm --import https://packages.microsoft.com/keys/microsoft.asc
echo -e "[code]\nname=Visual Studio Code\nbaseurl=https://packages.microsoft.com/yumrepos/vscode\nenabled=1\nautorefresh=1\ntype=rpm-md\ngpgcheck=1\ngpgkey=https://packages.microsoft.com/keys/microsoft.asc" | sudo tee /etc/yum.repos.d/vscode.repo > /dev/null

# Ghostty
sudo dnf -y copr enable pgdev/ghostty

packages=(
  "akmod-nvidia"
  "arandr"
  "blueman"
  "brightnessctl"
  "cbatticon"
  "code"
  "dunst"
  "feh"
  "fish"
  "flameshot"
  "ghostty-git"
  "gnome-session-xsession"
  "i3"
  "k9s"
  "kubectx"
  "libva-utils"
  "neovim"
  "nvidia-vaapi-driver"
  "papirus-icon-theme"
  "pasystray"
  "pavucontrol"
  "picom"
  "vdpauinfo"
  "xfce-polkit"
  "xkill"
  "xorg-x11-drv-nvidia-cuda"
)


# System update
sudo dnf update -y && sudo dnf upgrade -y

# Install packages
sudo dnf install -y "${packages[@]}" "${packages_picom[@]}" "${packages_dunst[@]}"

wget -qO - https://starship.rs/install.sh | sh -s -- -y

git clone --depth 1 https://github.com/junegunn/fzf.git $HOME/.fzf
$HOME/.fzf/install --all

wget https://github.com/ryanoasis/nerd-fonts/releases/latest/download/Hack.zip
mkdir $HOME/.fonts
unzip Hack.zip -d $HOME/.fonts
fc-cache -fv
rm Hack.zip

echo "Xft.dpi: 192" | tee $HOME/.Xresources

sudo usermod -aG video ${USER}

# My Dots
wget -O $HOME/Pictures/wall.jpg https://gruvbox-wallpapers.pages.dev/wallpapers/irl/kace-rodriguez-p3OzJuT_Dks.jpg
cd $HOME/Downloads/env-config-fedora-3
cp -r i3 $HOME/.config/
cp -r picom/ $HOME/.config/
cp -r dunst/ $HOME/.config/
cp -r gtk-3.0/ $HOME/.config/
cp -r gtk-4.0/ $HOME/.config/
sudo sed -i '$aGTK_THEME=Adwaita-dark' /etc/environment