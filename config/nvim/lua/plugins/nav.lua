--[[
Navigation Configuration (core/nav.lua)

Core Navigation (now)
- File Navigation:
  - netrw.nvim
  - mini.files
- Window Management: smart-splits.nvim

Enhanced Navigation (later)
- Motion Plugins:
  - flash.nvim
  - mini.jump2d
  - mini.bracketed
- Code Navigation:
  - mini.ai
  - vim-matchup (with treesitter)
- Search and Finding:
  - telescope.nvim + extensions:
    - telescope-undo
    - telescope-zoxide
    - telescope-live-grep-args
    - telescope-fzf-native
--]]

local add, now, later = MiniDeps.add, MiniDeps.now, MiniDeps.later

-- Core navigation features
now(function()
	-- File navigation (immediate access needed)
	add("prichrd/netrw.nvim")
	require("netrw").setup()

	add("echasnovski/mini.files")
	require("mini.files").setup({
		options = {
			-- Whether to use for editing directories
			use_as_default_explorer = false,
		},
	})

	-- Window management (critical for workflow)
	add("mrjones2014/smart-splits.nvim")
	require("smart-splits").setup()
end)

-- Enhanced navigation features
later(function()
	-- Motion enhancements
	add("folke/flash.nvim")
	require("flash").setup()

	add("echasnovski/mini.jump2d")
	require("mini.jump2d").setup()

	add("echasnovski/mini.bracketed")
	require("mini.bracketed").setup()

	-- Code navigation
	add("echasnovski/mini.ai")
	require("mini.ai").setup()

	add({
		source = "andymass/vim-matchup",
		depends = { "nvim-treesitter/nvim-treesitter" },
	})
	require("match-up").setup({})

	-- Search and fuzzy finding
	add({
		source = "nvim-telescope/telescope.nvim",
		depends = {
			"nvim-lua/plenary.nvim",
			"nvim-tree/nvim-web-devicons",
			"nvim-treesitter/nvim-treesitter",
			-- Telescope extensions
			"debugloop/telescope-undo.nvim",
			"jvgrootveld/telescope-zoxide",
			"nvim-telescope/telescope-live-grep-args.nvim",
			{
				source = "nvim-telescope/telescope-fzf-native.nvim",
				hooks = {
					post_install = function(params)
						vim.notify("Building fzf native extension", vim.log.levels.INFO)
						vim.cmd("lcd " .. params.path)
						vim.cmd("!make -s")
						vim.cmd("lcd -")
					end,
				},
			},
		},
	})

	local telescope = require("telescope")
	telescope.load_extension("undo")
	telescope.load_extension("zoxide")
	telescope.load_extension("live_grep_args")
	telescope.load_extension("fzf")
end)
