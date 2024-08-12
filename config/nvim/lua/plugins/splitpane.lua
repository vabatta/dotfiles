local add, later = MiniDeps.add, MiniDeps.later

later(function()
	add("mrjones2014/smart-splits.nvim")

	require("smart-splits").setup()
end)
