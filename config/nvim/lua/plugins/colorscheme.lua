local add, now = MiniDeps.add, MiniDeps.now

now(function()
	add("catppuccin/nvim")

	require("catppuccin").setup({
		custom_highlights = function(colors)
			local utils = require("catppuccin.utils.colors")

			return {
				-- MiniCursorword = { bg = utils.vary_color({ latte = utils.lighten(colors.mantle, 0.70, colors.base) }, utils.darken(colors.surface0, 0.64, colors.base)) },
				CursorColumn = { bg = utils.vary_color({ latte = utils.lighten(colors.mantle, 0.70, colors.base) }, utils.darken(colors.surface0, 0.64, colors.base)) },
				CursorLine = { bg = utils.vary_color({ latte = utils.lighten(colors.mantle, 0.70, colors.base) }, utils.darken(colors.surface0, 0.64, colors.base)) },
			}
		end,
		default_integrations = false,
		integrations = {
			native_lsp = {
				enabled = true,
				virtual_text = {
						errors = { "italic" },
						hints = { "italic" },
						warnings = { "italic" },
						information = { "italic" },
				},
				underlines = {
						errors = { "underline" },
						hints = { "underline" },
						warnings = { "underline" },
						information = { "underline" },
				},
				inlay_hints = {
						background = true,
				},
			},
			indent_blankline = {
				enabled = true,
				colored_indent_levels = false,
		},
			treesitter = true,
			which_key = true,
			telescope = {
				enabled = true,
			},
			mini = {
				enabled = true
			}
		}
	})

	vim.cmd("colorscheme catppuccin")
end)
