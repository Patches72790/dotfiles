local M = {}

local telescope = require("telescope")

local function configure_keymap()
	local builtin = require("telescope.builtin")
	-- general telescope mappings
	local silent = true
	vim.keymap.set("n", "<leader>ff", builtin.find_files, { desc = "Find Files", silent = true })
	vim.keymap.set("n", "<leader>fg", builtin.live_grep, { desc = "Live Grep", silent = true })
	vim.keymap.set("n", "<leader>fb", builtin.buffers, { desc = "Open Buffers", silent = true })
	vim.keymap.set("n", "<leader>hh", builtin.help_tags, { desc = "Help Tags", silent = true })
	vim.keymap.set(
		"n",
		"<leader>fc",
		builtin.current_buffer_fuzzy_find,
		{ desc = "Current Buffer Fuzzy Find", silent = true }
	)
	vim.keymap.set("n", "<leader>rr", builtin.registers, { desc = "Registers", silent = true })
	vim.keymap.set("n", "<leader>km", builtin.keymaps, { desc = "Key Maps", silent = true })

	-- dap extension mappings
	telescope.load_extension("dap")
	vim.keymap.set("n", "<leader>ds", ":Telescope dap frames<CR>", { desc = "DAP Frames", silent = true })
	vim.keymap.set(
		"n",
		"<leader>db",
		":Telescope dap list_breakpoints<CR>",
		{ desc = "List Breakpoints", silent = true }
	)
end

local function configure()
	telescope.load_extension("ui-select")
end

function M.setup()
	telescope.setup({
		defaults = {
			layout_strategy = "vertical",
			layout_config = { height = 0.95 },
			file_ignore_patterns = {
				"node_modules",
				"public",
				"assets",
				"package-lock",
			},
		},
		extensions = {
			["ui-select"] = {
				require("telescope.themes").get_dropdown({}),
			},
		},
	})

	configure_keymap()
	configure()
	telescope.load_extension("file_browser")
end

M.setup()

return M
