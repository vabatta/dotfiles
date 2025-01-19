--[[
UI Configuration (core/ui.lua)

Critical UI Elements (now)
- Theme: catppuccin/nvim
- Status Line: mini.statusline + mini.icons
- Notifications: mini.notify

Visual Enhancements (later)
- Cursor Enhancements:
  - reticle.nvim (cursor line/column)
  - mini.cursorword
- Code Visualization: mini.indentscope
- Git Integration: gitsigns.nvim
- Zen Mode: zen-mode.nvim
- Navigation: which-key.nvim
--]]

local add, now, later = MiniDeps.add, MiniDeps.now, MiniDeps.later

-- Critical UI elements (load immediately)
now(function()
	-- Theme
	add("catppuccin/nvim")
	require("catppuccin").setup({
		custom_highlights = function(colors)
			local utils = require("catppuccin.utils.colors")
			return {
				CursorColumn = {
					bg = utils.vary_color(
						{ latte = utils.lighten(colors.mantle, 0.70, colors.base) },
						utils.darken(colors.surface0, 0.64, colors.base)
					),
				},
				CursorLine = {
					bg = utils.vary_color(
						{ latte = utils.lighten(colors.mantle, 0.70, colors.base) },
						utils.darken(colors.surface0, 0.64, colors.base)
					),
				},
			}
		end,
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
				inlay_hints = { background = true },
			},
			treesitter = true,
			which_key = true,
			telescope = { enabled = true },
			mini = { enabled = true },
		},
	})
	vim.cmd("colorscheme catppuccin")

	-- Core status elements
	add({
		source = "echasnovski/mini.statusline",
		depends = { "echasnovski/mini.icons" },
	})
	require("mini.statusline").setup()

	-- Notification system
	add("echasnovski/mini.notify")
	local notify = require("mini.notify")
	notify.setup()
	vim.notify = notify.make_notify({
		ERROR = { duration = 20000 },
		WARN = { duration = 20000 },
		INFO = { duration = 5000 },
		DEBUG = { duration = 0 },
	})
end)

-- Visual enhancements (load after core UI)
later(function()
	-- Cursor enhancements
	add("tummetott/reticle.nvim")
	require("reticle").setup({
		on_startup = {
			cursorline = true,
			cursorcolumn = true,
		},
	})

	add("echasnovski/mini.cursorword")
	require("mini.cursorword").setup()

	-- Code visualization
	add("echasnovski/mini.indentscope")
	require("mini.indentscope").setup()

	-- Git integration
	add("lewis6991/gitsigns.nvim")
	require("gitsigns").setup()

	-- Zen mode
	add({
		source = "folke/zen-mode.nvim",
		depends = { "folke/twilight.nvim" },
	})

	-- Which-key integration
	local icons = {
		ui = require("utils.icons").get("ui"),
		misc = require("utils.icons").get("misc"),
		git = require("utils.icons").get("git", true),
		cmp = require("utils.icons").get("cmp", true),
	}

	add("folke/which-key.nvim")
	require("which-key").setup({
		preset = "classic",
		delay = vim.o.timeoutlen,
		triggers = {
			{ "<auto>", mode = "nixso" },
		},
		plugins = {
			marks = true,
			registers = true,
			spelling = {
				enabled = true,
				suggestions = 20,
			},
			presets = {
				motions = false,
				operators = false,
				text_objects = true,
				windows = true,
				nav = true,
				z = true,
				g = true,
			},
		},
		win = {
			border = "none",
			padding = { 1, 2 },
			wo = { winblend = 0 },
		},
		expand = 1,
		icons = {
			group = "",
			rules = false,
			colors = false,
			breadcrumb = icons.ui.Separator,
			separator = icons.misc.Vbar,
			keys = {
				C = "C-",
				M = "A-",
				S = "S-",
				BS = "<BS> ",
				CR = "<CR> ",
				NL = "<NL> ",
				Esc = "<Esc> ",
				Tab = "<Tab> ",
				Up = "<Up> ",
				Down = "<Down> ",
				Left = "<Left> ",
				Right = "<Right> ",
				Space = "<Space> ",
				ScrollWheelUp = "<ScrollWheelUp> ",
				ScrollWheelDown = "<ScrollWheelDown> ",
			},
		},
		spec = {
			{ "<leader>g", group = icons.git.Git .. "Git" },
			{ "<leader>d", group = icons.ui.Bug .. " Debug" },
			{ "<leader>s", group = icons.cmp.tmux .. "Session" },
			{ "<leader>b", group = icons.ui.Buffer .. " Buffer" },
			{ "<leader>S", group = icons.ui.Search .. " Search" },
			{ "<leader>W", group = icons.ui.Window .. " Window" },
			{ "<leader>p", group = icons.ui.Package .. " Package" },
			{ "<leader>l", group = icons.misc.LspAvailable .. " Lsp" },
			{ "<leader>f", group = icons.ui.Telescope .. " Fuzzy Find" },
			{ "<leader>n", group = icons.ui.FolderOpen .. " Nvim Tree" },
		},
	})
end)
