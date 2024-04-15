return {
	{
		"catppuccin/nvim",
		lazy = true,
		name = "catppuccin",
		init = function()
			vim.cmd.colorscheme "catppuccin"
		end,
		opts = {
			
		},
	}
}