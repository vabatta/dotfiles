local add, later = MiniDeps.add, MiniDeps.later

later(function()
	add("echasnovski/mini.comment")

	require("mini.comment").setup()
end)
