local add, later = MiniDeps.add, MiniDeps.later

later(function()
	add("echasnovski/mini.ai")

	require('mini.ai').setup()
end)
