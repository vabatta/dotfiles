local numbertoggle = vim.api.nvim_create_augroup("numbertoggle", { clear = true })

vim.api.nvim_create_autocmd({ "BufEnter", "FocusGained", "InsertLeave", "WinEnter" }, {
	desc = "Enable relative numbers when opening a buffer or leaving insert mode",
	group = numbertoggle,
	pattern = "*",
	callback = function()
		if vim.wo.number and vim.fn.mode() ~= "i" then
			vim.wo.relativenumber = true
		end
	end,
})

vim.api.nvim_create_autocmd({ "BufLeave", "FocusLost", "InsertEnter", "WinLeave" }, {
	desc = "Disable relative numbers when leaving a buffer or entering insert mode",
	group = numbertoggle,
	pattern = "*",
	callback = function()
		if vim.wo.number then
			vim.wo.relativenumber = false
		end
	end,
})

local hidespecials = vim.api.nvim_create_augroup("hidespecials", { clear = true })

vim.api.nvim_create_autocmd({ "BufModifiedSet" }, {
	desc = "Hide special characters in netrw",
	group = hidespecials,
	pattern = "*",
	callback = function()
		if vim.bo and vim.bo.filetype == "netrw" then
			vim.opt_local.list = false
		end
	end,
})

local cdpwd = vim.api.nvim_create_augroup("cdpwd", { clear = true })

vim.api.nvim_create_autocmd({ "VimEnter" }, {
	desc = "CD into opened PWD",
	group = cdpwd,
	pattern = "*",
	callback = function()
		vim.api.nvim_set_current_dir(vim.fn.expand("%:p:h"))
	end,
})

local lspattach = vim.api.nvim_create_augroup("LspKeymapLoader", { clear = true })
local mapping = require("config.keymaps")

vim.api.nvim_create_autocmd("LspAttach", {
	group = lspattach,
	callback = function(event)
		-- LSP Keymaps
		mapping.lsp(event.buf)

		-- LSP Inlay Hints
		local client = vim.lsp.get_client_by_id(event.data.client_id)
		if client and client.server_capabilities.inlayHintProvider ~= nil then
			vim.lsp.inlay_hint.enable(true, { bufnr = event.buf })
		end
	end,
})
