#!/bin/bash

# ANSI escape codes for colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
NC='\033[0m' # No Color

# Function to display a header
print_header() {
  echo -e "${YELLOW}==================================================${NC}"
  echo -e "${YELLOW} $* ${NC}"
  echo -e "${YELLOW}==================================================${NC}"
}

# Function to handle package installation
install_packages() {
  print_header "Installing Packages"

  # Dots
  cp -r .config/* $HOME/.config/
  
  wget -O $HOME/Pictures/wall.jpg https://gruvbox-wallpapers.pages.dev/wallpapers/irl/kace-rodriguez-p3OzJuT_Dks.jpg
  sudo sh -c 'echo "GTK_THEME=Adwaita-dark
  QT_QPA_PLATFORMTHEME=qt6ct" >> /etc/environment'

  # Font
  wget https://github.com/ryanoasis/nerd-fonts/releases/download/v3.3.0/Noto.zip -O $HOME/Downloads/Noto.zip
  mkdir $HOME/.fonts
  unzip $HOME/Downloads/Noto.zip -d $HOME/.fonts
  fc-cache -fv
  rm $HOME/Downloads/Noto.zip
  
  # Xorg resolution
  echo "Xft.dpi: 144" | tee $HOME/.Xresources
  
  sudo dnf install -y akmod-nvidia
  
  packages=(
    "dex-autostart"
    "dmenu"
    "feh"
    "gnome-themes-extra"
    "i3"
    "i3status"
    "plasma-workspace-x11"
    "qt6ct"
    "xkill"
  )

  sudo dnf install -y --setopt=install_weak_deps=False "${packages[@]}"
}

# Function to handle system updates
sys_update() {
  print_header "Performing System Update"
  sudo dnf update -y && sudo dnf upgrade -y

  echo -e "${GREEN}System update completed.${NC}"
}

# Function to handle system configuration
configure_system() {
  print_header "Configuring System"
  
  # Add RPMFusion repo
  sudo dnf -y install https://mirrors.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm https://mirrors.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm
  sudo dnf -y config-manager setopt fedora-cisco-openh264.enabled=1

  echo -e "${GREEN}Executing sysupdate as part of configuration.${NC}"
  sys_update

  echo -e "${GREEN}System configuration completed.${NC}"
  
  read -r -p "A restart is required. Proceed? (y/n)" response
  if [[ "$response" =~ ^([yY][eE][sS]|[yY])$ ]]; then
    reboot
  else
    echo "System restart aborted."
  fi
}

# Function to display the helper menu
show_help() {
  echo "Usage: $0 [option]"
  echo "Options:"
  echo "  sysupdate    Perform a full system update (updates packages and system)."
  echo "  appupdate    Update installed applications."
  echo "  install      Install all configured packages."
  echo "  configure    Configure the system (installs tools, sets dotfiles, etc.)."
  echo "  help         Show this help message."
  echo "  menu         Display the interactive menu."
}

# Function to display the interactive menu
show_menu() {
  PS3="Please enter your choice: "
  options=("Configure System" "System Update" "Install Packages" "Exit")
  select opt in "${options[@]}"; do
      case $opt in
          "Configure System")
              configure_system
              ;;
          "System Update")
              sys_update
              ;;
          "Install Packages")
              install_packages
              ;;
          "Exit")
              break
              ;;
          *) echo "invalid option $REPLY";;
      esac
    exit 1
  done
}

# Main script logic
if [ $# -eq 0 ]; then
  show_menu
elif [ "$1" == "help" ]; then
  show_help
else
  case "$1" in
    sysupdate)
      sys_update
      ;;
    appupdate)
      app_update
      ;;
    install)
      install_packages
      ;;
    configure)
      configure_system
      ;;
    menu)
        show_menu
        ;;
    *)
      echo -e "${RED}Error: Invalid option '$1'${NC}"
      show_help
      exit 1
      ;;
  esac
fi

exit 0
