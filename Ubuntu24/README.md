# My Personal Ubuntu Environment Setup with i3WM
1. Environment
2. What to do after installing Ubuntu
3. AwesomeWM customisation

Everything is based on my taste and preferences so follow it on your own risk!  

## Environment
- Ubuntu 24.04

## What to do after installing Ubuntu
1. Ubuntu first steps.
    - Update and upgrade to get latest packages
    - Check if Nvidia is updated
    - Install needed packages
    - Configure environment
    - Reboot
```shell
sudo add-apt-repository universe -y
sudo add-apt-repository ppa:git-core/ppa -y

sudo apt update -y
sudo apt upgrade -y
sudo ubuntu-drivers install

sudo apt install awesome \
pasystray \
pavucontrol \
git \
arandr \
lxappearance \
libfuse2 -y

sudo apt autoremove -y

snap-store --quit && sudo snap refresh snap-store
sudo snap install nvim --classic

echo "Xft.dpi: 192" | tee .Xresources
sudo usermod -aG video ${USER}

wget https://github.com/ryanoasis/nerd-fonts/releases/download/v3.3.0/Hack.zip
mkdir ~/.fonts
unzip Hack.zip -d ~/.fonts
fc-cache -fv
rm Hack.zip

curl -sS https://starship.rs/install.sh | sh
```  

2. Eye candy stuff:
    - GTK theme: https://www.pling.com/p/1681313/
    - Mouse Cursor theme: https://www.pling.com/p/1358330
    - Icons: https://www.pling.com/p/1209330
    - Walpapper https://gruvbox-wallpapers.pages.dev/wallpapers/irl/kace-rodriguez-p3OzJuT_Dks.jpg

3. Coding AI
    - Download https://ollama.com/download
    - Install the model from https://qwen.readthedocs.io/en/latest/run_locally/ollama.html
    - Install the Extension for Jetbrains (available for VSCode as well): https://plugins.jetbrains.com/plugin/22707-continue
        - Guide for configuration https://docs.continue.dev/intro
