local utils = require("utils")
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable",
		lazypath
	})
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
	{ "ellisonleao/gruvbox.nvim", lazy = false, priority = 1000 }, -- theme
	"tpope/vim-sensible", -- sensible defaults
	"tpope/vim-commentary", -- easy commenting
	"tpope/vim-eunuch", -- UNIX shell commands from vim
	"tpope/vim-characterize", -- character representation revealers
	"tpope/vim-unimpaired", -- easy navigation
	"tpope/vim-surround", -- bracket mappings for moving between buffers, quickfix items, etc.
	"tpope/vim-ragtag", -- endings for html, xml, etc. - ehances surround
	"tpope/vim-abolish", -- substitution and abbreviation helpers
	"tpope/vim-repeat", -- enables repeating other supported plugins with the . command
	"tpope/vim-sleuth", -- detect indent style (tabs vs. spaces)
	{
		"tpope/vim-fugitive",
		lazy = false,
		keys = {
			{ "<leader>gr", "<cmd>Gread<cr>", desc = "read file from git" },
			{ "<leader>gb", "<cmd>G blame<cr>", desc = "read file from git" }
		},
		dependencies = { "tpope/vim-rhubarb" }
	}, -- a git wrapper with GitHub integration (using rhubarb)
	"tpope/vim-dispatch", -- asynchronous build and test dispatcher 
	"tpope/vim-speeddating", -- increment/decrement dates, times, and more
	"tpope/vim-endwise", -- end blocks for ruby, python, etc.
	"tpope/vim-dotenv", -- basic support for .env and Procfile
	"tpope/vim-markdown", -- markdown helpers
	"tpope/vim-cucumber", -- cucumber helpers
	"tpope/vim-obsession", -- session helpers
	{ "nvim-tree/nvim-tree.lua", dependencies = { { "nvim-tree/nvim-web-devicons", opt = true } } }, -- file tree
	"github/copilot.vim", -- github copilot
	{ "windwp/nvim-autopairs", config = true }, -- automatically complete brackets/parens/quotes
	{ "junegunn/fzf.vim", dependencies = { { dir = (vim.env.HOMEBREW_PREFIX or "/opt/homebrew") .. "/opt/fzf" } } }, -- fzf
	{ "nvim-lualine/lualine.nvim", dependencies = { { "nvim-tree/nvim-web-devicons", opt = true } } }
})

-- Plugins configuration
require('lualine').setup({
	options = { theme = 'gruvbox' }
})
