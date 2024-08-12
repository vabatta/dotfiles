local add, later = MiniDeps.add, MiniDeps.later

later(function()
	add("echasnovski/mini.surround")

	require("mini.surround").setup()
end)
