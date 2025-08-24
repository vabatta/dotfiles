local bind = require("utils.keybind")
local map_cr = bind.map_cr
local map_cu = bind.map_cu
local map_cmd = bind.map_cmd
local map_callback = bind.map_callback
local now = MiniDeps.now

local export_mapping = {}

local basic = {
	-- File operations (standard vim commands)
	["n|<leader>w"] = map_cr("write"):with_noremap():with_silent():with_desc("file: Write (save)"),
	["n|<leader>q"] = map_cr("quit"):with_desc("file: Quit"),
	["n|<leader>x"] = map_cr("wq"):with_desc("file: Write and quit"),
	["n|ZZ"] = map_cr("wq"):with_desc("file: Write and quit (vim standard)"),
	["n|ZQ"] = map_cr("q!"):with_desc("file: Force quit (vim standard)"),

	-- Insert mode escapes (common patterns)
	["i|jj"] = map_cmd("<Esc>"):with_desc("mode: Exit insert mode"),
	["i|jk"] = map_cmd("<Esc>"):with_desc("mode: Exit insert mode"),

	-- Quick save from insert mode
	["i|<C-s>"] = map_cmd("<Esc>:w<CR>a"):with_desc("file: Save and stay in insert"),

	-- Undo/Redo (keeping vim defaults, just adding descriptions)
	-- Note: u and <C-r> are vim defaults, no need to remap

	-- Better line navigation (display lines vs real lines)
	["n|gj"] = map_cmd("gj"):with_desc("move: Down (display line)"),
	["n|gk"] = map_cmd("gk"):with_desc("move: Up (display line)"),

	-- Center screen on jumps (common pattern)
	["n|<C-d>"] = map_cmd("<C-d>zz"):with_desc("move: Half page down (centered)"),
	["n|<C-u>"] = map_cmd("<C-u>zz"):with_desc("move: Half page up (centered)"),
	["n|G"] = map_cmd("Gzz"):with_desc("move: Go to end (centered)"),
	["n|gg"] = map_cmd("ggzz"):with_desc("move: Go to start (centered)"),

	-- Which-key manual trigger - show all available keybindings
	["n|<leader>?"] = map_callback(function()
		require("which-key").show({ global = true })
	end):with_desc("help: Show all keybindings"),

	-- Show leader key bindings specifically
	["n|<leader><leader>?"] = map_callback(function()
		require("which-key").show({ keys = "<leader>", loop = true })
	end):with_desc("help: Show leader key bindings"),

	-- Show keybindings for current mode
	["n|<F1>"] = map_callback(function()
		require("which-key").show({ global = true })
	end):with_desc("help: Show keybindings (F1)"),
}

local editing = {
	-- Visual mode line movement (popular pattern)
	["v|J"] = map_cmd(":m '>+1<CR>gv=gv"):with_desc("edit: Move selection down"),
	["v|K"] = map_cmd(":m '<-2<CR>gv=gv"):with_desc("edit: Move selection up"),

	-- Keep selection when indenting (standard enhancement)
	["v|<"] = map_cmd("<gv"):with_desc("edit: Indent left (keep selection)"),
	["v|>"] = map_cmd(">gv"):with_desc("edit: Indent right (keep selection)"),
	["v|="] = map_cmd("=gv"):with_desc("edit: Auto-indent (keep selection)"),

	-- Join lines (standard vim with enhancement) - avoid conflict with motion J
	["n|gJ"] = map_cmd("mzJ`z"):with_desc("edit: Join next line (enhanced)"),

	-- Word case changes (use standard vim commands)
	["n|guw"] = map_cmd("guiw"):with_desc("edit: Lowercase word"),
	["n|gUw"] = map_cmd("gUiw"):with_desc("edit: Uppercase word"),
	["n|g~w"] = map_cmd("g~iw"):with_desc("edit: Toggle case word"),

	-- Smart split/join (treesj integration) - using different keys to avoid conflicts
	["n|<leader>js"] = map_callback(function()
		require("treesj").split()
	end):with_desc("edit: Smart split"),
	["n|<leader>jj"] = map_callback(function()
		require("treesj").join()
	end):with_desc("edit: Smart join"),

	-- Toggle features
	["n|<leader>ts"] = map_cr("setlocal spell! spelllang=en_us"):with_desc("toggle: Spell check"),
	["n|<leader>tw"] = map_cr("set wrap!"):with_desc("toggle: Line wrap"),
	["n|<leader>tl"] = map_cr("set list!"):with_desc("toggle: Special characters (spaces/tabs)"),
	["n|<leader>tn"] = map_cr("set number!"):with_desc("toggle: Line numbers"),
	["n|<leader>tr"] = map_cr("set relativenumber!"):with_desc("toggle: Relative numbers"),
	-- Note: ]s, [s, z=, zg are vim defaults for spell navigation
}

