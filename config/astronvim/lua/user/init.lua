-- Set theme based on system theme
local function set_theme()
	-- REVIEW: for some reason, this doesn't work all the time
	-- local system_theme = vim.fn.system("zsh -i -c 'current_theme'")
	local system_theme = vim.fn.system("zsh -c 'sh $DOTFILES/zsh/functions/current_theme'")
	if system_theme == "dark" then
		vim.opt.background = "dark"
	else
		vim.opt.background = "light"
	end
end

-- Register for signal SIGUSR1 to change theme
vim.api.nvim_create_autocmd("Signal", {
	pattern = { "SIGUSR1" },
	desc = "Change theme based on system theme",
	callback = function(event) set_theme() end,
})

-- Call on load
set_theme()

return {
  colorscheme = "gruvbox",

  plugins = {},
}