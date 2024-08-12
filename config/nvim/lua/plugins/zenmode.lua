local add, later = MiniDeps.add, MiniDeps.later

later(function()
	add({
		source = "folke/zen-mode.nvim",
		depends = { "folke/twilight.nvim" },
	})
end)
