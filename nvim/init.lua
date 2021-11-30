-- Bootstrapping for pre-installing packer
local fn = vim.fn
local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
    fn.system({
        "git", "clone", "--depth", "1",
        "https://github.com/wbthomason/packer.nvim", install_path
    })
    vim.cmd "packadd packer.nvim"
end

-- initialize plugins
require("plugins")

-- local utility vars
local o, bo, wo = vim.o, vim.bo, vim.wo
local buffer = {o, bo}
local window = {o, wo}
local utils = require("config.util")
local opt = utils.opt
local cmd = vim.cmd
local map = utils.map
local autocmd = utils.autocmd

-- general options
opt("number", true, window)
opt("tabstop", 4, buffer)
opt("shiftwidth", 4, buffer)
opt("smartindent", true, buffer)
opt("expandtab", true, buffer)
opt("autoindent", true, buffer)
opt("hlsearch", true)
opt("errorbells", false)
opt("nu", true)
opt("wrap", false)
opt("swapfile", false)
opt("undofile", true, buffer)
opt("backup", true)
opt("writebackup", true)
opt("undodir", os.getenv("HOME") .. "/dotfiles/nvim/undodir")
opt("backupdir", os.getenv("HOME") .. "/dotfiles/nvim/backupdir")
opt("directory", os.getenv("HOME") .. "/dotfiles/nvim/backupdir")
opt("completeopt", "menuone,noselect,noinsert")
opt("fileformat", "unix", buffer)

-- color options
opt("termguicolors", true)
opt("background", "dark")
cmd [[ colorscheme darcula ]]

-- keybindings
local silent = {silent = true}

-- save buffer
map("n", "<leader>w", "<cmd>w<CR>", silent)

-- Window movement
map("n", "<c-h>", "<c-w>h")
map("n", "<c-j>", "<c-w>j")
map("n", "<c-k>", "<c-w>k")
map("n", "<c-l>", "<c-w>l")

-- closing buffers
map("n", "<leader>q", "<cmd>qa<CR>", silent)
map("n", "<leader>x", "<cmd>x!<CR>", silent)

-- autocmd for triggering linting
--autocmd("LintCmd", [[BufWritePost <buffer> lua require('lint').try_lint()]])
map("n", "<leader>p", "<cmd>Format<CR>")
