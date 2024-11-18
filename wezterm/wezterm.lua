-- Pull in the wezterm API
local wezterm = require("wezterm")

local function is_found(str, pattern)
	return string.find(str, pattern) ~= nil
end

local function check_platform()
	return {
		is_win = is_found(wezterm.target_triple, "windows"),
		is_linux = is_found(wezterm.target_triple, "linux"),
		is_mac = is_found(wezterm.target_triple, "apple"),
	}
end

local platform = check_platform()

-- This will hold the configuration.
-- local config = wezterm.config_builder()
local config = {
	font_size = platform.is_mac and 15.6 or 12,
	-- font = wezterm.font("DejaVuSansMono Nerd Font"),
	-- font = wezterm.font("BlexMono Nerd Font"),
	font = platform.is_mac and wezterm.font("DejaVuSansMono Nerd Font") or wezterm.font("BlexMono Nerd Font"),
	cell_width = 0.90,
	line_height = 1.075,
	max_fps = 60,

	use_fancy_tab_bar = false,
	hide_tab_bar_if_only_one_tab = platform.is_mac and true or false,
	tab_max_width = 48,
	window_decorations = "RESIZE",
	show_new_tab_button_in_tab_bar = false,
	adjust_window_size_when_changing_font_size = false,

	default_cursor_style = "BlinkingBlock",
	cursor_blink_ease_in = "Constant",
	cursor_blink_ease_out = "Constant",
	cursor_blink_rate = 700,

	initial_rows = platform.is_mac and 45 or 32,
	initial_cols = 125,

	window_padding = {
		left = 8,
		right = 8,
		top = 4,
		bottom = 4,
	},
}

local HomerColor = wezterm.color.get_builtin_schemes()["Dissonance (Gogh)"]
HomerColor.ansi[1] = "#000000"
HomerColor.brights[1] = "#686a65"
HomerColor.ansi[2] = "#fc4236"
HomerColor.brights[2] = "#ff271a"
HomerColor.ansi[3] = "#3d9970"
HomerColor.brights[3] = "#2ecc41"
HomerColor.ansi[4] = "#e3c701"
HomerColor.brights[4] = "#f5be30"
HomerColor.ansi[5] = "#3dbada"
HomerColor.brights[5] = "#1588ff"
HomerColor.ansi[6] = "#c634e1"
HomerColor.brights[6] = "#e430b5"
HomerColor.ansi[7] = "#3acbcc"
HomerColor.brights[7] = "#217e7b"
HomerColor.ansi[8] = "#c0c0c0"
HomerColor.brights[8] = "#f1f1f1"
config.color_schemes = {
	["Homer"] = HomerColor,
}
config.color_scheme = "Homer"
config.colors = {
	cursor_bg = "#7edbfd",
	cursor_fg = "black",
	cursor_border = "#7edbfd",
	selection_fg = "black",
	selection_bg = "#7edbfd",
}

config.inactive_pane_hsb = {
	saturation = 0.7,
	brightness = 0.7,
}

config.keys = {
	{
		key = "LeftArrow",
		mods = "SUPER",
		action = wezterm.action.ActivateTabRelative(-1),
	},
	{
		key = "RightArrow",
		mods = "SUPER",
		action = wezterm.action.ActivateTabRelative(1),
	},
	{
		key = "[",
		mods = "SUPER|SHIFT",
		action = wezterm.action.ActivateTabRelative(-1),
	},
	{
		key = "]",
		mods = "SUPER|SHIFT",
		action = wezterm.action.ActivateTabRelative(1),
	},
	{
		key = "\\",
		mods = "SUPER",
		action = wezterm.action.SplitVertical({ domain = "CurrentPaneDomain" }),
	},
	{
		key = "|",
		mods = "SUPER|SHIFT",
		action = wezterm.action.SplitHorizontal({ domain = "CurrentPaneDomain" }),
	},
	{
		key = "w",
		mods = "SUPER",
		action = wezterm.action.CloseCurrentTab({ confirm = false }),
	},
}

config.mouse_bindings = {
	{
		event = { Down = { streak = 1, button = "Right" } },
		mods = "NONE",
		action = wezterm.action_callback(function(window, pane)
			local has_selection = window:get_selection_text_for_pane(pane) ~= ""
			if has_selection then
				window:perform_action(act.CopyTo("ClipboardAndPrimarySelection"), pane)
				window:perform_action(act.ClearSelection, pane)
			else
				window:perform_action(act({ PasteFrom = "Clipboard" }), pane)
			end
		end),
	},
}

config.window_close_confirmation = "NeverPrompt"

-- and finally, return the configuration to wezterm
return config
