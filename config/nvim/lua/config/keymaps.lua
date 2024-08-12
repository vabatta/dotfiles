local bind = require("utils.keybind")
local map_cr = bind.map_cr
local map_cu = bind.map_cu
local map_cmd = bind.map_cmd
local map_callback = bind.map_callback
local now = MiniDeps.now

local core_map = {
	-- Suckless
	["n|<S-Tab>"] = map_cr("normal za"):with_noremap():with_silent():with_desc("edit: Toggle code fold"),
	["n|<C-s>"] = map_cu("write"):with_noremap():with_silent():with_desc("edit: Save file"),
	["n|Y"] = map_cmd("y$"):with_desc("edit: Yank text to EOL"),
	["n|D"] = map_cmd("d$"):with_desc("edit: Delete text to EOL"),
	["n|n"] = map_cmd("nzzzv"):with_noremap():with_desc("edit: Next search result"),
	["n|N"] = map_cmd("Nzzzv"):with_noremap():with_desc("edit: Prev search result"),
	["n|J"] = map_cmd("mzJ`z"):with_noremap():with_desc("edit: Join next line"),
	-- ["n|<Esc>"] = map_callback(function()
	-- 		_flash_esc_or_noh()
	-- 	end)
	-- 	:with_noremap()
	-- 	:with_silent()
	-- 	:with_desc("edit: Clear search highlight"),
	["n|<C-h>"] = map_cmd("<C-w>h"):with_noremap():with_desc("window: Focus left"),
	["n|<C-l>"] = map_cmd("<C-w>l"):with_noremap():with_desc("window: Focus right"),
	["n|<C-j>"] = map_cmd("<C-w>j"):with_noremap():with_desc("window: Focus down"),
	["n|<C-k>"] = map_cmd("<C-w>k"):with_noremap():with_desc("window: Focus up"),
	["t|<C-w>h"] = map_cmd("<Cmd>wincmd h<CR>"):with_silent():with_noremap():with_desc("window: Focus left"),
	["t|<C-w>l"] = map_cmd("<Cmd>wincmd l<CR>"):with_silent():with_noremap():with_desc("window: Focus right"),
	["t|<C-w>j"] = map_cmd("<Cmd>wincmd j<CR>"):with_silent():with_noremap():with_desc("window: Focus down"),
	["t|<C-w>k"] = map_cmd("<Cmd>wincmd k<CR>"):with_silent():with_noremap():with_desc("window: Focus up"),
	["n|<A-h>"] = map_cr("vertical resize -3"):with_silent():with_desc("window: Resize -3 vertically"),
	["n|<A-l>"] = map_cr("vertical resize +3"):with_silent():with_desc("window: Resize +3 vertically"),
	["n|<A-j>"] = map_cr("resize -3"):with_silent():with_desc("window: Resize -3 horizontally"),
	["n|<A-k>"] = map_cr("resize +3"):with_silent():with_desc("window: Resize +3 horizontally"),
	["n|<C-q>"] = map_cr("wq"):with_desc("edit: Save file and quit"),
	["n|<A-S-q>"] = map_cr("q!"):with_desc("edit: Force quit"),
	["n|<leader>o"] = map_cr("setlocal spell! spelllang=en_us"):with_desc("edit: Toggle spell check"),
	["n|tn"] = map_cr("tabnew"):with_noremap():with_silent():with_desc("tab: Create a new tab"),
	["n|tk"] = map_cr("tabnext"):with_noremap():with_silent():with_desc("tab: Move to next tab"),
	["n|tj"] = map_cr("tabprevious"):with_noremap():with_silent():with_desc("tab: Move to previous tab"),
	["n|to"] = map_cr("tabonly"):with_noremap():with_silent():with_desc("tab: Only keep current tab"),
	-- Insert mode
	["i|<C-u>"] = map_cmd("<C-G>u<C-U>"):with_noremap():with_desc("edit: Delete previous block"),
	["i|<C-b>"] = map_cmd("<Left>"):with_noremap():with_desc("edit: Move cursor to left"),
	["i|<C-a>"] = map_cmd("<ESC>^i"):with_noremap():with_desc("edit: Move cursor to line start"),
	["i|<C-s>"] = map_cmd("<Esc>:w<CR>"):with_desc("edit: Save file"),
	["i|<C-q>"] = map_cmd("<Esc>:wq<CR>"):with_desc("edit: Save file and quit"),
	-- Command mode
	["c|<C-b>"] = map_cmd("<Left>"):with_noremap():with_desc("edit: Left"),
	["c|<C-f>"] = map_cmd("<Right>"):with_noremap():with_desc("edit: Right"),
	["c|<C-a>"] = map_cmd("<Home>"):with_noremap():with_desc("edit: Home"),
	["c|<C-e>"] = map_cmd("<End>"):with_noremap():with_desc("edit: End"),
	["c|<C-d>"] = map_cmd("<Del>"):with_noremap():with_desc("edit: Delete"),
	["c|<C-h>"] = map_cmd("<BS>"):with_noremap():with_desc("edit: Backspace"),
	["c|<C-t>"] = map_cmd([[<C-R>=expand("%:p:h") . "/" <CR>]])
		:with_noremap()
		:with_desc("edit: Complete path of current file"),
	-- Visual mode
	["v|J"] = map_cmd(":m '>+1<CR>gv=gv"):with_desc("edit: Move this line down"),
	["v|K"] = map_cmd(":m '<-2<CR>gv=gv"):with_desc("edit: Move this line up"),
	["v|<"] = map_cmd("<gv"):with_desc("edit: Decrease indent"),
	["v|>"] = map_cmd(">gv"):with_desc("edit: Increase indent"),
}

