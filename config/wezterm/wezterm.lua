local wezterm = require 'wezterm'
local config = {}

function scheme_for_appearance(appearance)
	if appearance:find "Dark" then
		return "Catppuccin Mocha"
	else
		return "Catppuccin Latte"
	end
end

config.color_scheme = scheme_for_appearance(wezterm.gui.get_appearance())

config.font = wezterm.font 'FiraCode Nerd Font Mono'
config.font_size = 13.0

config.tab_bar_at_bottom = true
config.use_fancy_tab_bar = false
config.tab_max_width = 32

config.window_close_confirmation = "NeverPrompt"

return config
