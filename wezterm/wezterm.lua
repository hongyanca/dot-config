-- Pull in the wezterm API
local wezterm = require 'wezterm'

local config = wezterm.config_builder()

-- This will hold the configuration.
-- local config = wezterm.config_builder()
local config = {
  font_size = 15.6,
  font = wezterm.font("DejaVuSansMono Nerd Font"),
  -- font = wezterm.font("BlexMono Nerd Font"),
  color_scheme = 'Dissonance (Gogh)',
  line_height = 1.08,

  use_fancy_tab_bar = false,
  hide_tab_bar_if_only_one_tab = true,
  window_decorations = "RESIZE",
  show_new_tab_button_in_tab_bar = false,
  adjust_window_size_when_changing_font_size = false,

  initial_rows = 45,
  initial_cols = 125,

  window_padding = {
    left = 8,
    right = 8,
    top = 4,
    bottom = 4,
  }
}

config.inactive_pane_hsb = {
  saturation = 0.7,
  brightness = 0.7,
}

config.colors = {
  cursor_bg = '#7edbfd',
  cursor_fg = 'black',
  cursor_border = '#7edbfd',
  selection_fg = 'black',
  selection_bg = '#7edbfd',
}

local mod = {}
local platform = require('utils.platform')()
if platform.is_mac then
  mod.SUPER = 'SUPER'
  mod.SUPER_SHIFT = 'SUPER|SHIFT'
  -- mod.SUPER_REV = 'SUPER|CTRL'
elseif platform.is_win then
  mod.SUPER = 'ALT' -- to not conflict with Windows key shortcuts
  mod.SUPER_SHIFT = 'ALT|SHIFT'
  -- mod.SUPER_REV = 'ALT|CTRL'
end

config.keys = {
  {
    key = 'LeftArrow',
    mods = mod.SUPER,
    action = wezterm.action.ActivateTabRelative(-1)
  },
  {
    key = 'RightArrow',
    mods = mod.SUPER,
    action = wezterm.action.ActivateTabRelative(1)
  },
  {
    key = '[',
    mods = mod.SUPER_SHIFT,
    action = wezterm.action.ActivateTabRelative(-1)
  },
  {
    key = ']',
    mods = mod.SUPER_SHIFT,
    action = wezterm.action.ActivateTabRelative(1)
  },
  {
    key = '\\',
    mods = mod.SUPER,
    action = wezterm.action.SplitVertical({ domain = 'CurrentPaneDomain' })
  },
  {
    key = '|',
    mods = mod.SUPER,
    action = wezterm.action.SplitHorizontal({ domain = 'CurrentPaneDomain' })
  },
}
-- This is where you actually apply your config choices

-- and finally, return the configuration to wezterm
return config
