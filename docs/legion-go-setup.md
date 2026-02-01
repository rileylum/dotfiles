# Legion Go Arch Linux Dual-Mode Setup

Transform your Legion Go into a dual-mode system with **Desktop Mode** (Hyprland) and **Gaming Mode** (SteamOS-like Gamescope session).

## Architecture Overview

```
┌─────────────────────────────────────────────────────────────┐
│                         SDDM                                │
│                   (Display Manager)                         │
│              ┌──────────┴──────────┐                        │
│              ▼                     ▼                        │
│     ┌────────────────┐    ┌────────────────────┐           │
│     │  Desktop Mode  │    │    Gaming Mode     │           │
│     │   (Hyprland)   │    │   (Gamescope)      │           │
│     │                │    │                    │           │
│     │ • Your dotfiles│    │ • Steam Big Picture│           │
│     │ • Waybar       │    │ • Decky Loader     │           │
│     │ • Full desktop │    │ • Controller focus │           │
│     └────────────────┘    └────────────────────┘           │
│                                                             │
│     ┌─────────────────────────────────────────────────┐    │
│     │           Handheld Daemon (hhd)                 │    │
│     │  • Controller emulation (DualSense Edge)       │    │
│     │  • Gyro, back buttons, RGB                     │    │
│     │  • Fan curves, TDP control                     │    │
│     └─────────────────────────────────────────────────┘    │
└─────────────────────────────────────────────────────────────┘
```

## Phase 1: Base Arch Installation

### 1.1 Pre-Installation (from Windows)
- Update BIOS to latest version via Lenovo Vantage
- Disable Secure Boot in BIOS

### 1.2 Arch Install
- Use `archinstall` with multilib enabled
- Select `linux` kernel (swap to `linux-handheld` post-install)
- Install base desktop packages during setup

## Phase 2: Handheld Hardware Support

### 2.1 Linux-Handheld Kernel
```bash
# Install handheld-optimized kernel
yay -S linux-handheld linux-handheld-headers

# Update bootloader to include new kernel
# (grub-mkconfig or reinstall systemd-boot entries)
```
- Fixes white flashing on 60hz
- Fixes frame halving issues
- Adds gyro patches
- Includes fsync for better game performance

### 2.2 Handheld Daemon
```bash
# Core packages
yay -S hhd adjustor hhd-ui acpi_call-dkms

# Enable service
sudo systemctl enable --now hhd@$(whoami)
```
**Features:**
- DualSense Edge controller emulation (gyro, back buttons via Steam Input)
- Fan curve control (requires acpi_call)
- TDP management
- RGB lighting control
- Access via double-tap side menu in gaming mode, or hhd-ui in desktop

### 2.3 Kernel Parameters
Add to bootloader (grub/systemd-boot):
```
iomem=relaxed  # Required for TDP control via ryzenadj
```

## Phase 3: Desktop Mode (Your Dotfiles)

### 3.1 Stow Your Dotfiles
```bash
cd ~/dotfiles
stow hypr waybar walker mako wezterm nvim zsh tmux scripts apps claude
```

### 3.2 Install Dependencies
Run your `install.sh` or install packages from your existing setup:
- Hyprland, hyprlock, hyprpaper
- Waybar, walker, mako
- wezterm, zsh, tmux, neovim

## Phase 4: Gaming Mode (Gamescope Session)

### 4.1 Core Gaming Packages
```bash
# Multilib must be enabled in /etc/pacman.conf
sudo pacman -S steam gamescope mangohud lib32-mangohud

# Vulkan drivers (AMD)
sudo pacman -S vulkan-radeon lib32-vulkan-radeon

# Gamescope session
yay -S gamescope-session-git gamescope-session-steam-git
```

### 4.2 Proton & Compatibility
```bash
# Proton-GE manager
yay -S protonup-qt

# GameMode for performance optimization
sudo pacman -S gamemode lib32-gamemode
```

### 4.3 Decky Loader
```bash
# Install Decky Loader (run in desktop mode)
curl -L https://github.com/SteamDeckHomebrew/decky-installer/releases/latest/download/install_release.sh | sh
```

