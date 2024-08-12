local add, now = MiniDeps.add, MiniDeps.now

now(function()
	add({
		source = "neovim/nvim-lspconfig",
		depends = {
			"williamboman/mason.nvim",
			"williamboman/mason-lspconfig.nvim"
		}
	})

	require("mason").setup()
	require("mason-lspconfig").setup({
		ensure_installed = { "lua_ls", "gopls", "zls" },
		handlers = {
			function(server_name)
				require("lspconfig")[server_name].setup({})
			end,
		},
	})
end)
