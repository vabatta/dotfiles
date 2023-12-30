return {
	{
		"ThePrimeagen/harpoon",
		branch = "harpoon2",
		dependencies = { "nvim-lua/plenary.nvim", "nvim-telescope/telescope.nvim" },
		keys = {
			{
				"<leader>bu",
				function()
					local harpoon = require("harpoon")
					local conf = require("telescope.config").values
					local function toggle_telescope(harpoon_files)
						local file_paths = {}
						for _, item in ipairs(harpoon_files.items) do
							table.insert(file_paths, item.value)
						end

						require("telescope.pickers")
							.new({}, {
								prompt_title = "Harpoon",
								finder = require("telescope.finders").new_table({
									results = file_paths,
								}),
								previewer = conf.file_previewer({}),
								sorter = conf.generic_sorter({}),
							})
							:find()
					end
					toggle_telescope(harpoon:list())
				end,
				desc = "View harpoons",
			},
			{
				"<leader>ba",
				function()
					local harpoon = require("harpoon")
					harpoon:list():append()
				end,
				desc = "Add new harpoon",
			},
			{
				"<leader>b1",
				function()
					local harpoon = require("harpoon")
					harpoon:list():select(1)
				end,
				desc = "Select harpoon 1",
			},
			{
				"<leader>b2",
				function()
					local harpoon = require("harpoon")
					harpoon:list():select(2)
				end,
				desc = "Select harpoon 2",
			},
			{
				"<leader>b3",
				function()
					local harpoon = require("harpoon")
					harpoon:list():select(3)
				end,
				desc = "Select harpoon 3",
			},
			{
				"<leader>b4",
				function()
					local harpoon = require("harpoon")
					harpoon:list():select(4)
				end,
				desc = "Select harpoon 4",
			},
			{
				"<leader>bn",
				function()
					local harpoon = require("harpoon")
					harpoon:list():next()
				end,
				desc = "Select next harpoon",
			},
			{
				"<leader>bm",
				function()
					local harpoon = require("harpoon")
					harpoon:list():prev()
				end,
				desc = "Select previous harpoon",
			},
		},
	},
}
