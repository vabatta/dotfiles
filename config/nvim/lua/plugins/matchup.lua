local add, later = MiniDeps.add, MiniDeps.later

later(function()
	add({
		source = "andymass/vim-matchup",
		depends = { "nvim-treesitter/nvim-treesitter" }
	})

	require("match-up").setup({})
end)
