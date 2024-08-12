local add, later = MiniDeps.add, MiniDeps.later

later(function()
	add("folke/flash.nvim")

	require("flash").setup()

	add("echasnovski/mini.jump2d")

	require("mini.jump2d").setup()
end)
