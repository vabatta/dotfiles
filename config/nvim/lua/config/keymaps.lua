local bind = require("utils.keybind")
local map_cr = bind.map_cr
local map_cu = bind.map_cu
local map_cmd = bind.map_cmd
local map_callback = bind.map_callback
local now = MiniDeps.now

local export_mapping = {}

-- Basic editor operations
local editor = {
	-- Save/Quit
	["n|<C-s>"] = map_cu("write"):with_noremap():with_silent():with_desc("edit: Save file"),
	["i|<C-s>"] = map_cmd("<Esc>:w<CR>"):with_desc("edit: Save file"),
	["n|<C-q>"] = map_cr("wq"):with_desc("edit: Save and quit"),
	["n|<A-q>"] = map_cr("q!"):with_desc("edit: Force quit"),

	-- Undo/Redo
	["n|U"] = map_cmd("<C-r>"):with_noremap():with_desc("edit: Redo"),
	["n|<leader>u"] = map_callback(function()
			require("telescope").extensions.undo.undo()
		end)
		:with_noremap()
		:with_silent()
		:with_desc("edit: Undo tree"),

	-- Basic editing
	["n|<leader>o"] = map_cr("setlocal spell! spelllang=en_us"):with_desc("edit: Toggle spell check"),
	["n|<leader>w"] = map_cr("set wrap!"):with_desc("edit: Toggle wrap"),
}

-- Text manipulation
local text = {
	-- Line operations
	["n|J"] = map_cmd("mzJ`z"):with_noremap():with_desc("text: Join next line"),
	["n|<leader>j"] = map_cr("join"):with_desc("text: Join lines"),
	["v|J"] = map_cmd(":m '>+1<CR>gv=gv"):with_desc("text: Move lines down"),
	["v|K"] = map_cmd(":m '<-2<CR>gv=gv"):with_desc("text: Move lines up"),

	-- Indentation
	["v|<"] = map_cmd("<gv"):with_desc("text: Dedent and reselect"),
	["v|>"] = map_cmd(">gv"):with_desc("text: Indent and reselect"),
	["v|="] = map_cmd("=gv"):with_desc("text: Format and reselect"),

	-- Text objects (requires mini.ai)
	["n|]a"] = map_cmd("va)"):with_desc("text-object: Around parentheses"),
	["n|]i"] = map_cmd("vi)"):with_desc("text-object: Inside parentheses"),
	["n|]b"] = map_cmd("va}"):with_desc("text-object: Around braces"),
	["n|]B"] = map_cmd("vi}"):with_desc("text-object: Inside braces"),

	-- Text manipulation
	["n|gU"] = map_cmd("gUiw"):with_desc("edit: Uppercase word"),
	["n|gu"] = map_cmd("guiw"):with_desc("edit: Lowercase word"),
	["n|gJ"] = map_callback(function()
		require("treesj").join()
	end):with_desc("text: Smart join"),
	["n|gS"] = map_callback(function()
		require("treesj").split()
	end):with_desc("text: Smart split"),
}

-- Search and navigation
local search = {
	-- Basic search
	["n|n"] = map_cmd("nzzzv"):with_noremap():with_desc("search: Next match centered"),
	["n|N"] = map_cmd("Nzzzv"):with_noremap():with_desc("search: Prev match centered"),
	["n|*"] = map_cmd("*zzzv"):with_noremap():with_desc("search: Word forward"),
	["n|#"] = map_cmd("#zzzv"):with_noremap():with_desc("search: Word backward"),

	-- Telescope search
	["n|<leader>ff"] = map_cu("Telescope find_files"):with_desc("find: Files"),
	["n|<leader>fg"] = map_cu("Telescope git_files"):with_desc("find: Git files"),
	["n|<leader>fr"] = map_cu("Telescope oldfiles"):with_desc("find: Recent files"),
	["n|<leader>fw"] = map_callback(function()
		require("telescope").extensions.live_grep_args.live_grep_args()
	end):with_desc("find: Live grep"),
	["n|<leader>fs"] = map_cu("Telescope grep_string"):with_desc("find: Current word"),
	["n|<leader>fb"] = map_cu("Telescope current_buffer_fuzzy_find"):with_desc("find: In buffer"),
	["n|<leader>fm"] = map_cu("Telescope marks"):with_desc("find: Marks"),
	["n|<leader>ft"] = map_cu("Telescope treesitter"):with_desc("find: Treesitter symbols"),

	-- Flash.nvim navigation
	["nxo|s"] = map_callback(function()
		require("flash").jump()
	end):with_desc("flash: Jump"),
	["nxo|S"] = map_callback(function()
		require("flash").treesitter()
	end):with_desc("flash: Treesitter objects"),
	["nxo|r"] = map_callback(function()
		require("flash").remote()
	end):with_desc("flash: Remote flash"),
}

