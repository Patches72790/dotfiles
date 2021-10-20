local packer = require('packer')
local use = packer.use

local function plugins_startup()
    -- auto-update packer
    use { 'wbthomason/packer.nvim' }

    -- file explorer tree
    use { 'kyazdani42/nvim-tree.lua',
           requires = { 'kyazdani42/nvim-web-devicons' },
           config = function() 
               require('config.nvim-tree');
               require('nvim-tree').setup({
               open_on_setup = true,
               view = {
                   side = 'right',
                   width = '25%',
               },
           }) end,
       }

    -- telescope search tool
    use { 'nvim-telescope/telescope.nvim',
           requires = { 'nvim-lua/plenary.nvim' },
           config = function() require('config.telescope') end,
       }

    use { 'nvim-telescope/telescope-dap.nvim',
        }

    -- lsp config
    use {   'neovim/nvim-lspconfig',
            config = function() require('config.lsp-config') end,
        }

    use {
        'williamboman/nvim-lsp-installer',
    }

    use { 'nvim-treesitter/nvim-treesitter',
          run = ':TSUpdate',
          config = function() require('nvim-treesitter.configs').setup{
              highlight = {
                enable = true
              },
          }
      end
        }

    -- general language packages
    use {
        'leafgarland/typescript-vim',
        'peitalin/vim-jsx-typescript',
        'rust-lang/rust.vim',
        { 'prettier/vim-prettier', run = 'npm install' },
        'mfussenegger/nvim-jdtls',
    }

    -- debugger (nvim-dap)
    use {
        'mfussenegger/nvim-dap',
        config = function() require('config.nvim-dap') end,
    }

    use {
        'rcarriga/nvim-dap-ui',
        requires = {'mfussenegger/nvim-dap'}
    }

    -- linters
    use { 'mfussenegger/nvim-lint',
        config = function() require('config.linter') end,
        }

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
    use { 'lewis6991/gitsigns.nvim', requires = { 'nvim-lua/plenary.nvim' },
            config = function() require('gitsigns').setup() end,
        }

    -- status line
    use { 'hoob3rt/lualine.nvim',
            requires = { 'kyazdani42/nvim-web-devicons', opt = true },
            config = function() require('lualine').setup({
                options = {
                    theme = 'jellybeans',
                },
            }) end,
        }
end

return packer.startup(plugins_startup);
