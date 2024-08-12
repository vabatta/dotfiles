vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Disable menu loading
vim.g.did_install_default_menus = 1
vim.g.did_install_syntax_menu = 1

vim.g.loaded_syntax_completion = 1 -- Do not load native syntax completion
vim.g.loaded_spellfile_plugin = 1 -- Do not load spell files
vim.g.loaded_2html_plugin = 1 -- Do not load tohtml.vim

-- Whether to load netrw by default
-- vim.g.loaded_netrw = 1
-- vim.g.loaded_netrwFileHandlers = 1
-- vim.g.loaded_netrwPlugin = 1
-- vim.g.loaded_netrwSettings = 1
-- newtrw liststyle: https://medium.com/usevim/the-netrw-style-options-3ebe91d42456
vim.g.netrw_banner = 0
vim.g.netrw_liststyle = 3

-- Do not load zipPlugin.vim, gzip.vim and tarPlugin.vim (all of these plugins are
-- related to reading files inside compressed containers)
vim.g.loaded_gzip = 1
vim.g.loaded_tar = 1
vim.g.loaded_tarPlugin = 1
vim.g.loaded_vimball = 1
vim.g.loaded_vimballPlugin = 1
vim.g.loaded_zip = 1
vim.g.loaded_zipPlugin = 1

-- Do not use builtin matchit.vim and matchparen.vim because we're using vim-matchup
vim.g.loaded_matchit = 1
vim.g.loaded_matchparen = 1

vim.g.loaded_sql_completion = 1 -- Disable sql omni completion

vim.g.editorconfig = 1 -- Enable native EditorConfig support
vim.g.markdown_recommended_style = 0 -- Fix markdown indentation settings

-- Disable remote plugins
-- NOTE:
--  > Disabling rplugin.vim will make `wilder.nvim` complain about missing rplugins during :checkhealth,
--  > but since it's config doesn't require python rtp (strictly), it's fine to ignore that for now.
vim.g.loaded_remote_plugins = 1

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
opt.cursorcolumn = true -- Enable highlighting of the current column
opt.expandtab = true -- Use spaces instead of tabs
opt.formatoptions = "jcroqlnt" -- tcqj
opt.grepformat = "%f:%l:%c:%m"
opt.grepprg = "rg --vimgrep"
opt.ignorecase = true -- Ignore case
opt.inccommand = "nosplit" -- preview incremental substitute
opt.laststatus = 3 -- global statusline
opt.linebreak = true -- Wrap long lines at a character in 'breakat'
opt.list = true -- Show some invisible characters (tabs...)
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
opt.listchars = { space = "·", tab = "→ ", eol = "↵", trail = "⋅", extends = "❯", precedes = "❮" }

if vim.fn.has("nvim-0.10") == 1 then
	opt.smoothscroll = true
end

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
