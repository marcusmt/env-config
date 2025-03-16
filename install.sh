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

configure_system() {
  print_header "Configuring System"

  # Dots
  cp -r .config/* $HOME/.config/
  
  # Add RPMFusion repo
  sudo dnf -y install https://mirrors.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm https://mirrors.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm
  sudo dnf -y config-manager setopt fedora-cisco-openh264.enabled=1

  # VS Code
  sudo rpm --import https://packages.microsoft.com/keys/microsoft.asc
  echo -e "[code]\nname=Visual Studio Code\nbaseurl=https://packages.microsoft.com/yumrepos/vscode\nenabled=1\nautorefresh=1\ntype=rpm-md\ngpgcheck=1\ngpgkey=https://packages.microsoft.com/keys/microsoft.asc" | sudo tee /etc/yum.repos.d/vscode.repo > /dev/null

  # Ghostty
  dnf copr enable pgdev/ghostty

  sudo dnf update -y && sudo dnf upgrade -y

  sudo dnf install -y akmod-nvidia git ghostty fish

  echo -e "${GREEN}System configuration completed.${NC}"
  
  read -r -p "A restart is required. Proceed? (y/n)" response
  if [[ "$response" =~ ^([yY][eE][sS]|[yY])$ ]]; then
    reboot
  else
    echo "System restart aborted."
  fi
}