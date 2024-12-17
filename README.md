## Dots for Ubuntu 24

## What to do after installing Ubuntu
1. Ubuntu first steps.
    - Update and upgrade to get latest packages
    - Check if Nvidia is updated
    - Reboot
```shell
sudo add-apt-repository universe -y
sudo apt update -y
sudo apt upgrade -y
sudo ubuntu-drivers install
snap-store --quit && sudo snap refresh snap-store
```

2. Install required packages
```shell
# needed ppas for latest packages
sudo add-apt-repository ppa:git-core/ppa -y

# i3wm
/usr/lib/apt/apt-helper download-file https://debian.sur5r.net/i3/pool/main/s/sur5r-keyring/sur5r-keyring_2024.03.04_all.deb keyring.deb SHA256:f9bb4340b5ce0ded29b7e014ee9ce788006e9bbfe31e96c09b2118ab91fca734
sudo apt install ./keyring.deb
echo "deb http://debian.sur5r.net/i3/ $(grep '^DISTRIB_CODENAME=' /etc/lsb-release | cut -f2 -d=) universe" | sudo tee /etc/apt/sources.list.d/sur5r-i3.list

# wezterm
curl -fsSL https://apt.fury.io/wez/gpg.key | sudo gpg --yes --dearmor -o /etc/apt/keyrings/wezterm-fury.gpg
echo 'deb [signed-by=/etc/apt/keyrings/wezterm-fury.gpg] https://apt.fury.io/wez/ * *' | sudo tee /etc/apt/sources.list.d/wezterm.list

sudo apt update -y

sudo apt install git \
arandr \
libfuse2 \
flameshot \
feh \
lxappearance \
build-essential \
cmake \
policykit-1-gnome \
wezterm \
pasystray \
pavucontrol \
i3 -y

sudo apt remove dunst i3lock

curl -sS https://starship.rs/install.sh | sh
sudo snap install nvim --classic

wget https://github.com/ryanoasis/nerd-fonts/releases/download/v3.2.1/Hack.zip
mkdir ~/.fonts
unzip Hack.zip -d ~/.fonts
fc-cache -fv
rm Hack.zip

echo "Xft.dpi: 192
Xcursor.theme: Vimix-cursors" | tee .Xresources
sudo apt autoremove -y

sudo usermod -aG video ${USER}

# Compile applications and install them

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
cp -r env-config-main/.config/i3 ~/.config/
cp -r env-config-main/.config/picom/ ~/.config/
cp -r env-config-main/.config/dunst/ ~/.config/
cp env-config-main/.config/.wezterm.lua ~/
```

6. Eye candy stuff:
    - GTK theme: https://www.pling.com/p/1681313/
    - Mouse Cursor theme: https://www.pling.com/p/1358330
    - Icons: https://www.pling.com/p/1209330
```shell
mkdir ~/.icons
mkdir ~/.themes
tar -xvf ~/Downloads/01-Vimix-cursors.tar.xz -C ~/.icons
tar -xvf ~/Downloads/Zafiro-Icons-Dark-Black-f.tar.xz -C ~/.icons/
unzip ~/Downloads/Gruvbox-Dark-Soft-BL-LB.zip -d ~/.themes/
cp -r ~/.themes/Gruvbox-Dark-Soft/gtk-4.0/ ~/.config/
```
