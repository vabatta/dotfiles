local add, later = MiniDeps.add, MiniDeps.later

later(function()
	local function make_fzf_native(params)
		vim.notify("Building fzf native extension", vim.log.levels.INFO)
		vim.cmd("lcd " .. params.path)
		vim.cmd("!make -s")
		vim.cmd("lcd -")
	end

	add({
		source = "nvim-telescope/telescope.nvim",
		checkout = "0.1.6",
		depends = {
			"nvim-lua/plenary.nvim",
			"nvim-tree/nvim-web-devicons",
			"nvim-treesitter/nvim-treesitter",
			"debugloop/telescope-undo.nvim",
			"jvgrootveld/telescope-zoxide",
			"nvim-telescope/telescope-live-grep-args.nvim",
			"nvim-telescope/telescope-frecency.nvim",
			{
				source = "nvim-telescope/telescope-fzf-native.nvim",
				hooks = {
					post_install = make_fzf_native,
					post_checkout = make_fzf_native,
				}
			},
		},
	})

	local telescope = require("telescope")

	telescope.load_extension("undo")
	telescope.load_extension("zoxide")
	telescope.load_extension("live_grep_args")
	telescope.load_extension("frecency")
	telescope.load_extension("fzf")
end)