local search = {
	-- Enhanced search (centered results)
	["n|n"] = map_cmd("nzzzv"):with_desc("search: Next match (centered)"),
	["n|N"] = map_cmd("Nzzzv"):with_desc("search: Previous match (centered)"),
	["n|*"] = map_cmd("*zzzv"):with_desc("search: Search word forward"),
	["n|#"] = map_cmd("#zzzv"):with_desc("search: Search word backward"),

	-- Clear search highlight (common pattern) - using different key to avoid Esc conflicts
	["n|<leader>hl"] = map_cr("nohlsearch"):with_desc("search: Clear highlight"),

	-- Quick substitute (standard vim enhanced)
	["n|<leader>sr"] = map_cmd(":%s/\\<<C-r><C-w>\\>/<C-r><C-w>/gI<Left><Left><Left>"):with_desc(
		"search: Replace word under cursor"
	),
	["v|<leader>sr"] = map_cmd('"hy:%s/<C-r>h//gI<left><left><left>'):with_desc("search: Replace selection"),
}

local windows = {
	-- Window splitting (standard vim)
	["n|<leader>sv"] = map_cr("vsplit"):with_desc("window: Vertical split"),
	["n|<leader>sh"] = map_cr("split"):with_desc("window: Horizontal split"),

	-- Window navigation (vim standard with smart-splits)
	["n|<C-h>"] = map_cu("SmartCursorMoveLeft"):with_desc("window: Move left"),
	["n|<C-j>"] = map_cu("SmartCursorMoveDown"):with_desc("window: Move down"),
	["n|<C-k>"] = map_cu("SmartCursorMoveUp"):with_desc("window: Move up"),
	["n|<C-l>"] = map_cu("SmartCursorMoveRight"):with_desc("window: Move right"),

	-- Window resizing (Alt + hjkl pattern)
	["n|<A-h>"] = map_cu("SmartResizeLeft"):with_desc("window: Resize left"),
	["n|<A-j>"] = map_cu("SmartResizeDown"):with_desc("window: Resize down"),
	["n|<A-k>"] = map_cu("SmartResizeUp"):with_desc("window: Resize up"),
	["n|<A-l>"] = map_cu("SmartResizeRight"):with_desc("window: Resize right"),

	-- Window management (using standard vim commands)
	["n|<leader>so"] = map_cr("only"):with_desc("window: Close all others"),
	["n|<leader>sc"] = map_cr("close"):with_desc("window: Close current"),
	["n|<leader>s="] = map_cmd("<C-w>="):with_desc("window: Equal size"),
}

local buffers = {
	-- Buffer navigation (vim convention with [ and ])
	["n|]b"] = map_cr("bnext"):with_desc("buffer: Next"),
	["n|[b"] = map_cr("bprevious"):with_desc("buffer: Previous"),

	-- Buffer management
	["n|<leader>bd"] = map_cr("bdelete"):with_desc("buffer: Delete"),
	["n|<leader>bD"] = map_cr("bdelete!"):with_desc("buffer: Force delete"),
	["n|<leader>bo"] = map_cr("%bdelete|edit#|bdelete#"):with_desc("buffer: Delete others"),
	["n|<leader>bl"] = map_cr("buffers"):with_desc("buffer: List all"),

	-- Quick buffer switching
	["n|<leader><Tab>"] = map_cmd("<C-^>"):with_desc("buffer: Switch to last"),
}

local files = {
	-- File explorer (vim standard)
	["n|<leader>e"] = map_cr("Explore"):with_desc("file: File explorer"),
	["n|-"] = map_cr("Explore"):with_desc("file: File explorer (oil style)"),

	-- File operations
	["n|<leader>fn"] = map_cr("enew"):with_desc("file: New file"),
	["n|<leader>fs"] = map_cr("write"):with_desc("file: Save"),
	["n|<leader>fS"] = map_cr("saveas "):with_desc("file: Save as"),
	["n|<leader>fr"] = map_cr("edit!"):with_desc("file: Reload"),
}

