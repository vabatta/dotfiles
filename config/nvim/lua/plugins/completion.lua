local add, later = MiniDeps.add, MiniDeps.later

later(function()
	add("echasnovski/mini.completion")

	require("mini.completion").setup()
end)
