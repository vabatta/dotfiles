local add, later = MiniDeps.add, MiniDeps.later

later(function()
	add({
		source = "huggingface/llm.nvim",
		depends = {
			{
				source = "williamboman/mason.nvim",
				hooks = {
					post_checkout = function() vim.cmd("MasonInstall llm-ls") end
				}
			}
		}
	})

	-- require("llm").setup({
	-- 	lsp = {
	-- 		bin_path = vim.api.nvim_call_function("stdpath", { "data" }) .. "/mason/bin/llm-ls",
	-- 	},
	-- })
end)
