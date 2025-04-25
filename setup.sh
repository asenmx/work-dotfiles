#!/bin/bash

if [ "$(id -u)" -ne 0 ]; then
    echo "Please run this script as root or with sudo."
    exit 1
fi

echo "Updating package lists..."
apt-get update

echo "Installing basic dependencies..."
apt-get install -y \
    git \
    curl \
    wget \
    zsh \
    tmux \
    python3-pip \
    python3-venv \
    build-essential \
    cmake \
    pkg-config \
    libfreetype6-dev \
    libfontconfig1-dev \
    libxcb-xfixes0-dev \
    libxkbcommon-dev \
    npm \
    ripgrep \
    fd-find \
    fzf \
    bat \
    exa \
    tree \
    htop \
    silversearcher-ag \
    xclip \
    xsel \
    unzip \
    libxext-dev \
    libxcb1-dev \
    libxcb-damage0-dev \
    libxcb-xfixes0-dev \
    libxcb-shape0-dev \
    libxcb-render-util0-dev \
    libxcb-render0-dev \
    libxcb-randr0-dev \
    libxcb-composite0-dev \
    libxcb-image0-dev \
    libxcb-present-dev \
    libxcb-xinerama0-dev \
    libxcb-glx0-dev \
    libpixman-1-dev \
    libdbus-1-dev \
    libconfig-dev \
    libgl1-mesa-dev \
    libpcre2-dev \
    libpcre3-dev \
    libevdev-dev \
    uthash-dev \
    libev-dev \
    libx11-xcb-dev \
    meson \
    ninja-build \
    picom


echo "Installing latest Neovim..."
curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim.appimage
chmod u+x nvim.appimage
mv nvim.appimage /usr/local/bin/nvim

echo "Installing window manager components..."
apt-get install -y \
    xserver-xorg \
    xinit \
    lightdm \
    bspwm \
    sxhkd \
    polybar \
    dunst \
    rofi \
    compton \
    feh \
    nitrogen \
    arandr \
    thunar \
    lxappearance \
    qt5ct \
    papirus-icon-theme \
    fonts-noto \
    fonts-roboto \
    fonts-material-design-icons-iconfont \
    fonts-font-awesome

echo "Installing greenclip..."
if ! command -v greenclip &> /dev/null; then
    curl -s https://api.github.com/repos/erebe/greenclip/releases/latest | \
    grep "browser_download_url.*amd64" | \
    cut -d '"' -f 4 | \
    wget -qi -
    tar xzf greenclip*.tar.gz
    mv greenclip /usr/local/bin/
    rm greenclip*.tar.gz
fi

echo "Installing fonts..."
mkdir -p /usr/local/share/fonts
cd /usr/local/share/fonts

curl -fLo "Hack NF.ttf" \
"https://github.com/ryanoasis/nerd-fonts/raw/master/patched-fonts/Hack/Regular/complete/Hack%20Regular%20Nerd%20Font%20Complete.ttf"

curl -fLo "Symbols NF.ttf" \
"https://github.com/ryanoasis/nerd-fonts/raw/master/patched-fonts/NerdFontsSymbolsOnly/complete/Symbols-2048-em%20Nerd%20Font%20Complete.ttf"

apt-get install -y fonts-noto-color-emoji

fc-cache -fv

curl -fsSL https://deb.nodesource.com/setup_lts.x | bash -
apt-get install -y nodejs

echo "Installing Neovim plugins dependencies..."
npm install -g tree-sitter-cli
npm install -g prettier
npm install -g eslint

echo "Installing Rust..."
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
source $HOME/.cargo/env

echo "Installing Zsh plugins..."
git clone https://github.com/zsh-users/zsh-autosuggestions /usr/share/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-syntax-highlighting /usr/share/zsh-syntax-highlighting
git clone https://github.com/agkozak/zsh-z /usr/share/zsh-z


echo "Copying configuration files..."
if [ -d ".config" ]; then
    echo "Copying .config folders..."
    mkdir -p ~/.config
    cp -r .config/* ~/.config/
    chown -R $SUDO_USER:$SUDO_USER ~/.config
fi

if [ -f ".bashrc" ]; then
    echo "Copying .bashrc..."
    cp .bashrc ~/
    chown $SUDO_USER:$SUDO_USER ~/.bashrc
fi

if [ -f ".zshrc" ]; then
    echo "Copying .zshrc..."
    cp .zshrc ~/
    chown $SUDO_USER:$SUDO_USER ~/.zshrc
fi

if [ -f ".xresources" ]; then
    echo "Copying .xresources..."
    cp .xresources ~/
    chown $SUDO_USER:$SUDO_USER ~/.xresources
    xrdb -merge ~/.xresources
fi

echo "Cleaning up..."
apt-get autoremove -y

echo "============================================"
echo "All dependencies installed successfully!"
echo "Post-installation steps:"
echo "1. Set lightdm as your display manager:"
echo "   sudo systemctl enable lightdm"
echo "2. Set zsh as your default shell:"
echo "   chsh -s $(which zsh)"
echo "3. Log out and log back in to start bspwm"
echo "4. Run ':PackerSync' in Neovim to install plugins"
echo "============================================"
