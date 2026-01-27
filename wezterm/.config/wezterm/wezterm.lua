-- ~/.wezterm.lua — Dev-focused WezTerm config with Catppuccin Mocha

local wezterm = require("wezterm")

return {
  -- Shell
  default_prog = { "/bin/zsh", "-l" },

  -- Font
  font = wezterm.font_with_fallback {"JetBrainsMono Nerd Font", {family="Font Awesome 6 Free", weight="Black"}},
  font_size = 13.0,
  line_height = 1.1,

  -- Appearance
  color_scheme = "Catppuccin Mocha",
  enable_tab_bar = false,
  window_decorations = "RESIZE",
  use_fancy_tab_bar = false,

  -- Suppress xdg-portal warnings
  warn_about_missing_glyphs = false,

  -- Padding and spacing
  window_padding = {
    left = 8,
    right = 8,
    top = 6,
    bottom = 6,
  },

  -- Cursor
  default_cursor_style = "BlinkingBlock",

  -- Wayland support (Hyprland)
  enable_wayland = false,

  -- Scrollback
  scrollback_lines = 10000,

  -- Performance
  animation_fps = 60,
  max_fps = 120,
  front_end = "OpenGL", -- Use the best GPU renderer available
  -- webgpu_power_preference = "HighPerformance",

  -- Behavior
  automatically_reload_config = true,
  adjust_window_size_when_changing_font_size = false,
}
