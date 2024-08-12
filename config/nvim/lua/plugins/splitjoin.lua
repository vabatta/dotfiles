local add, later = MiniDeps.add, MiniDeps.later

later(function()
	-- Use treesitter to split/join
	add({
		source = "wansmer/treesj",
		depends = { "nvim-treesitter/nvim-treesitter" }
	})

	require("treesj").setup({
		use_default_keymaps = false,
	})

	-- Fallback plugin when treesitter language is not available
	add("echasnovski/mini.splitjoin")

	local MiniSplitJoin = require("mini.splitjoin")
	MiniSplitJoin.setup({
		mappings = {
			toggle = "",
			split = "",
			join = "",
		},
	})

	-- Fallback setup - https://github.com/Wansmer/treesj/discussions/19
	local langs = require("treesj.langs")["presets"]

	vim.api.nvim_create_autocmd({ "FileType" }, {
		pattern = "*",
		callback = function()
			local opts = { buffer = true }
			if langs[vim.bo.filetype] then
				vim.keymap.set("n", "gS", "<Cmd>TSJSplit<CR>", opts)
				vim.keymap.set("n", "gJ", "<Cmd>TSJJoin<CR>", opts)
			else
				vim.keymap.set("n", "gS", function() MiniSplitJoin.split() end, opts)
				vim.keymap.set("n", "gJ", function() MiniSplitJoin.join() end, opts)
			end
		end,
	})
end)
