-- ====================================================================
-- STANDARD VIM AUTOCMDS
-- Enhanced but familiar vim behaviors
-- ====================================================================

-- Number toggle (relative numbers in normal, absolute in insert)
local numbertoggle = vim.api.nvim_create_augroup("numbertoggle", { clear = true })

vim.api.nvim_create_autocmd({ "BufEnter", "FocusGained", "InsertLeave", "WinEnter" }, {
	desc = "Enable relative numbers in normal mode",
	group = numbertoggle,
	pattern = "*",
	callback = function()
		if vim.wo.number and vim.fn.mode() ~= "i" then
			vim.wo.relativenumber = true
		end
	end,
})

vim.api.nvim_create_autocmd({ "BufLeave", "FocusLost", "InsertEnter", "WinLeave" }, {
	desc = "Disable relative numbers in insert mode and unfocused windows",
	group = numbertoggle,
	pattern = "*",
	callback = function()
		if vim.wo.number then
			vim.wo.relativenumber = false
		end
	end,
})

-- File explorer enhancements
local explorer = vim.api.nvim_create_augroup("explorer", { clear = true })

vim.api.nvim_create_autocmd({ "FileType" }, {
	desc = "Better netrw settings",
	group = explorer,
	pattern = "netrw",
	callback = function()
		-- Hide special characters in netrw
		vim.opt_local.list = false
		-- Better netrw keymaps
		local opts = { buffer = true, silent = true }
		vim.keymap.set("n", "q", ":bd<CR>", vim.tbl_extend("force", opts, { desc = "Close netrw" }))
		vim.keymap.set("n", "<C-l>", "<C-w>l", vim.tbl_extend("force", opts, { desc = "Move to right window" }))
		vim.keymap.set("n", "h", "-", vim.tbl_extend("force", opts, { desc = "Go up directory" }))
		vim.keymap.set("n", "l", "<CR>", vim.tbl_extend("force", opts, { desc = "Open file/directory" }))
	end,
})

-- Cursor and view management
local cursor = vim.api.nvim_create_augroup("cursor", { clear = true })

vim.api.nvim_create_autocmd({ "BufReadPost" }, {
	desc = "Restore cursor position when opening file",
	group = cursor,
	pattern = "*",
	callback = function()
		local mark = vim.api.nvim_buf_get_mark(0, '"')
		local lcount = vim.api.nvim_buf_line_count(0)
		if mark[1] > 0 and mark[1] <= lcount then
			pcall(vim.api.nvim_win_set_cursor, 0, mark)
		end
	end,
})

vim.api.nvim_create_autocmd({ "TextYankPost" }, {
	desc = "Highlight yanked text",
	group = cursor,
	pattern = "*",
	callback = function()
		vim.highlight.on_yank({ timeout = 200 })
	end,
})

-- LSP enhancements
local lsp = vim.api.nvim_create_augroup("lsp", { clear = true })

vim.api.nvim_create_autocmd("LspAttach", {
	desc = "LSP keymaps and settings",
	group = lsp,
	callback = function(event)
		-- Load LSP-specific keymaps
		local mapping = require("config.keymaps")
		mapping.lsp(event.buf)

		-- Enable inlay hints if supported
		local client = vim.lsp.get_client_by_id(event.data.client_id)
		if client and client.server_capabilities.inlayHintProvider then
			vim.lsp.inlay_hint.enable(true, { bufnr = event.buf })
		end

		-- LSP-specific settings
		vim.bo[event.buf].omnifunc = "v:lua.vim.lsp.omnifunc"

		-- Auto-format on save for certain filetypes
		if client and client.supports_method("textDocument/formatting") then
			vim.api.nvim_create_autocmd("BufWritePre", {
				buffer = event.buf,
				callback = function()
					-- Add filetypes that should auto-format here
					local auto_format_filetypes = { "go", "lua", "python", "rust" }
					if vim.tbl_contains(auto_format_filetypes, vim.bo.filetype) then
						vim.lsp.buf.format({ bufnr = event.buf })
					end
				end,
			})
		end
	end,
})

-- Terminal enhancements
local terminal = vim.api.nvim_create_augroup("terminal", { clear = true })

vim.api.nvim_create_autocmd({ "TermOpen" }, {
	desc = "Terminal mode settings",
	group = terminal,
	pattern = "*",
	callback = function()
		-- Disable line numbers in terminal
		vim.opt_local.number = false
		vim.opt_local.relativenumber = false
		vim.opt_local.signcolumn = "no"

		-- Start in insert mode
		vim.cmd("startinsert")

		-- Terminal-specific keymaps
		local opts = { buffer = true, silent = true }
		vim.keymap.set("t", "<Esc>", "<C-\\><C-n>", vim.tbl_extend("force", opts, { desc = "Exit terminal mode" }))
		vim.keymap.set("t", "<C-h>", "<C-\\><C-n><C-w>h", vim.tbl_extend("force", opts, { desc = "Move to left window" }))
		vim.keymap.set("t", "<C-j>", "<C-\\><C-n><C-w>j", vim.tbl_extend("force", opts, { desc = "Move to bottom window" }))
		vim.keymap.set("t", "<C-k>", "<C-\\><C-n><C-w>k", vim.tbl_extend("force", opts, { desc = "Move to top window" }))
		vim.keymap.set("t", "<C-l>", "<C-\\><C-n><C-w>l", vim.tbl_extend("force", opts, { desc = "Move to right window" }))
	end,
})

