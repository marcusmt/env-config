# My Personal Ubuntu Environment Setup with i3WM
1. Environment
2. What to do after installing Ubuntu
3. Alacritty
4. i3wm customisation

Everything is based on my taste and preferences so follow it on your own risk!  

## Environment
- Kubuntu 22.04 (I prefer Fedora but I have to use Ubuntu because of my work environment...)
- i3WM
    - Rofi
    - Polybar
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
    - A fix for AppImages to work and install curl
    - Clean packages at the end
```shell
sudo apt update -y
sudo apt upgrade -y
sudo ubuntu-drivers install
sudo add-apt-repository universe
sudo apt install libfuse2 curl build-essential arandr fzf rofi maim xclip cbatticon blueman pasystray lxappearance -y
sudo snap install nvim --classic
sudo apt autoremove -y
snap-store --quit && sudo snap refresh snap-store
```  

2. [Install a Nerd Font to have icons included](https://www.nerdfonts.com/font-downloads)
    - Hack https://www.programmingfonts.org/#hack
```shell
mkdir ~/.fonts
unzip ~/Downloads/Hack.zip -d ~/.fonts
fc-cache -fv
```  

3. [Install i3wm](https://i3wm.org/docs/repositories.html). Then restart and login with i3.
```shell
/usr/lib/apt/apt-helper download-file https://debian.sur5r.net/i3/pool/main/s/sur5r-keyring/sur5r-keyring_2024.03.04_all.deb keyring.deb SHA256:f9bb4340b5ce0ded29b7e014ee9ce788006e9bbfe31e96c09b2118ab91fca734
sudo apt install ./keyring.deb
echo "deb http://debian.sur5r.net/i3/ $(grep '^DISTRIB_CODENAME=' /etc/lsb-release | cut -f2 -d=) universe" | sudo tee /etc/apt/sources.list.d/sur5r-i3.list
sudo apt update
sudo apt install i3 -y
rm -rf keyring.deb
sudo apt remove dunst
sudo apt autoremove -y
echo "Xft.dpi: 192" | tee .Xresources
```  

4. [Install Alacritty](https://github.com/alacritty/alacritty/blob/master/INSTALL.md)
```shell
sudo add-apt-repository ppa:git-core/ppa
sudo apt-add-repository ppa:fish-shell/release-3
sudo apt update
sudo apt install fish git -y
curl -sS https://starship.rs/install.sh | sh
```  

5. [Build Polybar to get the latest version](https://github.com/polybar/polybar/wiki/Compiling)
    - Use the build.sh file instead of the commands described in the GitHub page
```shell
./build.sh --all-features
```  

6. [Build Picom to get the latest version](https://github.com/yshui/picom/tree/stable/11)

7. [Build Dunst to get the latest version](https://github.com/dunst-project/dunst)

8. Eye candy stuff:
    - https://github.com/catppuccin
    - Walpapper https://4kwallpapers.com/fantasy/lofi-night-city-14857.html