**Recommended Plugins:**
- SimpleDeckyTDP - TDP control
- PowerTools - CPU/GPU management
- CSS Loader - UI theming
- ProtonDB Badges - Compatibility info

### 4.4 Non-Steam Game Launchers
```bash
# Heroic (Epic, GOG, Amazon)
yay -S heroic-games-launcher-bin

# Lutris (general game management)
sudo pacman -S lutris wine-staging
```
Configure Heroic: Settings → General → "Add games to Steam Automatically"

## Phase 5: Session Switching

### 5.1 SDDM Setup
```bash
sudo pacman -S sddm
sudo systemctl enable sddm
```

### 5.2 Hyprland-SteamOS Switcher
```bash
yay -S uwsm-git

# Clone and install
git clone https://github.com/gibson-jake/Hyprland-Steamos.git
cd Hyprland-Steamos
./install.sh
```
- Adds `SUPER + F12` to open session switcher menu
- Seamless Hyprland ↔ Gamescope switching via Wofi menu

### 5.3 SDDM Autologin to Desktop
Create `/etc/sddm.conf.d/autologin.conf`:
```ini
[Autologin]
User=riley
Session=hyprland
```

### 5.4 Session Selection Commands
```bash
# From desktop - switch to gaming mode
steamos-session-select gamescope

# From gaming mode - use Steam menu "Switch to Desktop"
```

## Phase 6: Configuration Files

### 6.1 Gamescope Environment
Create `~/.config/environment.d/gamescope.conf`:
```bash
# Display scaling for Legion Go 8.8" 2560x1600 screen
STEAM_FORCE_DESKTOPUI_SCALING=1.5

# Performance
ENABLE_GAMESCOPE_WSI=1
DXVK_HDR=1
```

### 6.2 Steam Launch Options (per-game)
```bash
# Enable GameMode
gamemoderun %command%

# Force Proton version
PROTON_USE_WINED3D=1 %command%
```

## Package Summary

### Pacman Packages
```
steam gamescope mangohud lib32-mangohud
vulkan-radeon lib32-vulkan-radeon
gamemode lib32-gamemode
sddm lutris wine-staging
```

### AUR Packages
```
hhd adjustor hhd-ui acpi_call-dkms
linux-handheld linux-handheld-headers
gamescope-session-git gamescope-session-steam-git
uwsm-git protonup-qt heroic-games-launcher-bin
```

## Verification Steps

1. **Boot into Desktop Mode** → Hyprland loads with your dotfiles
2. **Press SUPER+F12** → Wofi menu appears with session options
3. **Select Gaming Mode** → Gamescope launches Steam Big Picture
4. **Double-tap side menu** → HHD overlay for TDP/fan control
5. **Steam menu → Switch to Desktop** → Returns to Hyprland
6. **Non-Steam games** → Appear in Steam library from Heroic

## Known Legion Go Quirks

- **Microphone**: Not functional (hardware limitation)
- **Controller mode**: Use X-input mode (Settings → Controller)
- **Fan curves**: Requires BIOS v29.1+ (v29 has a bug)
- **Audio fuzz after suspend**: Increase TDP briefly or use Decky plugin

## Sources

- [Handheld Daemon](https://github.com/hhd-dev/hhd)
- [Legion Go Tricks](https://github.com/aarron-lee/legion-go-tricks)
- [Hyprland-SteamOS](https://github.com/gibson-jake/Hyprland-Steamos)
- [arch-deckify](https://github.com/unlbslk/arch-deckify)
- [gamescope-session](https://github.com/ChimeraOS/gamescope-session)
- [ArchWiki - Gamescope](https://wiki.archlinux.org/title/Gamescope)
- [ArchWiki - Legion Go](https://wiki.archlinux.org/title/Lenovo_Legion_Go)
- [Bazzite Docs - Legion Go](https://docs.bazzite.gg/Handheld_and_HTPC_edition/Handheld_Wiki/Lenovo_Legion_Go/)
