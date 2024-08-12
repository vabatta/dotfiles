local add, later = MiniDeps.add, MiniDeps.later

later(function()
	add({
		source = "nvim-treesitter/nvim-treesitter",
		hooks = {
			post_checkout = function() vim.cmd("TSUpdate") end
		},
	})

	require("nvim-treesitter.configs").setup({
		ensure_installed = { "lua", "vimdoc", "go", "zig" },
		highlight = {
			enable = true,
			additional_vim_regex_highlighting = false
		},
		indent = { enable = true },
		matchup = {
			enable = true,
		},
	})
end)
