local M = {}
local set_win_opt = require("config.util").set_current_window_option
local set_buf_opt = require("config.util").set_current_buffer_option
local set_global_opt = require("config.util").set_global_option

local nvim_options = {
	window = { number = true },
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
		number = true,
		tabstop = 4,
		shiftwidth = 4,
		smartindent = true,
		expandtab = true,
		autoindent = true,
		undofile = true,
		fileformat = "unix",
		guifont = "FiraMono Nerd Font Mono:h11",
		hlsearch = true,
		errorbells = false,
		nu = true,
		wrap = false,
		swapfile = false,
		backup = true,
		writebackup = true,
		undodir = os.getenv("HOME") .. "/dotfiles/nvim/undodir",
		backupdir = os.getenv("HOME") .. "/dotfiles/nvim/backupdir",
		directory = os.getenv("HOME") .. "/dotfiles/nvim/backupdir",
		completeopt = "menuone,noselect,noinsert",
		relativenumber = true,
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

local function init_user_commands() end

local function init_colorscheme()
	--	vim.g.nord_contrast = true
	--	vim.g.nord_borders = true
	--	vim.g.nord_disable_background = false
	--	vim.g.nord_italic = false
	--	vim.g.nord_uniform_diff_background = true
	--	vim.g.nord_bold = false
	--	require("nord").set()

	vim.cmd([[colorscheme gruvbox]])
end

function M.setup()
	init_nvim_options()
	init_movement_keymaps()
	init_user_commands()
	init_colorscheme()
	-- initialize global helpers
	require("config.globals")
end

return M
