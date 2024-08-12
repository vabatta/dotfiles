local add, now = MiniDeps.add, MiniDeps.now

now(function()
	add("prichrd/netrw.nvim")

	require("netrw").setup()
end)