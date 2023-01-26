-- setup must be called before loading the colorscheme
require("gruvbox").setup({
	contrast = "soft"
})

vim.o.background = "dark"
vim.cmd([[colorscheme gruvbox]])