local explorer_map = {
	["n|<leader>e"] = map_cu(":Explore"):with_noremap():with_silent():with_desc("explore: Open file explorer"),
	["n|<leader>E"] = map_cu(":Sexplore"):with_noremap():with_silent():with_desc("explore: Open file explorer in split"),
	["n|<leader>bn"] = map_cu(":enew"):with_noremap():with_silent():with_desc("buffer: New"),
}

local splits_map = {
	-- Plugin: smart-splits.nvim
	["n|<A-h>"] = map_cu("SmartResizeLeft"):with_silent():with_noremap():with_desc("window: Resize -3 horizontally"),
	["n|<A-j>"] = map_cu("SmartResizeDown"):with_silent():with_noremap():with_desc("window: Resize -3 vertically"),
	["n|<A-k>"] = map_cu("SmartResizeUp"):with_silent():with_noremap():with_desc("window: Resize +3 vertically"),
	["n|<A-l>"] = map_cu("SmartResizeRight"):with_silent():with_noremap():with_desc("window: Resize +3 horizontally"),
	["n|<C-h>"] = map_cu("SmartCursorMoveLeft"):with_silent():with_noremap():with_desc("window: Focus left"),
	["n|<C-j>"] = map_cu("SmartCursorMoveDown"):with_silent():with_noremap():with_desc("window: Focus down"),
	["n|<C-k>"] = map_cu("SmartCursorMoveUp"):with_silent():with_noremap():with_desc("window: Focus up"),
	["n|<C-l>"] = map_cu("SmartCursorMoveRight"):with_silent():with_noremap():with_desc("window: Focus right"),
	["n|<leader>Wh"] = map_cu("SmartSwapLeft"):with_silent():with_noremap():with_desc("window: Move window leftward"),
	["n|<leader>Wj"] = map_cu("SmartSwapDown"):with_silent():with_noremap():with_desc("window: Move window downward"),
	["n|<leader>Wk"] = map_cu("SmartSwapUp"):with_silent():with_noremap():with_desc("window: Move window upward"),
	["n|<leader>Wl"] = map_cu("SmartSwapRight"):with_silent():with_noremap():with_desc("window: Move window rightward"),
}

