local path_package = vim.fn.stdpath("data") .. "/site"
local mini_path = path_package .. "/pack/deps/start/mini.deps"
if not vim.loop.fs_stat(mini_path) then
	vim.cmd("echo 'Installing `mini.deps`' | redraw")
	local clone_cmd = {
		"git",
		"clone",
		"--filter=blob:none",
		-- Uncomment next line to use "stable" branch
		-- "--branch", "stable",
		"https://github.com/echasnovski/mini.deps",
		mini_path,
	}
	vim.fn.system(clone_cmd)
	vim.cmd("packadd mini.deps | helptags ALL")
end

-- Load `mini.deps` and setup the path to the package directory
require("mini.deps").setup({ path = { package = path_package } })

require("plugins.ui")
require("plugins.editor")
require("plugins.nav")
require("plugins.lsp")
