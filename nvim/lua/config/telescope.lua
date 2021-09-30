local telescope = require('telescope');
local map = require('config.util').map;

telescope.load_extension('dap');

local opt = { silent = true }
map('n', '<leader>ff',  '<cmd>Telescope find_files<CR>', silent)
map('n', '<leader>fg',  '<cmd>Telescope live_grep<CR>', silent)
map('n', '<leader>fb',  '<cmd>Telescope buffers<CR>', silent)
map('n', '<leader>fh',  '<cmd>Telescope help_tags<CR>', silent)
map('n', '<leader>fc',  "<cmd> lua require('telescope.builtin').current_buffer_fuzzy_find()<CR>", silent)
map('n', "<leader>rr", "<cmd> lua require('telescope.builtin').registers()<CR>", silent)
map('n', "<leader>km", "<cmd> lua require('telescope.builtin').keymaps()<CR>", silent)


