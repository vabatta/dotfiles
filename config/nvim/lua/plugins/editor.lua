--[[
Editor Configuration (core/editor.lua)

Essential Editing (now)
- Auto-pairs: mini.pairs
- Comments: mini.comment

Advanced Editing (later)
- Text Manipulation:
  - mini.surround
  - mini.move
- Code Block Manipulation:
  - treesj (with treesitter dependency)
  - mini.splitjoin (with fallback)
--]]

local add, now, later = MiniDeps.add, MiniDeps.now, MiniDeps.later

-- Essential editing capabilities
now(function()
	-- Auto-pairs (immediate feedback needed)
	add("echasnovski/mini.pairs")
	require("mini.pairs").setup()

	-- Comments (frequently used)
	add("echasnovski/mini.comment")
	require("mini.comment").setup()
end)

-- Advanced editing features
later(function()
	-- Text manipulation
	add("echasnovski/mini.surround")
	require("mini.surround").setup()

	add("echasnovski/mini.move")
	require("mini.move").setup()

	-- Code block manipulation
	add({
		source = "wansmer/treesj",
		depends = { "nvim-treesitter/nvim-treesitter" },
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
	-- Smart split/join handling (Fallback setup - https://github.com/Wansmer/treesj/discussions/19)
	local langs = require("treesj.langs")["presets"]
	vim.api.nvim_create_autocmd({ "FileType" }, {
		pattern = "*",
		callback = function()
			local opts = { buffer = true }
			if langs[vim.bo.filetype] then
				vim.keymap.set("n", "gS", "<Cmd>TSJSplit<CR>", opts)
				vim.keymap.set("n", "gJ", "<Cmd>TSJJoin<CR>", opts)
			else
				vim.keymap.set("n", "gS", function()
					MiniSplitJoin.split()
				end, opts)
				vim.keymap.set("n", "gJ", function()
					MiniSplitJoin.join()
				end, opts)
			end
		end,
	})
end)
