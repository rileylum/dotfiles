# Dotfiles

This repository contains configuration files (dotfiles) for my Wayland desktop environment built around [Hyprland](https://github.com/hyprwm/Hyprland).  It includes setups for

- **Hyprland** – window manager
- **Waybar** – status bar
- **WezTerm** – terminal emulator
- **Wofi** – application launcher
- **Neovim** – text editor
- **Zsh** – shell configuration

The directory layout mirrors the XDG base directory structure. Each component has its files inside the corresponding `*/.config/*` path so they can be linked directly into your home directory. GNU Stow is used to manage these symlinks.

## Setup

1. Clone the repository somewhere on your system:
   ```bash
   git clone https://github.com/rileylum/dotfiles ~/.dotfiles
   cd ~/.dotfiles
   ```
2. Install the required packages using the provided script:
    ```bash
    ./install_packages.sh
    ```
3. Run the provided Stow script to link the configuration directories into your home directory:
   ```bash
   ./stow_dotfiles.sh
   ```
4. Start a new session or reload your shell to use the Zsh configuration.
