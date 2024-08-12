local add, later = MiniDeps.add, MiniDeps.later

later(function()
	add("echasnovski/mini.move")

	require("mini.move").setup()
end)