local telescope = {
	-- Core file finding
	["n|<leader>ff"] = map_cu("Telescope find_files"):with_desc("find: Files"),
	["n|<leader>fg"] = map_cu("Telescope git_files"):with_desc("find: Git files"),
	["n|<leader>fo"] = map_cu("Telescope oldfiles"):with_desc("find: Recent files"),
	["n|<C-p>"] = map_cu("Telescope find_files"):with_desc("find: Files (ctrl-p style)"),

	-- Text searching
	["n|<leader>fw"] = map_callback(function()
		require("telescope").extensions.live_grep_args.live_grep_args()
	end):with_desc("find: Live grep"),
	["n|<leader>fc"] = map_cu("Telescope grep_string"):with_desc("find: Current word"),
	["n|<leader>fb"] = map_cu("Telescope current_buffer_fuzzy_find"):with_desc("find: In buffer"),

	-- Other finders
	["n|<leader>fh"] = map_cu("Telescope help_tags"):with_desc("find: Help tags"),
	["n|<leader>fm"] = map_cu("Telescope marks"):with_desc("find: Marks"),
	["n|<leader>ft"] = map_cu("Telescope treesitter"):with_desc("find: Treesitter symbols"),
	["n|<leader>fC"] = map_cu("Telescope commands"):with_desc("find: Commands"),
	["n|<leader>fk"] = map_cu("Telescope keymaps"):with_desc("find: Keymaps"),

	-- Utility
	["n|<leader>fu"] = map_callback(function()
		require("telescope").extensions.undo.undo()
	end):with_desc("find: Undo history"),

	-- Directory jumping
	["n|<leader>fz"] = map_cu("Telescope zoxide list"):with_desc("find: Zoxide directories"),
}

