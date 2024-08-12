local add, later = MiniDeps.add, MiniDeps.later

later(function()
	add("lewis6991/gitsigns.nvim")

	require('gitsigns').setup()
end)
