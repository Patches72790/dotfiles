local M = {}

local telescope = require("telescope")
local map = require("config.util").map

local function configure_keymap()
	-- dap extension mappings
	telescope.load_extension("dap")
	map("n", "<leader>ds", ":Telescope dap frames<CR>")
	map("n", "<leader>db", ":Telescope dap list_breakpoints<CR>")

	-- general telescope mappings
	local silent = { silent = true }
	map("n", "<leader>ff", "<cmd>Telescope find_files<CR>", silent)
	map("n", "<leader>fg", "<cmd>Telescope live_grep<CR>", silent)
	map("n", "<leader>fb", "<cmd>Telescope buffers<CR>", silent)
	map("n", "<leader>fh", "<cmd>Telescope help_tags<CR>", silent)
	map("n", "<leader>fc", "<cmd> lua require('telescope.builtin').current_buffer_fuzzy_find()<CR>", silent)
	map("n", "<leader>rr", "<cmd> lua require('telescope.builtin').registers()<CR>", silent)
	map("n", "<leader>km", "<cmd> lua require('telescope.builtin').keymaps()<CR>", silent)
	map("n", "<leader>hh", "<cmd> lua require('telescope.builtin').help_tags()<CR>", silent)
end

local function configure()
	telescope.load_extension("ui-select")
end

function M.setup()
	telescope.setup({
		defaults = {
			layout_strategy = "vertical",
			layout_config = { height = 0.95 },
		},
		extensions = {
			["ui-select"] = {
				require("telescope.themes").get_dropdown({}),
			},
		},
	})

	configure_keymap()
	configure()
end

return M
