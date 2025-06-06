#!/usr/bin/env bash
# Link dotfile directories into $HOME using GNU Stow

set -e

configs=(hyprland nvim waybar wezterm wofi zsh)

for dir in "${configs[@]}"; do
  stow "$dir"
done
