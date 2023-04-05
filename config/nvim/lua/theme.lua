-- setup must be called before loading the colorscheme
require("gruvbox").setup({
	contrast = "soft"
})

local system_theme = vim.fn.system("defaults read -g AppleInterfaceStyle")
if string.match(system_theme, '^Dark') == 'Dark' then
	vim.o.background = "dark"
else
	vim.o.background = "light"
end

vim.cmd([[colorscheme gruvbox]])
