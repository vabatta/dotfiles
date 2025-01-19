--[[
LSP Configuration (core/lsp.lua)

Core LSP (now)
- LSP and Package Management:
  - nvim-lspconfig
  - mason.nvim
  - mason-lspconfig.nvim
- Syntax Highlighting:
  - nvim-treesitter

Enhanced LSP (later)
- LSP UI:
  - lspsaga.nvim
  - glance.nvim
- Diagnostics:
  - trouble.nvim
--]]

local add, now, later = MiniDeps.add, MiniDeps.now, MiniDeps.later

-- Core LSP functionality
now(function()
	-- LSP and package management
	add({
		source = "neovim/nvim-lspconfig",
		depends = {
			"williamboman/mason.nvim",
			"williamboman/mason-lspconfig.nvim",
		},
	})

	require("mason").setup()
	require("mason-lspconfig").setup({
		ensure_installed = {
			"lua_ls",
			"zls",
			"ts_ls",
			"biome",
			"dockerls",
			"bashls",
		},
		handlers = {
			function(server_name)
				require("lspconfig")[server_name].setup({})
				vim.notify("LSP server " .. server_name .. " started", vim.log.levels.INFO)
			end,
		},
	})

	-- Syntax highlighting
	add({
		source = "nvim-treesitter/nvim-treesitter",
		hooks = {
			post_checkout = function()
				vim.cmd("TSUpdate")
			end,
		},
	})
	require("nvim-treesitter.configs").setup({
		ensure_installed = {
			"lua",
			"vimdoc",
			"zig",
			"typescript",
			"html",
			"css",
			"json",
			"toml",
		},
		highlight = {
			enable = true,
			additional_vim_regex_highlighting = false,
		},
		indent = { enable = true },
		matchup = { enable = true },
	})
end)

-- Enhanced LSP features
later(function()
	-- LSP UI enhancements
	add({
		source = "nvimdev/lspsaga.nvim",
		depends = { "nvim-treesitter/nvim-treesitter" },
	})
	require("lspsaga").setup({
		lightbulb = { enable = false },
	})

	add({ source = "dnlhc/glance.nvim" })
	require("glance").setup({})

	-- Diagnostic tools
	add({ source = "folke/trouble.nvim" })
	require("trouble").setup()
end)
