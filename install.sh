#!/bin/bash

# Dotfiles install script for Arch Linux
# Run this on a fresh Arch install after base system is set up

set -e

echo "=== Dotfiles Install Script ==="
echo ""

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

info() { echo -e "${GREEN}[INFO]${NC} $1"; }
warn() { echo -e "${YELLOW}[WARN]${NC} $1"; }
error() { echo -e "${RED}[ERROR]${NC} $1"; exit 1; }

# Check if running as root
if [[ $EUID -eq 0 ]]; then
    error "Don't run this script as root. It will use sudo when needed."
fi

# ============================================
# Pacman packages
# ============================================

info "Installing pacman packages..."

PACMAN_PKGS=(
    # Base development (needed for yay)
    base-devel
    git
    go

    # Shell & terminal
    zsh
    tmux
    wezterm

    # Hyprland & Wayland
    hyprland
    hyprlock
    hyprpaper
    hyprshot
    xdg-desktop-portal-hyprland
    qt5-wayland
    qt6-wayland
    grim
    slurp

    # Bar, launcher, notifications
    waybar
    mako

    # Session management
    greetd
    uwsm
    polkit-kde-agent

    # Editor
    neovim

    # File manager
    dolphin

    # Browser
    chromium

    # CLI tools
    bat
    btop
    eza
    fd
    fzf
    lazygit
    zoxide
    stow
    wget
    gum
    uv

    # Audio (PipeWire)
    pipewire
    pipewire-alsa
    pipewire-jack
    pipewire-pulse
    wireplumber
    libpulse

    # Multimedia
    gst-libav
    gst-plugin-pipewire
    gst-plugins-bad
    gst-plugins-good
    gst-plugins-ugly

    # Fonts
    ttf-jetbrains-mono
    ttf-jetbrains-mono-nerd
    noto-fonts
    noto-fonts-emoji
    otf-font-awesome

    # Networking
    networkmanager
    network-manager-applet

    # Misc
    man-db
    man-pages
    xdg-utils
    zram-generator
)

sudo pacman -S --needed "${PACMAN_PKGS[@]}"

# ============================================
# Install yay (AUR helper)
# ============================================

if ! command -v yay &> /dev/null; then
    info "Installing yay..."

    TEMP_DIR=$(mktemp -d)
    cd "$TEMP_DIR"

    git clone https://aur.archlinux.org/yay.git
    cd yay
    makepkg -si --noconfirm

    cd ~
    rm -rf "$TEMP_DIR"
else
    info "yay already installed, skipping..."
fi

# ============================================
# AUR packages
# ============================================

info "Installing AUR packages..."

AUR_PKGS=(
    walker
    elephant
    elephant-calc
    elephant-desktopapplications
    elephant-files
    elephant-providerlist
    elephant-runner
    elephant-websearch
)

yay -S --needed "${AUR_PKGS[@]}"

# ============================================
# Stow dotfiles
# ============================================

info "Stowing dotfiles..."

cd ~/dotfiles

STOW_PKGS=(
    hypr
    waybar
    walker
    mako
    wezterm
    nvim
    zsh
    tmux
    scripts
    apps
    claude
)

for pkg in "${STOW_PKGS[@]}"; do
    if [[ -d "$pkg" ]]; then
        info "Stowing $pkg..."
        stow "$pkg"
    else
        warn "Package $pkg not found, skipping..."
    fi
done

# ============================================
# Post-install configuration
# ============================================

info "Post-install configuration..."

# Set zsh as default shell
if [[ "$SHELL" != *"zsh"* ]]; then
    info "Setting zsh as default shell..."
    chsh -s $(which zsh)
fi

# Enable services
info "Enabling services..."
sudo systemctl enable greetd
sudo systemctl enable NetworkManager

# Create greetd config for auto-login
info "Configuring greetd..."
sudo tee /etc/greetd/config.toml > /dev/null << EOF
[terminal]
vt = 1

[default_session]
command = "uwsm start hyprland-uwsm.desktop"
user = "$USER"
EOF

# ============================================
# Done
# ============================================

echo ""
info "Installation complete!"
echo ""
echo "Next steps:"
echo "  1. Reboot to start Hyprland via greetd"
echo "  2. Run 'restart-walker' after first login to initialize the launcher"
echo ""
