# CLAUDE.md

## Project Purpose

Personal dotfiles for Arch Linux with Hyprland, managed with GNU Stow.

## Core Components

- **hypr/** - Hyprland window manager, hyprlock, hyprpaper
- **waybar/** - Status bar with modular config
- **walker/** - Application launcher (with Elephant backend)
- **mako/** - Notifications
- **wezterm/** - Terminal
- **nvim/** - Neovim (LazyVim)
- **zsh/** - Shell config
- **tmux/** - Terminal multiplexer
- **scripts/** - Custom scripts in ~/.local/bin
- **apps/** - Desktop entries and hidden app overrides
- **claude/** - Claude Code settings
- **install.sh** - Full system setup script

## When Making Changes

### Modifying existing config
1. Edit files in `~/dotfiles/<package>/`
2. Changes apply immediately (symlinked)
3. Commit changes

### Adding new config
1. Create package structure: `mkdir -p ~/dotfiles/newpkg/.config`
2. Move config: `mv ~/.config/newpkg ~/dotfiles/newpkg/.config/`
3. Stow it: `cd ~/dotfiles && stow newpkg`
4. Update `README.md` - add package section
5. Update `install.sh` - add to PACMAN_PKGS/AUR_PKGS and STOW_PKGS
6. Commit changes

### Adding new scripts
1. Add script to `scripts/.local/bin/`
2. Make executable: `chmod +x`
3. Update `README.md` scripts table
4. Commit changes
