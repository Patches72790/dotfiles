local M = {}
local set_win_opt = require("config.util").set_current_window_option
local set_buf_opt = require("config.util").set_current_buffer_option
local set_global_opt = require("config.util").set_global_option

local nvim_options = {
	window = {
		relativenumber = true,
		number = true,
		scrolloff = 10,
		cursorline = true,
		foldmethod = "expr",
		foldexpr = "nvim_treesitter#foldexpr()",
		foldenable = false,
	},
	buffer = {
		tabstop = 4,
		shiftwidth = 4,
		smartindent = true,
		expandtab = true,
		autoindent = true,
		undofile = true,
		fileformat = "unix",
	},
	global = {
		relativenumber = true,
		number = true,
		inccommand = "split",
		--confirm = true,
		updatetime = 250,
		timeoutlen = 300,
		signcolumn = "yes",
		splitright = true,
		splitbelow = true,
		smartcase = true,
		tabstop = 4,
		shiftwidth = 4,
		ignorecase = true,
		smartindent = true,
		breakindent = true,
		expandtab = true,
		autoindent = true,
		undofile = true,
		fileformat = "unix",
		guifont = "FiraMono Nerd Font Mono:h11",
		hlsearch = true,
		errorbells = false,
		wrap = false,
		swapfile = false,
		backup = false,
		writebackup = true,
		undodir = os.getenv("HOME") .. "/dotfiles/nvim/undodir",
		backupdir = os.getenv("HOME") .. "/dotfiles/nvim/backupdir",
		directory = os.getenv("HOME") .. "/dotfiles/nvim/backupdir",
		completeopt = "menuone,noselect,noinsert",
		termguicolors = true,
		background = "dark",
	},
}

local function set_options(option_fn, option_table)
	for option, value in pairs(option_table) do
		option_fn(option, value)
	end
end

local function init_nvim_options()
	for option_type, option_table in pairs(nvim_options) do
		if option_type == "window" then
			set_options(set_win_opt, option_table)
		elseif option_type == "buffer" then
			set_options(set_buf_opt, option_table)
		elseif option_type == "global" then
			set_options(set_global_opt, option_table)
		end
	end
end

local function init_movement_keymaps()
	local movement_mapping = {
		["<C-h>"] = "<C-w>h",
		["<C-j>"] = "<C-w>j",
		["<C-k>"] = "<C-w>k",
		["<C-l>"] = "<C-w>l",
		["<S-l>"] = "gt",
		["<S-h>"] = "gT",
		["<leader>T"] = ":tab new<CR>",
	}
	local terminal_mapping = {
		["<c-w>h"] = "<c-\\><c-n><c-w>h",
		["<c-w>j"] = "<c-\\><c-n><c-w>j",
		["<c-w>k"] = "<c-\\><c-n><c-w>k",
		["<c-w>l"] = "<c-\\><c-n><c-w>l",
		["<leader><leader>"] = "<c-\\><c-n>",
	}
	local map = require("config.util").map
	for lhs, rhs in pairs(movement_mapping) do
		map("n", lhs, rhs)
	end
	for lhs, rhs in pairs(terminal_mapping) do
		map({ "t", "n" }, lhs, rhs)
	end
end

local function init_keymaps()
	vim.keymap.set("n", "<leader><Space>", function()
		vim.cmd("nohl")
	end, { desc = "Turn off highlighting", silent = true })

	vim.keymap.set("n", "-", "<CMD>Oil<CR>", { desc = "Open Oil", silent = true })
	vim.keymap.set("n", "<leader>w", ":w<CR>", { desc = "Save Buffer", silent = true })
	vim.keymap.set("n", "<leader>q", ":qa<CR>", { desc = "Close Window", silent = true })
	vim.keymap.set("n", "<leader>x", ":x<CR>", { desc = "Close Buffer", silent = true })

	vim.keymap.set("n", "[a", vim.diagnostic.goto_prev, { desc = "Go to previous diagnostic", silent = true })
	vim.keymap.set("n", "]a", vim.diagnostic.goto_next, { desc = "Go to next diagnostic", silent = true })
	vim.keymap.set(
		"n",
		"<leader>e",
		vim.diagnostic.open_float,
		{ desc = "Show diagnostic [E]rror messages", silent = true }
	)
	vim.keymap.set(
		"n",
		"<leader>t",
		vim.diagnostic.setloclist,
		{ desc = "Open diagnostic [Q]uickfix list", silent = true }
	)
end

local autoCommands = {}

-- function to create a list of commands and convert them to autocommands
-------- This function is taken from https://github.com/norcalli/nvim_utils
function M.nvim_create_augroups(definitions)
	for group_name, definition in pairs(definitions) do
		vim.api.nvim_create_autocmd(definition.events, {
			group = vim.api.nvim_create_augroup(group_name, { clear = true }),
			pattern = definition.pattern,
			command = definition.cmd,
			desc = definition.desc,
		})
	end
end

function M.setup()
	init_keymaps()
	init_nvim_options()
	init_movement_keymaps()
	M.nvim_create_augroups(autoCommands)
	-- initialize global helpers
	require("config.globals")
end

return M
