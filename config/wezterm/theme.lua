local wezterm = require 'wezterm'

wezterm.on('window-config-reloaded', function(window, pane)
	local overrides = window:get_config_overrides() or {}
	local appearance = window:get_appearance()

	if appearance:find 'Dark' then
		overrides.color_scheme = 'Gruvbox dark, soft (base16)'
		overrides.colors = {
			tab_bar = {
				background = '#32302F',

				active_tab = {
					bg_color = '#685C53',
					fg_color = '#D9C39D',
				},

				inactive_tab = {
					bg_color = '#32302F',
					fg_color = '#D9C39D',
				},

				new_tab = {
					bg_color = '#32302F',
					fg_color = '#D9C39D',
				},

				inactive_tab_hover = {
					bg_color = '#FFBA00',
					fg_color = '#FDF1C2',
					italic = false,
					intensity = 'Bold',
				},

				new_tab_hover = {
					bg_color = '#FFBA00',
					fg_color = '#FDF1C2',
					italic = false,
					intensity = 'Bold',
				},
			}
		}
	else
		overrides.color_scheme = 'Gruvbox light, soft (base16)'
		overrides.colors = {
			tab_bar = {
				background = '#F5E4B7',

				active_tab = {
					bg_color = '#D9C39D',
					fg_color = '#32302F',
				},

				inactive_tab = {
					bg_color = '#F5E4B7',
					fg_color = '#32302F',
				},

				new_tab = {
					bg_color = '#F5E4B7',
					fg_color = '#32302F',
				},

				inactive_tab_hover = {
					bg_color = '#FFBA00',
					fg_color = '#FDF1C2',
					italic = false,
					intensity = 'Bold',
				},

				new_tab_hover = {
					bg_color = '#FFBA00',
					fg_color = '#FDF1C2',
					italic = false,
					intensity = 'Bold',
				},
			}
		}
	end

	window:set_config_overrides(overrides)
end)
