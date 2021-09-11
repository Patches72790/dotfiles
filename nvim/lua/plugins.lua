
local packer = require('packer')
local use = packer.use

local function plugins_startup() 
    -- auto-update packer
    use { 'wbthomason/packer.nvim' }

    -- web-devicons
    use { 'kyazdani42/nvim-tree.lua', requires = { 'kyazdani42/nvim-web-devicons' } }

    -- colorschemes
    use { 'morhetz/gruvbox' }
    use { 'doums/darcula' }


    -- git
    use { 'lewis6991/gitsigns.nvim', requires = { 'nvim-lua/plenary.nvim' } }

end

return packer.startup(plugins_startup);
