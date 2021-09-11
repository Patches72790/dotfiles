local packer = require('packer')
local use = packer.use

local function plugins_startup() 
    -- auto-update packer
    use { 'wbthomason/packer.nvim' }

    -- file explorer tree 
    use { 'kyazdani42/nvim-tree.lua', 
           requires = { 'kyazdani42/nvim-web-devicons' },
           config = function() require('config.nvim-tree') end }

    -- telescope search tool
    use { 'nvim-telescope/telescope.nvim',
           requires = { 'nvim-lua/plenary.nvim' } }

    -- lsp config
    use {   'neovim/nvim-lspconfig',
            'nvim-lua/popup.nvim'
        }

    -- TODO lsp-install and lsp-configuration settings
    -- Treesitter
    -- various language tools for ts, java, rust, etc
    -- debugger (nvim-dap or vimspector)

    -- autocomplete 
    use { 'hrsh7th/nvim-cmp', 
            requires = {
                'L3MON4D3/LuaSnip', 
                { 'hrsh7th/cmp-buffer', after = 'nvim-cmp' },
                'hrsh7th/cmp-nvim-lsp',
                { 'hrsh7th/cmp-path', after = 'nvim-cmp' },
                { 'hrsh7th/cmp-nvim-lua', after = 'nvim-cmp' },
                { 'saadparwaiz1/cmp_luasnip', after = 'nvim-cmp' },
                { 'hrsh7th/cmp-buffer', after = 'nvim-cmp' },
            },
            config = function() require('config.nvim-cmp') end 
        }

    -- colorschemes
    use { 'morhetz/gruvbox' }
    use { 'doums/darcula' }

    -- git
    use { 'lewis6991/gitsigns.nvim', requires = { 'nvim-lua/plenary.nvim' } }

end

return packer.startup(plugins_startup);