local flash_map = {
	["nxo|s"] = map_callback(function()
			require("flash").jump()
		end)
		:with_noremap()
		:with_silent()
		:with_desc("Flash"),
	["nxo|S"] = map_callback(function()
			require("flash").treesitter()
		end)
		:with_noremap()
		:with_silent()
		:with_desc("Flash Treesitter"),
	["o|r"] = map_callback(function()
			require("flash").remote()
		end)
		:with_noremap()
		:with_silent()
		:with_desc("Remote Flash"),
	["ox|<C-s>"] = map_callback(function()
			require("flash").toggle()
		end)
		:with_noremap()
		:with_silent()
		:with_desc("Toggle Flash Search"),
}

local telescope_map = {
	["n|<C-p>"] = map_callback(function()
			require("telescope.builtin").keymaps({
				lhs_filter = function(lhs)
					return not string.find(lhs, "Þ")
				end,
				layout_config = {
					width = 0.6,
					height = 0.6,
					prompt_position = "top",
				},
			})
		end)
		:with_noremap()
		:with_silent()
		:with_desc("tool: Toggle command panel"),
	["n|<leader>u"] = map_callback(function()
			require("telescope").extensions.undo.undo()
		end)
		:with_noremap()
		:with_silent()
		:with_desc("edit: Show undo history"),
	["n|<leader>fp"] = map_callback(function()
			require("telescope").extensions.projects.projects({})
		end)
		:with_noremap()
		:with_silent()
		:with_desc("find: Project"),
	["n|<leader>fr"] = map_callback(function()
			require("telescope").extensions.frecency.frecency({})
		end)
		:with_noremap()
		:with_silent()
		:with_desc("find: File by frecency"),
	["n|<leader>fw"] = map_callback(function()
			require("telescope").extensions.live_grep_args.live_grep_args()
		end)
		:with_noremap()
		:with_silent()
		:with_desc("find: Word in project"),
	["n|<leader>fe"] = map_cu("Telescope oldfiles"):with_noremap():with_silent():with_desc("find: File by history"),
	["n|<leader>ff"] = map_cu("Telescope find_files"):with_noremap():with_silent():with_desc("find: File in project"),
	["n|<leader>fc"] = map_callback(function()
			require("telescope.builtin").colorscheme({ enable_preview = true })
		end)
		:with_noremap()
		:with_silent()
		:with_desc("ui: Change colorscheme for current session"),
	["n|<leader>fg"] = map_cu("Telescope git_files")
		:with_noremap()
		:with_silent()
		:with_desc("find: file in git project"),
	["n|<leader>fz"] = map_cu("Telescope zoxide list")
		:with_noremap()
		:with_silent()
		:with_desc("edit: Change current direrctory by zoxide"),
	["n|<leader>fb"] = map_cu("Telescope buffers"):with_noremap():with_silent():with_desc("find: Buffer opened"),
	["n|<leader>fs"] = map_cu("Telescope grep_string"):with_noremap():with_silent():with_desc("find: Current word"),
	["v|<leader>fs"] = map_callback(function()
		-- TODO: Update this function to use `vim.getregion()` when v0.10 is released.
			local vbuf_text = function()
				local a_orig = vim.fn.getreg("a")
				local mode = vim.fn.mode()
				if mode ~= "v" and mode ~= "V" then
					vim.cmd([[normal! gv]])
				end
				vim.cmd([[silent! normal! "aygv]])
				local text = vim.fn.getreg("a")
				vim.fn.setreg("a", a_orig)
			end

			require("telescope.builtin").grep_string({ search = vbuf_text() })
		end)
		:with_noremap()
		:with_silent()
		:with_desc("find: Selection text"),
}

now(function()
	bind.nvim_load_mapping(core_map)
	bind.nvim_load_mapping(explorer_map)
	bind.nvim_load_mapping(flash_map)
	bind.nvim_load_mapping(telescope_map)
end)
