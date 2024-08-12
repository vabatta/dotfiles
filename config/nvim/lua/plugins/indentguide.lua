local add, later = MiniDeps.add, MiniDeps.later

later(function()
	-- add("lukas-reineke/indent-blankline.nvim")

	-- require("ibl").setup()

	add("echasnovski/mini.indentscope")

	require("mini.indentscope").setup()
end)
