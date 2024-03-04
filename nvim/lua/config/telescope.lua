local M = {}

local telescope = require("telescope")

local function configure_keymap()
	local builtin = require("telescope.builtin")
	-- general telescope mappings
	local silent = { silent = true }
	vim.keymap.set("n", "<leader>ff", builtin.find_files, silent)
	vim.keymap.set("n", "<leader>fg", builtin.live_grep, silent)
	vim.keymap.set("n", "<leader>fb", builtin.buffers, silent)
	vim.keymap.set("n", "<leader>hh", builtin.help_tags, silent)
	vim.keymap.set("n", "<leader>fc", builtin.current_buffer_fuzzy_find, silent)
	vim.keymap.set("n", "<leader>rr", builtin.registers, silent)
	vim.keymap.set("n", "<leader>km", builtin.keymaps, silent)

	-- dap extension mappings
	telescope.load_extension("dap")
	vim.keymap.set("n", "<leader>ds", ":Telescope dap frames<CR>")
	vim.keymap.set("n", "<leader>db", ":Telescope dap list_breakpoints<CR>")
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

return M
