-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

-- set soft wrapping
vim.opt.linebreak = true
vim.opt.showbreak = "↪"

-- toggle invisible characters
vim.opt.list = true
vim.opt.listchars = { tab = "→ ", eol = "¬", trail = "⋅", extends = "❯", precedes = "❮" }

-- tab control
vim.opt.autoindent = true -- copy indent from current line when starting a new line
vim.opt.expandtab = false -- use tabs instead of spaces
vim.opt.smarttab = true -- tab respects 'tabstop', 'shiftwidth', and 'softtabstop'
vim.opt.tabstop = 2 -- the visible width of tabs
vim.opt.softtabstop = 2 -- edit as if the tabs are 4 characters wide
vim.opt.shiftwidth = 2 -- number of spaces to use for indent and unindent
vim.opt.shiftround = true -- round indent to a multiple of 'shiftwidth'
