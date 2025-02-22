#!/bin/bash

# Configure APT repositories
ppa_list=(
  "ppa:fish-shell/release-3"
  "ppa:git-core/ppa"
  "ppa:graphics-drivers/ppa"
  "ppa:papirus/papirus"
  "universe"
)

repositories=(
 "packages.microsoft https://packages.microsoft.com/keys/microsoft.asc https://packages.microsoft.com/repos/code stable main"
 "wezterm-fury https://apt.fury.io/wez/gpg.key https://apt.fury.io/wez/ * *"
)

packages=(
  "apt-transport-https"
  "arandr"
  "blueman"
  "brightnessctl"
  "build-essential"
  "cmake"
  "code"
  "feh"
  "fish"
  "flameshot"
  "git"
  "i3"
  "libfuse2"
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

for repo in "${repositories[@]}"; do
    IFS=' ' read -r name key_url source_parts <<< "$repo"
    sudo wget -qO - $key_url | sudo gpg --yes --dearmor -o "/etc/apt/keyrings/${name}.gpg"
    echo "deb [signed-by=/etc/apt/keyrings/${name}.gpg] $source_parts" | sudo tee "/etc/apt/sources.list.d/${name}.list" > /dev/null
done

sudo apt --purge remove -y '*nvidia*'

# System update
sudo apt update -y && sudo apt upgrade -y && sudo ubuntu-drivers install && snap-store --quit && sudo snap refresh snap-store

# Install packages
sudo apt install -y "${packages[@]}" "${packages_picom[@]}" "${packages_dunst[@]}"

wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb -O chrome.deb
sudo apt install -y ./chrome.deb
rm -rf chrome.deb

wget -O nvim-linux-x86_64.tar.gz https://github.com/neovim/neovim/releases/latest/download/nvim-linux-x86_64.tar.gz
sudo rm -rf /opt/nvim
sudo tar -C /opt -xzf nvim-linux-x86_64.tar.gz
sudo mv /opt/nvim-linux-x86_64 /opt/nvim

wget -qO - https://starship.rs/install.sh | sh -s -- -y
echo "starship init fish | source" >> $HOME/.config/fish/config.fish

git clone --depth 1 https://github.com/junegunn/fzf.git $HOME/.fzf
$HOME/.fzf/install --all

wget https://github.com/ryanoasis/nerd-fonts/releases/latest/download/Hack.zip
mkdir $HOME/.fonts
unzip Hack.zip -d $HOME/.fonts
fc-cache -fv
rm Hack.zip

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

sudo snap remove firefox
sudo apt remove -y firefox gnome-terminal gnome-text-editor dunst i3lock xss-lock
sudo apt autoremove -y

echo "Xft.dpi: 192" | tee $HOME/.Xresources

sudo usermod -aG video ${USER}

# My Dots
wget -O $HOME/Pictures/wall.jpg https://gruvbox-wallpapers.pages.dev/wallpapers/irl/kace-rodriguez-p3OzJuT_Dks.jpg
cd $HOME/Downloads/
cp -r env-config-ubuntu-i3/i3 $HOME/.config/
cp -r env-config-ubuntu-i3/picom/ $HOME/.config/
cp -r env-config-ubuntu-i3/dunst/ $HOME/.config/
cp -r env-config-ubuntu-i3/gtk-3.0/ $HOME/.config/
cp -r env-config-ubuntu-i3/gtk-4.0/ $HOME/.config/
cp env-config-ubuntu-i3/.wezterm.lua $HOME/
sudo sed -i "s/^GTK_THEME=.*$/GTK_THEME=\"Adwaita-dark\"/" /etc/environment || sudo sed -i "\$aGTK_THEME=\"Adwaita-dark\"" /etc/environment
