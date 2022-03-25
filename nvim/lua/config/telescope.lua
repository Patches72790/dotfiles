local telescope = require("telescope")
local map = require("config.util").map

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
