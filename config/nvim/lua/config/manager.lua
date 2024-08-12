local path_package = vim.fn.stdpath("data") .. "/site"
local mini_path = path_package .. "/pack/deps/start/mini.deps"
if not vim.loop.fs_stat(mini_path) then
	vim.cmd("echo 'Installing `mini.deps`' | redraw")
	local clone_cmd = {
		"git", "clone", "--filter=blob:none",
		-- Uncomment next line to use "stable" branch
		-- "--branch", "stable",
		"https://github.com/echasnovski/mini.deps", mini_path
	}
	vim.fn.system(clone_cmd)
	vim.cmd("packadd mini.deps | helptags ALL")
end

-- Load `mini.deps` and setup the path to the package directory
require("mini.deps").setup({ path = { package = path_package } })

--!SECTION ui
require("plugins.colorscheme")
require("plugins.notification")
require("plugins.statusline")
require("plugins.cursorline")
require("plugins.cursorword")
require("plugins.indentguide")
require("plugins.gitsigns")

--!SECTION tool
require("plugins.telescope")
require("plugins.explorer")
require("plugins.splitpane")
require("plugins.whichkey")
require("plugins.zenmode")

--!SECTION lang
require("plugins.lsp")
require("plugins.treesitter")
-- require("plugins.completion")
-- require("plugins.llm")

--!SECTION manipulation
require("plugins.splitjoin")
require("plugins.surround")
require("plugins.comment")
require("plugins.pairs")
require("plugins.move")

--!SECTION navigation
require("plugins.matchup")
require("plugins.textobjects")
require("plugins.jump")
require("plugins.bracketed")