-- Filetype-specific enhancements
local filetype = vim.api.nvim_create_augroup("filetype", { clear = true })

vim.api.nvim_create_autocmd({ "FileType" }, {
	desc = "Enable spell check for text files",
	group = filetype,
	pattern = { "gitcommit", "markdown", "text", "tex" },
	callback = function()
		vim.opt_local.spell = true
		vim.opt_local.spelllang = "en_us"
	end,
})

vim.api.nvim_create_autocmd({ "FileType" }, {
	desc = "Quickfix window settings",
	group = filetype,
	pattern = "qf",
	callback = function()
		-- Better quickfix keymaps
		local opts = { buffer = true, silent = true }
		vim.keymap.set("n", "q", ":q<CR>", vim.tbl_extend("force", opts, { desc = "Close quickfix" }))
		vim.keymap.set("n", "<CR>", "<CR>", vim.tbl_extend("force", opts, { desc = "Go to item" }))
		vim.keymap.set("n", "o", "<CR><C-w>p", vim.tbl_extend("force", opts, { desc = "Open item" }))
	end,
})

-- Help window enhancements
vim.api.nvim_create_autocmd({ "FileType" }, {
	desc = "Help window settings",
	group = filetype,
	pattern = "help",
	callback = function()
		-- Open help in vertical split if window is wide enough
		if vim.o.columns >= 160 then
			vim.cmd("wincmd L")
		end

		-- Better help navigation
		local opts = { buffer = true, silent = true }
		vim.keymap.set("n", "q", ":q<CR>", vim.tbl_extend("force", opts, { desc = "Close help" }))
		vim.keymap.set("n", "<CR>", "<C-]>", vim.tbl_extend("force", opts, { desc = "Follow link" }))
		vim.keymap.set("n", "<BS>", "<C-t>", vim.tbl_extend("force", opts, { desc = "Go back" }))
	end,
})

-- Window management
local windows = vim.api.nvim_create_augroup("windows", { clear = true })

vim.api.nvim_create_autocmd({ "VimResized" }, {
	desc = "Automatically resize windows when vim is resized",
	group = windows,
	pattern = "*",
	callback = function()
		vim.cmd("tabdo wincmd =")
	end,
})

-- Create directory if it doesn't exist when saving
local directories = vim.api.nvim_create_augroup("directories", { clear = true })

vim.api.nvim_create_autocmd({ "BufWritePre" }, {
	desc = "Create directory if it doesn't exist",
	group = directories,
	pattern = "*",
	callback = function()
		local dir = vim.fn.expand("%:p:h")
		if vim.fn.isdirectory(dir) == 0 then
			vim.fn.mkdir(dir, "p")
		end
	end,
})

-- Improved search highlighting
local search = vim.api.nvim_create_augroup("search", { clear = true })

vim.api.nvim_create_autocmd({ "CmdlineEnter" }, {
	desc = "Enable search highlighting when entering command mode",
	group = search,
	pattern = "/,\\?",
	callback = function()
		vim.opt.hlsearch = true
	end,
})

vim.api.nvim_create_autocmd({ "CmdlineLeave" }, {
	desc = "Auto-clear search highlight after a delay",
	group = search,
	pattern = "/,\\?",
	callback = function()
		vim.defer_fn(function()
			vim.cmd("nohlsearch")
		end, 3000)
	end,
})

-- Better editing experience
local editing = vim.api.nvim_create_augroup("editing", { clear = true })

vim.api.nvim_create_autocmd({ "InsertEnter" }, {
	desc = "Disable paste mode when entering insert",
	group = editing,
	pattern = "*",
	callback = function()
		vim.opt.paste = false
	end,
})

-- Automatically equalize splits when vim is resized
vim.api.nvim_create_autocmd({ "VimResized" }, {
	desc = "Equalize splits on resize",
	group = editing,
	pattern = "*",
	callback = function()
		vim.cmd("wincmd =")
	end,
})

-- Jump to last edit position
vim.api.nvim_create_autocmd({ "BufReadPost" }, {
	desc = "Jump to last edit position",
	group = editing,
	pattern = "*",
	callback = function()
		local last_pos = vim.fn.line("'\"")
		if last_pos > 0 and last_pos <= vim.fn.line("$") then
			vim.cmd('normal! g`"')
		end
	end,
})

-- Automatically close certain windows with 'q'
local close_with_q = vim.api.nvim_create_augroup("close_with_q", { clear = true })

vim.api.nvim_create_autocmd({ "FileType" }, {
	desc = "Close certain filetypes with 'q'",
	group = close_with_q,
	pattern = {
		"qf",
		"help",
		"man",
		"notify",
		"lspinfo",
		"spectre_panel",
		"startuptime",
		"tsplayground",
		"PlenaryTestPopup",
	},
	callback = function(event)
		vim.bo[event.buf].buflisted = false
		vim.keymap.set("n", "q", "<cmd>close<cr>", { buffer = event.buf, silent = true, desc = "Close window" })
	end,
})
