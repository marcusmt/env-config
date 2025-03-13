#!/bin/bash

# Configure APT repositories
ppa_list=(
  "ppa:git-core/ppa"
  "ppa:graphics-drivers/ppa"
  "universe"
)

packages=(
  "build-essential"
  "cmake"
  "git"
  "i3"
  "libfuse2"
  "nvidia-driver-570"
)

packages_picom=(
  "libconfig-dev"
  "libdbus-1-dev"
  "libegl-dev"
  "libepoxy-dev"
  "libev-dev"
  "libgl-dev"
  "libpcre2-dev"
  "libpixman-1-dev"
  "libx11-xcb-dev"
  "libxcb-composite0-dev"
  "libxcb-damage0-dev"
  "libxcb-glx0-dev"
  "libxcb-image0-dev"
  "libxcb-present-dev"
  "libxcb-randr0-dev"
  "libxcb-render-util0-dev"
  "libxcb-render0-dev"
  "libxcb-shape0-dev"
  "libxcb-util-dev"
  "libxcb-xfixes0-dev"
  "libxcb1-dev"
  "meson"
  "ninja-build"
  "uthash-dev"
)

packages_dunst=(
  "libgdk-pixbuf-2.0-dev"
  "libglib2.0-dev"
  "libgtk-3-dev"
  "libnotify-dev"
  "libpango1.0-dev"
  "librsvg2-dev"
  "libx11-dev"
  "libxdg-basedir-dev"
  "libxinerama-dev"
  "libxrandr-dev"
  "libxss-dev"
)

for ppa in "${ppa_list[@]}"; do
  sudo add-apt-repository -y "$ppa"
done

/usr/lib/apt/apt-helper download-file https://debian.sur5r.net/i3/pool/main/s/sur5r-keyring/sur5r-keyring_2024.03.04_all.deb $HOME/keyring.deb SHA256:f9bb4340b5ce0ded29b7e014ee9ce788006e9bbfe31e96c09b2118ab91fca734
sudo apt install $HOME/keyring.deb
echo "deb http://debian.sur5r.net/i3/ $(grep '^DISTRIB_CODENAME=' /etc/lsb-release | cut -f2 -d=) universe" | sudo tee /etc/apt/sources.list.d/sur5r-i3.list
rm -rf $HOME/keyring.deb

# System update
sudo apt update -y && sudo apt upgrade -y && sudo ubuntu-drivers install && snap-store --quit && sudo snap refresh snap-store
sudo apt --purge remove -y '*nvidia*'

# Install packages
sudo apt install -y "${packages[@]}" "${packages_picom[@]}" "${packages_dunst[@]}"
sudo snap remove firefox
sudo apt remove -y firefox gnome-terminal gnome-text-editor dunst i3lock xss-lock

wget https://github.com/ryanoasis/nerd-fonts/releases/latest/download/Noto.zip
mkdir $HOME/.fonts
unzip Noto.zip -d $HOME/.fonts
fc-cache -fv
rm Noto.zip

# Picom
cd $HOME/Downloads
git clone https://github.com/yshui/picom.git
cd picom
meson setup --buildtype=release build
ninja -C build
sudo ninja -C build install

# Dunst
cd $HOME/Downloads
git clone https://github.com/dunst-project/dunst.git
cd dunst
make
sudo make install

sudo apt autoremove -y

echo "Xft.dpi: 192" | tee $HOME/.Xresources

sudo usermod -aG video ${USER}

# My Dots
cd $HOME/Downloads/
cp -r env-config-ubuntu-i3/i3 $HOME/.config/
cp -r env-config-ubuntu-i3/picom/ $HOME/.config/
cp -r env-config-ubuntu-i3/dunst/ $HOME/.config/
sudo sed -i "\$aGTK_THEME=\"Adwaita-dark\"" /etc/environment
