## Dots for Ubuntu 24

1. Install packages
```shell
sudo add-apt-repository universe -y

# Git
sudo add-apt-repository ppa:git-core/ppa -y

# i3wm
/usr/lib/apt/apt-helper download-file https://debian.sur5r.net/i3/pool/main/s/sur5r-keyring/sur5r-keyring_2024.03.04_all.deb keyring.deb SHA256:f9bb4340b5ce0ded29b7e014ee9ce788006e9bbfe31e96c09b2118ab91fca734
sudo apt install ./keyring.deb
echo "deb http://debian.sur5r.net/i3/ $(grep '^DISTRIB_CODENAME=' /etc/lsb-release | cut -f2 -d=) universe" | sudo tee /etc/apt/sources.list.d/sur5r-i3.list
rm -rf ~/keyring.deb

# Wezterm
curl -fsSL https://apt.fury.io/wez/gpg.key | sudo gpg --yes --dearmor -o /etc/apt/keyrings/wezterm-fury.gpg
echo 'deb [signed-by=/etc/apt/keyrings/wezterm-fury.gpg] https://apt.fury.io/wez/ * *' | sudo tee /etc/apt/sources.list.d/wezterm.list

# Firefox
wget -q https://packages.mozilla.org/apt/repo-signing-key.gpg -O- | sudo tee /etc/apt/keyrings/packages.mozilla.org.asc > /dev/null
echo "deb [signed-by=/etc/apt/keyrings/packages.mozilla.org.asc] https://packages.mozilla.org/apt mozilla main" | sudo tee -a /etc/apt/sources.list.d/mozilla.list > /dev/null
echo '
Package: *
Pin: origin packages.mozilla.org
Pin-Priority: 1000
' | sudo tee /etc/apt/preferences.d/mozilla

# VS Code
sudo apt-get install wget gpg
wget -qO- https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > packages.microsoft.gpg
sudo install -D -o root -g root -m 644 packages.microsoft.gpg /etc/apt/keyrings/packages.microsoft.gpg
echo "deb [arch=amd64,arm64,armhf signed-by=/etc/apt/keyrings/packages.microsoft.gpg] https://packages.microsoft.com/repos/code stable main" |sudo tee /etc/apt/sources.list.d/vscode.list > /dev/null
rm -f packages.microsoft.gpg

sudo apt update -y
sudo apt upgrade -y
sudo ubuntu-drivers install
sudo snap remove firefox
sudo apt remove firefox
snap-store --quit && sudo snap refresh snap-store
sudo snap install nvim --classic

sudo apt install git \
arandr \
libfuse2 \
feh \
lxappearance \
build-essential \
cmake \
wezterm \
firefox \
pavucontrol \
pasystray \
blueman \
code \
i3 -y

sudo apt remove dunst i3lock xss-lock -y

sudo apt autoremove -y

curl -sS https://starship.rs/install.sh | sh

wget https://github.com/ryanoasis/nerd-fonts/releases/download/v3.3.0/Hack.zip
mkdir ~/.fonts
unzip Hack.zip -d ~/.fonts
fc-cache -fv
rm Hack.zip

echo "Xft.dpi: 192
Xcursor.theme: Vimix-cursors" | tee .Xresources

sudo usermod -aG video ${USER}

# ----- Picom
cd ~/Downloads
sudo apt install libconfig-dev libdbus-1-dev libegl-dev libev-dev libgl-dev libepoxy-dev libpcre2-dev libpixman-1-dev libx11-xcb-dev libxcb1-dev libxcb-composite0-dev libxcb-damage0-dev libxcb-glx0-dev libxcb-image0-dev libxcb-present-dev libxcb-randr0-dev libxcb-render0-dev libxcb-render-util0-dev libxcb-shape0-dev libxcb-util-dev libxcb-xfixes0-dev meson ninja-build uthash-dev -y
wget https://github.com/yshui/picom/archive/refs/heads/next.zip
unzip next.zip
cd picom-next
meson setup --buildtype=release build
ninja -C build
ninja -C build install

# ----- Dunst
sudo apt install libdbus-1-dev libx11-dev libxinerama-dev libxrandr-dev libxss-dev libglib2.0-dev \
    libpango1.0-dev libgtk-3-dev libxdg-basedir-dev libgdk-pixbuf-2.0-dev librsvg2-dev libnotify-dev -y
cd ~/Downloads
git clone https://github.com/dunst-project/dunst.git
cd dunst
make
sudo make install

# Wallpaper
curl -L https://gruvbox-wallpapers.pages.dev/wallpapers/irl/kace-rodriguez-p3OzJuT_Dks.jpg -o ~/Pictures/wall.jpg

# Dots Files
cd ~/Downloads
wget https://github.com/marcusmt/env-config/archive/refs/heads/main.zip
unzip main.zip
cp -r env-config-main/i3 ~/.config/
cp -r env-config-main/picom/ ~/.config/
cp -r env-config-main/dunst/ ~/.config/
cp env-config-main/.wezterm.lua ~/
cp -r env-config-main/gtk-3.0 ~/.config
cp -r env-config-main/gtk-4.0 ~/.config
```

2. Eye candy stuff:
    - Mouse Cursor theme: https://www.pling.com/p/1358330
    - Icons: https://www.gnome-look.org/p/1166289
```shell
mkdir ~/.icons
mkdir ~/.themes
tar -xvf ~/Downloads/01-Vimix-cursors.tar.xz -C ~/.icons
tar -xvf ~/Downloads/papirus-icon-theme-20240501.tar.gz -C ~/.icons/
```
