local wezterm = require("wezterm")

local config = wezterm.config_builder()

config.font = wezterm.font("CaskaydiaMono Nerd Font")
config.font_size = 12

config.use_fancy_tab_bar = false
config.hide_tab_bar_if_only_one_tab = true
config.initial_cols = 110
config.initial_rows = 32

config.cursor_blink_ease_in = "Constant"
config.cursor_blink_ease_out = "Constant"
config.cursor_blink_rate = 600

config.scrollback_lines = 50000

config.colors = {
	background = "#262626",
	foreground = "#f7f1ff",
	cursor_bg = "#f7f1ff",
	cursor_border = "#f7f1ff",
	cursor_fg = "#222222",
	selection_bg = "#414550",
	selection_fg = "#f7f1ff",
	ansi = { "#222222", "#fc618d", "#7bd88f", "#fce566", "#5ad4e6", "#948ae3", "#fd9353", "#f7f1ff" },
	brights = { "#69676c", "#fc618d", "#7bd88f", "#fce566", "#5ad4e6", "#948ae3", "#fd9353", "#ffffff" },
}

return config
