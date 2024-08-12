local add, later = MiniDeps.add, MiniDeps.later

later(function()
	add("folke/which-key.nvim")

	require("which-key").setup()
end)
