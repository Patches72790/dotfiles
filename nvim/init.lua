-- Bootstrapping for pre-installing packer
local fn = vim.fn
local lazy_path = fn.stdpath("data") .. "/lazy/lazy.nvim"

vim.opt.rtp:append(lazy_path)
if not vim.loop.fs_stat(lazy_path) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable", -- latest stable release
		lazy_path,
	})
end

-- initialize plugins from ~/.config/nvim/lua/plugins.lua
require("lazy").setup(require("plugins"))

vim.cmd([[colorscheme material-darker]])

-- initialize keymaps and window/buffer options
require("config.general").setup()
