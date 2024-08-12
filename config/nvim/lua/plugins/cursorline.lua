local add, later = MiniDeps.add, MiniDeps.later

later(function()
	add("tummetott/reticle.nvim")

	require("reticle").setup({
		on_startup = {
			cursorline = true,
			cursorcolumn = true,
		}
	})
end)