-- Window/Buffer management
local windows = {
	-- Window navigation
	["n|<C-h>"] = map_cu("SmartCursorMoveLeft"):with_desc("window: Focus left"),
	["n|<C-j>"] = map_cu("SmartCursorMoveDown"):with_desc("window: Focus down"),
	["n|<C-k>"] = map_cu("SmartCursorMoveUp"):with_desc("window: Focus up"),
	["n|<C-l>"] = map_cu("SmartCursorMoveRight"):with_desc("window: Focus right"),

	-- Window resizing
	["n|<A-h>"] = map_cu("SmartResizeLeft"):with_desc("window: Resize left"),
	["n|<A-j>"] = map_cu("SmartResizeDown"):with_desc("window: Resize down"),
	["n|<A-k>"] = map_cu("SmartResizeUp"):with_desc("window: Resize up"),
	["n|<A-l>"] = map_cu("SmartResizeRight"):with_desc("window: Resize right"),

	-- Buffer management
	["n|<Tab>"] = map_cu("bnext"):with_desc("buffer: Next"),
	["n|<S-Tab>"] = map_cu("bprevious"):with_desc("buffer: Previous"),
	["n|<leader>bd"] = map_cu("bd"):with_desc("buffer: Delete"),
	["n|<leader>bD"] = map_cu("bd!"):with_desc("buffer: Force delete"),
	["n|<leader>bo"] = map_cu("%bd|e#|bd#"):with_desc("buffer: Delete others"),
}

-- File management
local files = {
	-- File explorer
	["n|<leader>e"] = map_cu("Explore"):with_desc("file: Explorer"),
	["n|<leader>fe"] = map_callback(function()
		require("mini.files").open()
	end):with_desc("file: Mini explorer"),

	-- File operations
	["n|<leader>fn"] = map_cu("enew"):with_desc("file: New"),
	["n|<leader>fs"] = map_cu("write"):with_desc("file: Save"),
	["n|<leader>fS"] = map_cu("saveas"):with_desc("file: Save as"),
	["n|<leader>fz"] = map_cu("Telescope zoxide list"):with_desc("file: Zoxide dirs"),
}

-- Git operations
local git = {
	["n|<leader>gg"] = map_cu("Telescope git_status"):with_desc("git: Status"),
	["n|<leader>gc"] = map_cu("Telescope git_commits"):with_desc("git: Commits"),
	["n|<leader>gb"] = map_cu("Telescope git_branches"):with_desc("git: Branches"),
	["n|]c"] = map_cu("Gitsigns next_hunk"):with_desc("git: Next hunk"),
	["n|[c"] = map_cu("Gitsigns prev_hunk"):with_desc("git: Prev hunk"),
	["n|<leader>gh"] = map_cu("Gitsigns preview_hunk"):with_desc("git: Preview hunk"),
	["n|<leader>gr"] = map_cu("Gitsigns reset_hunk"):with_desc("git: Reset hunk"),
	["n|<leader>gs"] = map_cu("Gitsigns stage_hunk"):with_desc("git: Stage hunk"),
	["n|<leader>gS"] = map_cu("Gitsigns stage_buffer"):with_desc("git: Stage buffer"),
}

-- LSP functionality
function export_mapping.lsp(buf)
	local lsp = {
		-- Code navigation
		["n|gd"] = map_cr("Glance definitions"):with_buffer(buf):with_desc("lsp: Definitions"),
		["n|gD"] = map_cr("Lspsaga peek_definition"):with_buffer(buf):with_desc("lsp: Peek definition"),
		["n|gr"] = map_cr("Glance references"):with_buffer(buf):with_desc("lsp: References"),
		["n|gR"] = map_cr("Telescope lsp_references"):with_buffer(buf):with_desc("lsp: Find references"),
		["n|gi"] = map_cr("Glance implementations"):with_buffer(buf):with_desc("lsp: Implementations"),
		["n|gy"] = map_cr("Glance type_definitions"):with_buffer(buf):with_desc("lsp: Type definitions"),

		-- Documentation
		["n|K"] = map_cr("Lspsaga hover_doc"):with_buffer(buf):with_desc("lsp: Hover doc"),
		["n|<leader>k"] = map_cr("Lspsaga hover_doc ++keep"):with_buffer(buf):with_desc("lsp: Hover doc (keep)"),

		-- Code actions
		["n|<leader>ca"] = map_cr("Lspsaga code_action"):with_buffer(buf):with_desc("lsp: Code action"),
		["v|<leader>ca"] = map_cr("Lspsaga code_action"):with_buffer(buf):with_desc("lsp: Code action"),
		["n|<leader>rn"] = map_cr("Lspsaga rename"):with_buffer(buf):with_desc("lsp: Rename"),
		["n|<leader>rN"] = map_cr("Lspsaga rename ++project"):with_buffer(buf):with_desc("lsp: Project rename"),

		-- Diagnostics
		["n|[d"] = map_cr("Lspsaga diagnostic_jump_prev"):with_buffer(buf):with_desc("lsp: Prev diagnostic"),
		["n|]d"] = map_cr("Lspsaga diagnostic_jump_next"):with_buffer(buf):with_desc("lsp: Next diagnostic"),
		["n|gl"] = map_cr("Lspsaga show_line_diagnostics"):with_buffer(buf):with_desc("lsp: Line diagnostics"),
		["n|<leader>lx"] = map_cr("Trouble document_diagnostics"):with_buffer(buf):with_desc("lsp: Document diagnostics"),
		["n|<leader>lX"] = map_cr("Trouble workspace_diagnostics"):with_buffer(buf):with_desc("lsp: Workspace diagnostics"),
	}

	bind.nvim_load_mapping(lsp)
end

-- Load all mappings
now(function()
	bind.nvim_load_mapping(editor)
	bind.nvim_load_mapping(text)
	bind.nvim_load_mapping(search)
	bind.nvim_load_mapping(windows)
	bind.nvim_load_mapping(files)
	bind.nvim_load_mapping(git)
end)

return export_mapping
