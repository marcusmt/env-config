#!/bin/bash

# Configure APT repositories
ppa_list=(
  "git-core/ppa"
  "graphics-drivers/ppa"
  "papirus/papirus"
  "fish-shell/release-3"
)

repositories=(
 "wezterm-fury https://apt.fury.io/wez/gpg.key https://apt.fury.io/wez/ * *"
 "packages.microsoft https://packages.microsoft.com/keys/microsoft.asc https://packages.microsoft.com/repos/code stable main"
)

packages=(
  "apt-transport-https"
  "arandr"
  "awesome"
  "blueman"
  "build-essential"
  "cmake"
  "code"
  "feh"
  "fish"
  "flameshot"
  "git"
  "lxappearance"
  "papirus-icon-theme"
  "pasystray"
  "pavucontrol"
  "policykit-1-gnome"
  "wezterm"
)

packages_picom=(
  "libconfig-dev"
  "libdbus-1-dev"
  "libegl-dev"
  "libev-dev"
  "libgl-dev"
  "libepoxy-dev"
  "libpcre2-dev"
  "libpixman-1-dev"
  "libx11-xcb-dev"
  "libxcb1-dev"
  "libxcb-composite0-dev"
  "libxcb-damage0-dev"
  "libxcb-glx0-dev"
  "libxcb-image0-dev"
  "libxcb-present-dev"
  "libxcb-randr0-dev"
  "libxcb-render0-dev"
  "libxcb-render-util0-dev"
  "libxcb-shape0-dev"
  "libxcb-util-dev"
  "libxcb-xfixes0-dev"
  "meson"
  "ninja-build"
  "uthash-dev"
)

for ppa in "${ppa_list[@]}"; do
  sudo add-apt-repository -y "ppa:$ppa"
done

for repo in "${repositories[@]}"; do
    IFS=' ' read -r name key_url source_parts <<< "$repo"
    sudo wget -qO - $key_url | sudo gpg --yes --dearmor -o "/etc/apt/keyrings/${name}.gpg"
    echo "deb [signed-by=/etc/apt/keyrings/${name}.gpg] $source_parts" | sudo tee "/etc/apt/sources.list.d/${name}.list" > /dev/null
done

# System update
sudo apt update -y && sudo apt upgrade -y && sudo ubuntu-drivers install && snap-store --quit && sudo snap refresh snap-store

# Install packages
sudo apt install -y "${packages[@]}" "${packages_picom[@]}"

wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb -O chrome.deb
sudo apt install -y ./chrome.deb
rm -rf chrome.deb

wget -O nvim-linux-x86_64.tar.gz https://github.com/neovim/neovim/releases/latest/download/nvim-linux-x86_64.tar.gz
sudo rm -rf /opt/nvim
sudo tar -C /opt -xzf nvim-linux-x86_64.tar.gz
sudo mv /opt/nvim-linux-x86_64 /opt/nvim

wget -qO - https://starship.rs/install.sh | sh -s -- -y

sudo snap remove firefox
sudo apt remove -y firefox

wget https://github.com/ryanoasis/nerd-fonts/releases/download/v3.3.0/Hack.zip
mkdir ~/.fonts
unzip Hack.zip -d ~/.fonts
fc-cache -fv
rm Hack.zip

# Picom
cd ~/Downloads
wget https://github.com/yshui/picom/archive/refs/tags/v12.5.zip
unzip v12.5.zip
cd picom-12.5
meson setup --buildtype=release build
ninja -C build
sudo ninja -C build install

sudo apt autoremove -y

echo "Xft.dpi: 192" | tee .Xresources

sudo usermod -aG video ${USER}

wget -O ~/Pictures/wall.jpg https://gruvbox-wallpapers.pages.dev/wallpapers/irl/kace-rodriguez-p3OzJuT_Dks.jpg

# My Dots
cd ~/Downloads/
cp -r env-config-ubuntu-awesomewm/awesome ~/.config/
cp -r env-config-ubuntu-awesomewm/picom/ ~/.config/
cp -r env-config-ubuntu-awesomewm/fish/ ~/.config/
cp -r env-config-ubuntu-awesomewm/gtk-3.0/ ~/.config/
cp -r env-config-ubuntu-awesomewm/gtk-4.0/ ~/.config/
cp env-config-ubuntu-awesomewm/.wezterm.lua ~/
sudo sed -i "s/^GTK_THEME=.*$/GTK_THEME=\"Adwaita-dark\"/" /etc/environment || sudo sed -i "\$aGTK_THEME=\"Adwaita-dark\"" /etc/environment
