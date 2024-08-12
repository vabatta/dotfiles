local add, now = MiniDeps.add, MiniDeps.now

now(function()
	add({
		source = "echasnovski/mini.statusline",
		depends = { "echasnovski/mini.icons" },
	})

	require("mini.statusline").setup()
end)
