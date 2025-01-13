## What to do after installing Fedora
1. Update to the latest packages and then reboot
```shell
sudo dnf upgrade -y
reboot
```

2. Install Nvidia drivers.
It's better to do it manually checking if the guides were updated and if the new driver version is adding a new property
https://wiki.archlinux.org/title/NVIDIA/Troubleshooting#Avoid_screen_tearing
https://rpmfusion.org/Howto/NVIDIA
Include the ForceFullCompositionPipeline=On and the properties
```shell
Section "OutputClass"
	Identifier "nvidia"
	MatchDriver "nvidia-drm"
	Driver "nvidia"
	Option "AllowEmptyInitialConfiguration"
	Option "SLI" "Auto"
	Option "BaseMosaic" "on"
	Option "PrimaryGPU" "yes"
EndSection

Section "ServerLayout"
	Identifier "layout"
	Option "AllowNVIDIAGPUScreens"
EndSection
```

3. Install Zed
```shell
cd ~
curl -f https://zed.dev/install.sh | sh
```

4. Install Ghostty
```shell
sudo dnf copr enable pgdev/ghostty
sudo dnf install ghostty
```

5. Install the needed packages then roboot
```shell
sudo dnf install git \
arandr \
xorg-x11-server-Xorg \
picom \
feh \
dunst \
i3 -y

sudo dnf remove i3lock xss-lock

wget https://github.com/ryanoasis/nerd-fonts/releases/download/v3.3.0/Hack.zip
mkdir ~/.fonts
unzip Hack.zip -d ~/.fonts
fc-cache -fv
rm Hack.zip

echo "Xft.dpi: 192" | tee .Xresources
```

6. Copy configuration files
```shell
cd ~/Downloads
wget https://github.com/marcusmt/env-config/archive/refs/heads/main.zip
unzip main.zip
cp -r env-config-main/zed/ ~/.config/
cp -r env-config-main/ghostty/ ~/.config/
cp -r env-config-main/i3/ ~/.config/
cp -r env-config-main/dunst/ ~/.config/
```

7. Coding AI
    - Download https://ollama.com/download
    - Install the model from https://qwen.readthedocs.io/en/latest/run_locally/ollama.html
    - Install the Extension for Jetbrains (available for VSCode as well): https://plugins.jetbrains.com/plugin/22707-continue
        - Guide for configuration https://docs.continue.dev/intro
