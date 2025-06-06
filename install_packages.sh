#!/usr/bin/env bash
# Install packages required by these dotfiles.

set -e

packages=(hyprland waybar wezterm wofi neovim zsh git stow)

install_with_yay() {
  yay -S --needed "${packages[@]}"
}

install_with_pacman() {
  pacman -S --needed "${packages[@]}"
}

if command -v yay >/dev/null 2>&1; then
  install_with_yay
elif command -v pacman >/dev/null 2>&1; then
  install_with_pacman
else
  echo "Unsupported package manager. Please install: ${packages[*]}" >&2
  exit 1
fi
