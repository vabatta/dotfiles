-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

local opt = vim.opt

-- set soft wrapping
opt.linebreak = true
opt.showbreak = "↪"

-- toggle invisible characters
opt.list = true
opt.listchars = { space = "·", tab = "→ ", eol = "¬", trail = "⋅", extends = "❯", precedes = "❮" }

-- tab control
opt.autoindent = true -- copy indent from current line when starting a new line
opt.expandtab = false -- use tabs instead of spaces
opt.smarttab = true -- tab respects 'tabstop', 'shiftwidth', and 'softtabstop'
opt.tabstop = 2 -- the visible width of tabs
opt.softtabstop = 2 -- number of spaces inserted instead of a tab character
opt.shiftwidth = 2 -- number of spaces inserted for indentation
opt.shiftround = true -- round indent to a multiple of 'shiftwidth'
