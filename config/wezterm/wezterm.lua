local wezterm = require 'wezterm'
local config = {}
require('theme')

config.font = wezterm.font 'FiraCode Nerd Font Mono'
config.font_size = 13.0

config.tab_bar_at_bottom = true
config.use_fancy_tab_bar = false
config.tab_max_width = 32

return config
