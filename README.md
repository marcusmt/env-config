# Dots for Fedora 41
```shell
cd ~/Downloads
wget https://github.com/marcusmt/env-config/archive/refs/heads/fedora-i3.zip
unzip fedora-i3.zip
cd env-config-fedora-i3/
./install.sh
```

## To change Plymouth screen:
1. Change the configuration in /usr/share/plymouth
2. Run the command to update:
```shell
sudo plymouth-set-default-theme -R bgrt
```
