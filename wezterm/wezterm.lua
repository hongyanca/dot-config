-- Pull in the wezterm API
local wezterm = require 'wezterm'

local config = wezterm.config_builder()

-- This will hold the configuration.
-- local config = wezterm.config_builder()
local config = {
  font_size = 15.6,
  font = wezterm.font("DejaVuSansMono Nerd Font"),
  -- font = wezterm.font("BlexMono Nerd Font"),
  -- color_scheme = 'Dissonance (Gogh)',
  line_height = 1.075,

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


local HomerColor = wezterm.color.get_builtin_schemes()['Dissonance (Gogh)']
HomerColor.ansi[1] = '#000000'
HomerColor.brights[1] = '#686a65'
HomerColor.ansi[2] = '#fc4236'
HomerColor.brights[2] = '#ff271a'
HomerColor.ansi[3] = '#3d9970'
HomerColor.brights[3] = '#2ecc41'
HomerColor.ansi[4] = '#e3c701'
HomerColor.brights[4] = '#f5be30'
HomerColor.ansi[5] = '#3dbada'
HomerColor.brights[5] = '#1588ff'
HomerColor.ansi[6] = '#c634e1'
HomerColor.brights[6] = '#e430b5'
HomerColor.ansi[7] = '#3acbcc'
HomerColor.brights[7] = '#217e7b'
HomerColor.ansi[8] = '#c0c0c0'
HomerColor.brights[8] = '#f1f1f1'
config.color_schemes = {
  ['Homer'] = HomerColor,
}
config.color_scheme = 'Homer'

config.colors = {
  cursor_bg = '#7edbfd',
  cursor_fg = 'black',
  cursor_border = '#7edbfd',
  selection_fg = 'black',
  selection_bg = '#7edbfd',
}

config.inactive_pane_hsb = {
  saturation = 0.7,
  brightness = 0.7,
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


-- and finally, return the configuration to wezterm
return config
