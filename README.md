# Dotfiles

Personal dotfiles for Arch Linux with Hyprland. Managed with [GNU Stow](https://www.gnu.org/software/stow/).

## Quick Start

```bash
# Clone the repo
git clone <repo-url> ~/dotfiles
cd ~/dotfiles

# Option 1: Full install (fresh Arch system)
./install.sh

# Option 2: Just stow configs (packages already installed)
stow hypr waybar walker mako wezterm nvim zsh tmux scripts apps claude
```

## Packages

### hypr
Hyprland window manager, lock screen, and wallpaper configuration.

| File | Description |
|------|-------------|
| `hyprland.conf` | Main config, sources other files, startup apps |
| `hyprlock.conf` | Lock screen (password on DP-1, clock on DP-2) |
| `hyprpaper.conf` | Wallpaper configuration |
| `configs/keybinds.conf` | **All keybindings** |
| `configs/monitors.conf` | Monitor setup (DP-1: 1440p, DP-2: 1080p) |
| `configs/workspaces.conf` | Workspace-to-monitor assignments |
| `configs/input.conf` | Keyboard/mouse settings |
| `configs/default_apps.conf` | Terminal, file manager defaults |
| `configs/misc.conf` | Dwindle/master layout settings |
| `theme/theme.conf` | Main theme (sources others) |
| `theme/mocha.conf` | Catppuccin Mocha color definitions |
| `theme/animations.conf` | Animation settings |
| `theme/decoration.conf` | Borders, gaps, blur, shadows |
| `theme/rules.conf` | Window rules |

**Common tasks:**
- Change keybinds: `configs/keybinds.conf`
- Change colors: `theme/mocha.conf`
- Change gaps/borders: `theme/theme.conf`
- Add startup apps: `hyprland.conf` (exec-once)
- Change monitors: `configs/monitors.conf`

```bash
stow hypr
```

---

### waybar
Status bar with per-monitor configuration.

| File | Description |
|------|-------------|
| `config` | Main config, defines both bars |
| `style.css` | Main stylesheet |
| `mocha.css` | Catppuccin color variables |
| `bars/bar-1` | DP-1 bar modules |
| `bars/bar-2` | DP-2 bar modules |
| `modules/workspaces` | Workspace display config |
| `modules/clock` | Time/date module |
| `modules/weather` | Weather module config |
| `modules/weather.sh` | Weather fetch script (wttr.in) |
| `modules/cpu` | CPU usage |
| `modules/memory` | Memory usage |
| `modules/temp` | Temperature |
| `modules/audio` | Volume control |

**Common tasks:**
- Change bar modules: `bars/bar-1` or `bars/bar-2`
- Change colors: `mocha.css` and `style.css`
- Change weather location: `modules/weather` (exec line)

```bash
stow waybar
```

---

### walker
Application launcher (with Elephant backend).

| File | Description |
|------|-------------|
| `config.toml` | Main configuration |
| `themes/catppuccin-mocha/style.css` | Theme styles |
| `themes/catppuccin-mocha/layout.xml` | Theme layout |

**Dependencies:** `walker-bin`, `elephant-bin`, `elephant-desktopapplications`, `elephant-providerlist`, `elephant-runner`, `elephant-websearch`, `elephant-calc`, `elephant-files`

```bash
stow walker
```

---

### mako
Notification daemon.

| File | Description |
|------|-------------|
| `config` | All settings (colors, position, timeout) |

**Common tasks:**
- Change colors: edit `config` (background-color, text-color, border-color)
- Change position: `anchor=` in `config`

```bash
stow mako
```

---

### wezterm
Terminal emulator.

| File | Description |
|------|-------------|
| `wezterm.lua` | All configuration |

```bash
stow wezterm
```

---

### nvim
Neovim with LazyVim distribution.

| File | Description |
|------|-------------|
| `init.lua` | Entry point |
| `lazy-lock.json` | Plugin versions |
| `lua/config/keymaps.lua` | Custom keymaps |
| `lua/config/options.lua` | Editor options |
| `lua/plugins/colorscheme.lua` | Catppuccin theme |
| `lua/plugins/example.lua` | Example plugin config |

**Common tasks:**
- Add plugins: create file in `lua/plugins/`
- Change keymaps: `lua/config/keymaps.lua`
- Change theme: `lua/plugins/colorscheme.lua`

```bash
stow nvim
```

---

### zsh
Z shell configuration.

| File | Description |
|------|-------------|
| `.zshenv` | Environment variables, sources .zshrc |
| `.config/zsh/.zshrc` | Main shell config |
| `.config/zsh/plugins/pure/` | Pure prompt theme |
| `.config/zsh/plugins/zsh-autosuggestions/` | Autosuggestions |
| `.config/zsh/plugins/zsh-syntax-highlighting/` | Syntax highlighting |

```bash
stow zsh
```

---

### tmux
Terminal multiplexer with vim-tmux-navigator integration.

| File | Description |
|------|-------------|
| `.tmux.conf` | Main config with vim navigation, mouse support, Wayland clipboard |

**Features:**
- `Ctrl+h/j/k/l` - Navigate panes (works seamlessly with nvim splits)
- Mouse support enabled
- Vi copy mode with `wl-copy` integration

```bash
stow tmux
```

---

### scripts
Custom scripts in `~/.local/bin/`.

| Script | Description |
|--------|-------------|
| `launch-walker` | Launch application launcher |
| `system-menu` | Power menu (lock/restart/shutdown) |
| `launch-webapp` | Launch Chromium web apps |
| `webapp-install` | Create new web app |
| `webapp-remove` | Remove web app |
| `app-hide` | Hide app from launcher |
| `app-unhide` | Unhide app in launcher |
| `restart-walker` | Restart Walker/Elephant |

```bash
stow scripts
```

---

### apps
Desktop application entries. **Partial stow** - only custom apps, not system-generated.

| File | Description |
|------|-------------|
| `Discord.desktop` | Discord web app |
| `icons/Discord.png` | Discord icon |

To add a new web app:
```bash
# Use the webapp-install script
webapp-install

# Then copy the new .desktop and icon to dotfiles
cp ~/.local/share/applications/MyApp.desktop ~/dotfiles/apps/.local/share/applications/
cp ~/.local/share/applications/icons/MyApp.png ~/dotfiles/apps/.local/share/applications/icons/
rm ~/.local/share/applications/MyApp.desktop ~/.local/share/applications/icons/MyApp.png
cd ~/dotfiles && stow apps
```

```bash
stow apps
```

---

### claude
Claude Code CLI settings. **Partial stow** - only settings, not credentials/cache.

| File | Description |
|------|-------------|
| `settings.json` | Global Claude Code settings |

**Not tracked:** `.credentials.json`, `cache/`, `history.jsonl`, `projects/`, `plugins/`, `stats-cache.json`

On a new machine, `~/.claude/` will be created by Claude Code on first run. Then:
```bash
# Remove the generated settings.json and stow ours
rm ~/.claude/settings.json
cd ~/dotfiles && stow claude
```

```bash
stow claude
```

---

## Keybinds Reference

| Keys | Action |
|------|--------|
| `SUPER+SPACE` | Application launcher |
| `SUPER+Q` | Terminal |
| `SUPER+C` | Close window |
| `SUPER+E` | File manager |
| `SUPER+V` | Toggle floating |
| `SUPER+T` | Toggle split |
| `SUPER+F` | Fullscreen |
| `SUPER+ESC` | Lock screen |
| `SUPER+ALT+SPACE` | System menu |
| `SUPER+H/J/K/L` | Move focus |
| `SUPER+SHIFT+H/J/K/L` | Move window |
| `SUPER+R` | Resize mode (hjkl, ESC to exit) |
| `SUPER+1-0` | Switch workspace |
| `SUPER+SHIFT+1-0` | Move window to workspace |
| `SUPER+LMB` | Drag to move window |
| `SUPER+RMB` | Drag to resize window |
| `PRINT` | Screenshot monitor |
| `SUPER+PRINT` | Screenshot window |
| `SUPER+SHIFT+PRINT` | Screenshot region |

---

## Adding New Config to Stow

### Full directory

When stowing an entire config directory:

```bash
# 1. Create the package structure (mirrors home directory)
mkdir -p ~/dotfiles/myapp/.config

# 2. Move the config
mv ~/.config/myapp ~/dotfiles/myapp/.config/

# 3. Create the symlink
cd ~/dotfiles && stow myapp

# Verify
ls -la ~/.config/myapp  # Should show symlink
```

### Partial directory (specific files only)

Some directories contain generated files, caches, or secrets that shouldn't be tracked. In these cases, only stow the specific files you want.

**Example: Claude Code** (`~/.claude/` contains credentials and cache)

```bash
# Only copy the settings file, not the whole directory
mkdir -p ~/dotfiles/claude/.claude
cp ~/.claude/settings.json ~/dotfiles/claude/.claude/

# Remove original file (not the directory!)
rm ~/.claude/settings.json

# Stow creates symlink for just that file
cd ~/dotfiles && stow claude
```

Result:
```
~/.claude/
├── settings.json -> ../dotfiles/claude/.claude/settings.json  # Tracked
├── .credentials.json  # Local only (not tracked)
├── cache/             # Local only
└── ...
```

**Example: Desktop applications** (`~/.local/share/applications/` has system files)

```bash
# Only add your custom .desktop files
mkdir -p ~/dotfiles/apps/.local/share/applications/icons
cp ~/.local/share/applications/MyApp.desktop ~/dotfiles/apps/.local/share/applications/
cp ~/.local/share/applications/icons/MyApp.png ~/dotfiles/apps/.local/share/applications/icons/

# Remove originals
rm ~/.local/share/applications/MyApp.desktop
rm ~/.local/share/applications/icons/MyApp.png

# Stow
cd ~/dotfiles && stow apps
```

### Packages with partial stows in this repo

| Package | What's tracked | What's NOT tracked (local only) |
|---------|---------------|--------------------------------|
| `claude` | `settings.json` | `.credentials.json`, `cache/`, `history.jsonl`, `projects/`, `plugins/` |
| `apps` | Custom `.desktop` files (Discord) | System-generated `.desktop` files |
| `zsh` | `.zshrc`, `.zshenv`, `plugins/` | `.zhistory`, `.zcompdump` (via .gitignore) |

### Unstowing

To remove symlinks (before removing a package):

```bash
cd ~/dotfiles && stow -D myapp
```

---

## Dependencies

```bash
# Core
hyprland hyprlock hyprpaper hyprshot

# Bar & Launcher
waybar walker-bin elephant-bin gum

# Notifications
mako

# Terminal & Editor
wezterm neovim

# Shell
zsh

# Fonts
ttf-jetbrains-mono-nerd

# Other
polkit-kde-agent chromium
```

---

## Theme

All applications use **Catppuccin Mocha**.

- Hyprland: `hypr/.config/hypr/theme/mocha.conf`
- Waybar: `waybar/.config/waybar/mocha.css`
- Walker: `walker/.config/walker/themes/catppuccin-mocha/`
- Mako: Colors in `mako/.config/mako/config`
- Neovim: `nvim/.config/nvim/lua/plugins/colorscheme.lua`
- Wezterm: In `wezterm/.config/wezterm/wezterm.lua`
