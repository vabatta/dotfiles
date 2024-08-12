local add, later = MiniDeps.add, MiniDeps.later

later(function()
	add("echasnovski/mini.pairs")

	require("mini.pairs").setup()
end)
