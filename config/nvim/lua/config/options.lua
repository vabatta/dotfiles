vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

local opt = vim.opt

opt.autowrite = true -- Enable auto write

if not vim.env.SSH_TTY then
	-- only set clipboard if not in ssh, to make sure the OSC 52
	-- integration works automatically. Requires Neovim >= 0.10.0
	opt.clipboard = "unnamedplus" -- Sync with system clipboard
end

opt.completeopt = "menu,menuone,noselect"
opt.conceallevel = 2 -- Hide * markup for bold and italic, but not markers with substitutions
opt.confirm = true -- Confirm to save changes before exiting modified buffer
opt.cursorline = true -- Enable highlighting of the current line
opt.expandtab = true -- Use spaces instead of tabs
opt.formatoptions = "jcroqlnt" -- tcqj
opt.grepformat = "%f:%l:%c:%m"
opt.grepprg = "rg --vimgrep"
opt.ignorecase = true -- Ignore case
opt.inccommand = "nosplit" -- preview incremental substitute
opt.laststatus = 3 -- global statusline
opt.linebreak = true -- Wrap long lines at a character in 'breakat'
opt.list = true -- Show some invisible characters (tabs...
opt.mouse = "a" -- Enable mouse mode
opt.number = true -- Print line number
opt.pumblend = 10 -- Popup blend
opt.pumheight = 10 -- Maximum number of entries in a popup
opt.relativenumber = true -- Relative line numbers
opt.scrolloff = 4 -- Lines of context
opt.sessionoptions = { "buffers", "curdir", "tabpages", "winsize", "help", "globals", "skiprtp", "folds" }
opt.shiftround = true -- Round indent
opt.showbreak = "↪" -- Non-ASCII character for the break line
opt.softtabstop = 2 -- Number of spaces inserted instead of a tab character
opt.shiftwidth = 2 -- Size of an indent
opt.shortmess:append({ W = true, I = true, c = true, C = true })
opt.showmode = false -- Dont show mode since we have a statusline
opt.sidescrolloff = 8 -- Columns of context
opt.signcolumn = "yes" -- Always show the signcolumn, otherwise it would shift the text each time
opt.smartcase = true -- Don't ignore case with capitals
opt.smartindent = true -- Insert indents automatically
opt.smarttab = true -- tab respects 'tabstop', 'shiftwidth', and 'softtabstop'
opt.spelllang = { "en" }
opt.splitbelow = true -- Put new windows below current
opt.splitkeep = "screen"
opt.splitright = true -- Put new windows right of current
opt.tabstop = 2 -- Number of spaces tabs count for
opt.termguicolors = true -- True color support
if not vim.g.vscode then
	opt.timeoutlen = 300 -- Lower than default (1000) to quickly trigger which-key
end
opt.undofile = true
opt.undolevels = 10000
opt.updatetime = 200 -- Save swap file and trigger CursorHold
opt.virtualedit = "block" -- Allow cursor to move where there is no text in visual block mode
opt.wildmode = "longest:full,full" -- Command-line completion mode
opt.winminwidth = 5 -- Minimum window width
opt.wrap = false -- Disable line wrap

opt.fillchars = { foldopen = "", foldclose = "", fold = " ", foldsep = " ", diff = "╱", eob = " " }
opt.listchars = { space = "·", tab = "→ ", eol = "¬", trail = "⋅", extends = "❯", precedes = "❮" }

if vim.fn.has("nvim-0.10") == 1 then
	opt.smoothscroll = true
end

-- Fix markdown indentation settings
vim.g.markdown_recommended_style = 0

-- coloring
local system_theme = function()
	local command = "defaults read -g AppleInterfaceStyle 2>/dev/null"
	local handle = io.popen(command)
	local result = handle:read("*a"):gsub("%s", "")
	handle:close()

	if result:match("Dark") then
		return "dark"
	else
		return "light"
	end
end

-- set the colorscheme to the system theme
opt.background = system_theme()