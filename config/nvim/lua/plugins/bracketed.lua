local add, later = MiniDeps.add, MiniDeps.later

later(function()
	add("echasnovski/mini.bracketed")

	require("mini.bracketed").setup()
end)
