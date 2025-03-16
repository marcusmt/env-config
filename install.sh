#!/bin/bash

# Configure APT repositories
ppa_list=(
  "ppa:fish-shell/release-3"
  "ppa:git-core/ppa"
  "ppa:graphics-drivers/ppa"
  "universe"
  "ppa:papirus/papirus"
)

repositories=(
 "wezterm-fury https://apt.fury.io/wez/gpg.key https://apt.fury.io/wez/ * *"
)

packages=(
  "arandr"
  "blueman"
  "build-essential"
  "cbatticon"
  "cmake"
  "feh"
  "fish"
  "flameshot"
  "git"
  "i3"
  "libfuse2"
  "libreadline-dev"
  "nvidia-driver-570"
  "Papirus-Dark"
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

sys_update() {
  sudo apt update -y && sudo apt upgrade -y

  wget https://github.com/ryanoasis/nerd-fonts/releases/latest/download/Hack.zip -O $HOME/Downloads/Hack.zip
  mkdir $HOME/.fonts
  unzip $HOME/Downloads/Hack.zip -d $HOME/.fonts
  fc-cache -fv

  # Picom
  cd $HOME/Downloads
  git clone https://github.com/yshui/picom.git
  cd picom
  git checkout stable/12
  meson setup --buildtype=release build
  ninja -C build
  sudo ninja -C build install

  # Dunst
  cd $HOME/Downloads
  git clone https://github.com/dunst-project/dunst.git
  cd dunst
  make
  sudo make install

  # Starship
  curl -sS https://starship.rs/install.sh | sh

  # Zed
  curl -f https://zed.dev/install.sh | sh

  # Neovim
  curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim-linux-x86_64.tar.gz
  sudo rm -rf /opt/nvim
  sudo tar -C /opt -xzf nvim-linux-x86_64.tar.gz

  # Kubectx
  sudo git clone https://github.com/ahmetb/kubectx /opt/kubectx
  sudo ln -s /opt/kubectx/kubectx /usr/local/bin/kubectx
  sudo ln -s /opt/kubectx/kubens /usr/local/bin/kubens
  mkdir -p ~/.config/fish/completions
  ln -s /opt/kubectx/completion/kubectx.fish ~/.config/fish/completions/
  ln -s /opt/kubectx/completion/kubens.fish ~/.config/fish/completions/

  # fzf
  git clone --depth 1 https://github.com/junegunn/fzf.git $HOME/.fzf
  $HOME/.fzf/install --all

  # Clean all
  cd $HOME/Downloads
  rm -rf *
}

configure_system() {
  for ppa in "${ppa_list[@]}"; do
    sudo add-apt-repository -y "$ppa"
  done

  for repo in "${repositories[@]}"; do
    IFS=' ' read -r name key_url source_parts <<< "$repo"
    sudo wget -qO - $key_url | sudo gpg --yes --dearmor -o "/etc/apt/keyrings/${name}.gpg"
    echo "deb [signed-by=/etc/apt/keyrings/${name}.gpg] $source_parts" | sudo tee "/etc/apt/sources.list.d/${name}.list" > /dev/null
  done

  /usr/lib/apt/apt-helper download-file https://debian.sur5r.net/i3/pool/main/s/sur5r-keyring/sur5r-keyring_2025.03.09_all.deb keyring.deb SHA256:2c2601e6053d5c68c2c60bcd088fa9797acec5f285151d46de9c830aaba6173c
  sudo apt install ./keyring.deb
  echo "deb [signed-by=/usr/share/keyrings/sur5r-keyring.gpg] http://debian.sur5r.net/i3/ $(grep '^VERSION_CODENAME=' /etc/os-release | cut -f2 -d=) universe" | sudo tee /etc/apt/sources.list.d/sur5r-i3.list

  sudo apt update -y && sudo apt upgrade -y && sudo ubuntu-drivers install && snap-store --quit && sudo snap refresh snap-store
  sudo apt --purge remove -y '*nvidia*'

  sudo apt install -y "${packages[@]}" "${packages_picom[@]}" "${packages_dunst[@]}"
  sudo snap remove firefox
  sudo apt remove -y firefox gnome-terminal gnome-text-editor dunst i3lock xss-lock

  sudo apt autoremove -y
  sudo apt-mark hold nvidia-driver-570
  echo "Xft.dpi: 192" | tee $HOME/.Xresources

  sudo usermod -aG video ${USER}

  wget -O $HOME/Pictures/wall.jpg https://gruvbox-wallpapers.pages.dev/wallpapers/irl/kace-rodriguez-p3OzJuT_Dks.jpg

  cp -r i3 $HOME/.config/
  cp -r picom/ $HOME/.config/
  cp -r dunst/ $HOME/.config/
  cp -r zed/ $HOME/.config/
  cp .wezterm.lua $HOME
  sudo sed -i "\$aGTK_THEME=\"Adwaita-dark\"" /etc/environment

  # Ripgrep
  wget https://github.com/BurntSushi/ripgrep/releases/latest/download/ripgrep_14.1.1-1_amd64.deb -O $HOME/Downloads/ripgrep_14.1.1-1_amd64.deb
  sudo apt install $HOME/Downloads/ripgrep_14.1.1-1_amd64.deb

  # Lua
  wget https://www.lua.org/ftp/lua-5.4.7.tar.gz -O $HOME/Downloads/lua-5.4.7.tar.gz
  tar -xvf $HOME/Downloads/lua-5.4.7.tar.gz -C $HOME/Downloads
  cd $HOME/Downloads/lua-5.4.7
  make all test
  sudo make install

  wget https://luarocks.github.io/luarocks/releases/luarocks-3.11.1.tar.gz -O $HOME/Downloads/luarocks-3.11.1.tar.gz
  tar -xvf $HOME/Downloads/luarocks-3.11.1.tar.gz -C $HOME/Downloads
  cd $HOME/Downloads/luarocks-3.11.1
  ./configure --with-lua-include=/usr/local/include
  make
  sudo make install
}

show_help() {
  echo "Usage: $0 [option]"
  echo "Options:"
  echo "  sysupdate    Perform a full system update (updates packages and system)."
  echo "  configure    Configure the system (installs tools, sets dotfiles, etc.)."
  echo "  help         Show this help message."
}

case "$1" in
  configure)
    configure_system
    ;;
  sysupdate)
    sys_update
    ;;
  *)
    echo -e "${RED}Error: Invalid option '$1'${NC}"
    show_help
    exit 1
    ;;
esac

exit 0
