# My Personal Ubuntu Environment Setup with i3WM
1. Environment
2. What to do after installing Ubuntu
3. Alacritty
4. i3wm customisation

Everything is based on my taste and preferences so follow it on your own risk!  

## Environment
- Kubuntu 20.04
- i3WM
    - Rofi
    - Polybar
    - Picom
- Alacritty
    - Fish Shell
    - Starship
    - NeoVim
- Dracula Color Theme

## What to do after installing Ubuntu
1. Ubuntu first steps.
    - Update and upgrade first to get latest packages
    - Check if Nvidia is updated
    - Update Snap packages
    - A fix for AppImages to work
    - Clean packages at the end
```shell
sudo apt update -y
sudo apt upgrade -y
sudo ubuntu-drivers install
sudo add-apt-repository universe
sudo apt install libfuse2 curl pasystray blueman lxappearance cbatticon -y
sudo apt autoremove -y
snap-store --quit && sudo snap refresh snap-store
```  

2. [Install Microsoft Edge](https://www.microsoft.com/en-us/edge/download?form=MA13FJ). Then define it as the default browser.

3. [Install Alacritty](https://snapcraft.io/alacritty)
```shell
sudo snap install alacritty --classic
sudo snap install nvim --classic
sudo apt-add-repository ppa:fish-shell/release-3
sudo apt update
sudo apt install fish
curl -sS https://starship.rs/install.sh | sh
```  

4. [Install a Nerd Font to have icons included](https://www.nerdfonts.com/font-downloads)
    - Hack https://www.programmingfonts.org/#hack
```shell
mkdir ~/.fonts
unzip ~/Downloads/Hack.zip -d ~/.fonts
fc-cache -fv
```  

5. [Install i3wm](https://i3wm.org/docs/repositories.html). Then restart and login with i3.
```shell
/usr/lib/apt/apt-helper download-file https://debian.sur5r.net/i3/pool/main/s/sur5r-keyring/sur5r-keyring_2024.03.04_all.deb keyring.deb SHA256:f9bb4340b5ce0ded29b7e014ee9ce788006e9bbfe31e96c09b2118ab91fca734
sudo apt install ./keyring.deb
echo "deb http://debian.sur5r.net/i3/ $(grep '^DISTRIB_CODENAME=' /etc/lsb-release | cut -f2 -d=) universe" | sudo tee /etc/apt/sources.list.d/sur5r-i3.list
sudo apt update
sudo apt install i3 rofi picom nitrogen maim xclip -y
rm -rf keyring.deb
```  

6. And the last step is to remove the apps you're not going to use.

7. [Build Polybar to get the latest version](https://github.com/polybar/polybar/wiki/Compiling)

8. Eye candy stuff:
    - https://github.com/PapirusDevelopmentTeam/papirus-icon-theme
    - https://github.com/dracula/gtk