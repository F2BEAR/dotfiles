local wezterm = require("wezterm")
local config = wezterm.config_builder()
local act = wezterm.action

-- config goes here:

config.default_prog = { "C:\\WINDOWS\\system32\\wsl.exe", "-d", "Ubuntu" }

-- Appearance
config.color_scheme = "Hybrid"
config.enable_tab_bar = true
config.window_decorations = "RESIZE"
config.window_background_opacity = 0.95

-- Coolnight colorscheme:
config.colors = {
	foreground = "#CBE0F0",
	background = "#011423",
	cursor_bg = "#47FF9C",
	cursor_border = "#47FF9C",
	cursor_fg = "#011423",
	selection_bg = "#033259",
	selection_fg = "#CBE0F0",
	ansi = { "#214969", "#E52E2E", "#44FFB1", "#FFE073", "#0FC5ED", "#a277ff", "#24EAF7", "#24EAF7" },
	brights = { "#214969", "#E52E2E", "#44FFB1", "#FFE073", "#A277FF", "#a277ff", "#24EAF7", "#24EAF7" },
}
-- Font
config.text_background_opacity = 1
config.font = wezterm.font("JetBrains Mono")
config.font_size = 10

-- Keybindings

config.keys = {
	{ key = "y", mods = "CTRL", action = act.CopyTo("ClipboardAndPrimarySelection") },
	{ key = "c", mods = "CTRL|SHIFT", action = act.CopyTo("ClipboardAndPrimarySelection") },
	{ key = "p", mods = "CTRL", action = act.PasteFrom("Clipboard") },
	{ key = "p", mods = "CTRL", action = act.PasteFrom("PrimarySelection") },
	{ key = "v", mods = "CTRL", action = act.PasteFrom("Clipboard") },
	{ key = "v", mods = "CTRL", action = act.PasteFrom("PrimarySelection") },

	-- Create and delete panes
	{ key = "=", mods = "CTRL", action = act.SplitHorizontal({ domain = "CurrentPaneDomain" }) },
	{ key = "-", mods = "CTRL", action = act.SplitVertical({ domain = "CurrentPaneDomain" }) },
	{ key = "d", mods = "CTRL", action = act.CloseCurrentPane({ confirm = true }) },

	-- Move between panes
	{ key = "h", mods = "CTRL", action = act.ActivatePaneDirection("Left") },
	{ key = "j", mods = "CTRL", action = act.ActivatePaneDirection("Down") },
	{ key = "k", mods = "CTRL", action = act.ActivatePaneDirection("Up") },
	{ key = "l", mods = "CTRL", action = act.ActivatePaneDirection("Right") },
	{ key = "LeftArrow", mods = "CTRL", action = act.ActivatePaneDirection("Left") },
	{ key = "DownArrow", mods = "CTRL", action = act.ActivatePaneDirection("Down") },
	{ key = "UpArrow", mods = "CTRL", action = act.ActivatePaneDirection("Up") },
	{ key = "RightArrow", mods = "CTRL", action = act.ActivatePaneDirection("Right") },

	-- Adjust pane size
	{ key = "H", mods = "CTRL", action = act.AdjustPaneSize({ "Left", 5 }) },
	{ key = "J", mods = "CTRL", action = act.AdjustPaneSize({ "Down", 5 }) },
	{ key = "K", mods = "CTRL", action = act.AdjustPaneSize({ "Up", 5 }) },
	{ key = "L", mods = "CTRL", action = act.AdjustPaneSize({ "Right", 5 }) },

	-- Create and delete tabs
	{ key = "t", mods = "ALT", action = act.SpawnTab("DefaultDomain") },
	{ key = "d", mods = "ALT", action = act.CloseCurrentPane({ confirm = true }) },

	-- Move between tabs
	{ key = "[", mods = "ALT", action = act.ActivateTabRelative(-1) },
	{ key = "]", mods = "ALT", action = act.ActivateTabRelative(1) },

	-- Toggle fullscreen
	{ key = "W", mods = "CTRL", action = act.ToggleFullScreen },
}

-- Mouse bindings
config.mouse_bindings = {
	{
		event = { Down = { streak = 1, button = "Right" } },
		mods = "NONE",
		action = act.PasteFrom("Clipboard"),
	},
	{
		event = { Down = { streak = 1, button = "Right" } },
		mods = "NONE",
		action = act.PasteFrom("PrimarySelection"),
	},
}

-- return config at the end
return config
