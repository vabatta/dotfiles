local add, later = MiniDeps.add, MiniDeps.later

later(function()
	add("echasnovski/mini.cursorword")

	require("mini.cursorword").setup()
end)