local motion = {
	-- Flash.nvim - Enhanced motion plugin
	["n|<leader>mf"] = map_callback(function()
		require("flash").jump()
	end):with_desc("motion: Flash jump"),
	["n|<leader>mF"] = map_callback(function()
		require("flash").treesitter()
	end):with_desc("motion: Flash treesitter"),
	["n|<leader>mr"] = map_callback(function()
		require("flash").remote()
	end):with_desc("motion: Flash remote"),
	["n|<leader>mt"] = map_callback(function()
		require("flash").treesitter_search()
	end):with_desc("motion: Flash treesitter search"),

	-- Keep some flash bindings on s/S for quick access (common pattern)
	["nxo|s"] = map_callback(function()
		require("flash").jump()
	end):with_desc("motion: Flash jump (quick)"),
	["nxo|S"] = map_callback(function()
		require("flash").treesitter()
	end):with_desc("motion: Flash treesitter (quick)"),

	-- Mini.jump2d - 2D jumping with character pairs
	["n|<leader>mj"] = map_callback(function()
		require("mini.jump2d").start(require("mini.jump2d").builtin_opts.single_character)
	end):with_desc("motion: Jump2d single char"),
	["n|<leader>mJ"] = map_callback(function()
		require("mini.jump2d").start(require("mini.jump2d").builtin_opts.word_start)
	end):with_desc("motion: Jump2d word start"),
	["n|<leader>ml"] = map_callback(function()
		require("mini.jump2d").start(require("mini.jump2d").builtin_opts.line_start)
	end):with_desc("motion: Jump2d line start"),
	["n|<leader>mw"] = map_callback(function()
		require("mini.jump2d").start({
			allowed_lines = { blank = false, cursor_before = true, cursor_at = true, cursor_after = true },
			allowed_windows = { current = true },
			spotter = require("mini.jump2d").gen_pattern_spotter("%f[%w]%w+"),
		})
	end):with_desc("motion: Jump2d word anywhere"),

	-- Enhanced bracket matching
	["n|<leader>m%"] = map_cmd("%"):with_desc("motion: Jump to matching bracket"),

	-- Better line start/end (enhanced but don't override H/L screen motions)
	["n|gh"] = map_cmd("^"):with_desc("motion: First non-blank character"),
	["n|gl"] = map_cmd("$"):with_desc("motion: End of line"),
	["v|gh"] = map_cmd("^"):with_desc("motion: First non-blank character"),
	["v|gl"] = map_cmd("$"):with_desc("motion: End of line"),
}

local git = {
	-- Git status and navigation
	["n|<leader>gs"] = map_cu("Telescope git_status"):with_desc("git: Status"),
	["n|<leader>gc"] = map_cu("Telescope git_commits"):with_desc("git: Commits"),
	["n|<leader>gb"] = map_cu("Telescope git_branches"):with_desc("git: Branches"),

	-- Hunk navigation (vim convention with [ and ])
	["n|]h"] = map_cu("Gitsigns next_hunk"):with_desc("git: Next hunk"),
	["n|[h"] = map_cu("Gitsigns prev_hunk"):with_desc("git: Previous hunk"),

	-- Hunk operations
	["n|<leader>gp"] = map_cu("Gitsigns preview_hunk"):with_desc("git: Preview hunk"),
	["n|<leader>gr"] = map_cu("Gitsigns reset_hunk"):with_desc("git: Reset hunk"),
	["n|<leader>ga"] = map_cu("Gitsigns stage_hunk"):with_desc("git: Stage hunk"),
	["n|<leader>gA"] = map_cu("Gitsigns stage_buffer"):with_desc("git: Stage buffer"),
	["n|<leader>gu"] = map_cu("Gitsigns undo_stage_hunk"):with_desc("git: Undo stage hunk"),

	-- Git blame
	["n|<leader>gl"] = map_cu("Gitsigns toggle_current_line_blame"):with_desc("git: Toggle line blame"),
}

function export_mapping.lsp(buf)
	local lsp = {
		-- Go to definitions (standard vim style)
		["n|gd"] = map_cr("Glance definitions"):with_buffer(buf):with_desc("lsp: Go to definition"),
		["n|gD"] = map_cr("Lspsaga peek_definition"):with_buffer(buf):with_desc("lsp: Peek definition"),
		["n|gr"] = map_cr("Glance references"):with_buffer(buf):with_desc("lsp: Go to references"),
		["n|gI"] = map_cr("Glance implementations"):with_buffer(buf):with_desc("lsp: Go to implementation"),
		["n|gy"] = map_cr("Glance type_definitions"):with_buffer(buf):with_desc("lsp: Go to type definition"),

		-- Documentation (K is standard vim for man pages, we keep it for LSP)
		["n|K"] = map_cr("Lspsaga hover_doc"):with_buffer(buf):with_desc("lsp: Hover documentation"),
		["n|<leader>K"] = map_cr("Lspsaga hover_doc ++keep"):with_buffer(buf):with_desc("lsp: Keep hover open"),

		-- Code actions (leader-based)
		["n|<leader>ca"] = map_cr("Lspsaga code_action"):with_buffer(buf):with_desc("lsp: Code action"),
		["v|<leader>ca"] = map_cr("Lspsaga code_action"):with_buffer(buf):with_desc("lsp: Code action"),
		["n|<leader>rn"] = map_cr("Lspsaga rename"):with_buffer(buf):with_desc("lsp: Rename"),
		["n|<leader>rN"] = map_cr("Lspsaga rename ++project"):with_buffer(buf):with_desc("lsp: Rename in project"),

		-- Diagnostics (vim convention with [ and ])
		["n|]d"] = map_cr("Lspsaga diagnostic_jump_next"):with_buffer(buf):with_desc("lsp: Next diagnostic"),
		["n|[d"] = map_cr("Lspsaga diagnostic_jump_prev"):with_buffer(buf):with_desc("lsp: Previous diagnostic"),
		["n|]e"] = map_callback(function()
				require("lspsaga.diagnostic"):goto_next({ severity = vim.diagnostic.severity.ERROR })
			end)
			:with_buffer(buf)
			:with_desc("lsp: Next error"),
		["n|[e"] = map_callback(function()
				require("lspsaga.diagnostic"):goto_prev({ severity = vim.diagnostic.severity.ERROR })
			end)
			:with_buffer(buf)
			:with_desc("lsp: Previous error"),

		-- Show diagnostics
		["n|<leader>ld"] = map_cr("Lspsaga show_line_diagnostics"):with_buffer(buf):with_desc("lsp: Line diagnostics"),
		["n|<leader>lD"] = map_cr("Trouble document_diagnostics"):with_buffer(buf):with_desc("lsp: Document diagnostics"),
		["n|<leader>lw"] = map_cr("Trouble workspace_diagnostics"):with_buffer(buf):with_desc("lsp: Workspace diagnostics"),

		-- LSP info
		["n|<leader>li"] = map_cr("LspInfo"):with_buffer(buf):with_desc("lsp: LSP info"),
		["n|<leader>lr"] = map_cr("LspRestart"):with_buffer(buf):with_desc("lsp: Restart LSP"),

		-- Formatting
		["n|<leader>lf"] = map_callback(function()
				vim.lsp.buf.format({ async = true })
			end)
			:with_buffer(buf)
			:with_desc("lsp: Format"),
		["v|<leader>lf"] = map_callback(function()
				vim.lsp.buf.format({ async = true })
			end)
			:with_buffer(buf)
			:with_desc("lsp: Format selection"),
	}

	bind.nvim_load_mapping(lsp)
end

-- Load all mappings
now(function()
	bind.nvim_load_mapping(basic)
	bind.nvim_load_mapping(editing)
	bind.nvim_load_mapping(search)
	bind.nvim_load_mapping(windows)
	bind.nvim_load_mapping(buffers)
	bind.nvim_load_mapping(files)
	bind.nvim_load_mapping(telescope)
	bind.nvim_load_mapping(motion)
	bind.nvim_load_mapping(git)
end)

return export_mapping
