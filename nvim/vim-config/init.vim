call plug#begin('~/.config/nvim/plugged')
" colorschemes
Plug 'morhetz/gruvbox'
Plug 'doums/darcula'

" language tools 
Plug 'leafgarland/typescript-vim'
Plug 'peitalin/vim-jsx-typescript'
Plug 'rust-lang/rust.vim'
Plug 'neovim/nvim-lspconfig'
Plug 'kabouzeid/nvim-lspinstall'
Plug 'prettier/vim-prettier', { 'do': 'npm install'}
Plug 'hrsh7th/nvim-compe'
Plug 'mfussenegger/nvim-jdtls'
Plug 'nvim-treesitter/nvim-treesitter', {'do': 'TSUpdate'}

" Debugger tools
Plug 'puremourning/vimspector'
Plug 'nvim-telescope/telescope-vimspector.nvim'
Plug 'mfussenegger/nvim-dap'

" vim stuff 
Plug 'mbbill/undotree'
Plug 'nvim-lua/popup.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
Plug 'lewis6991/gitsigns.nvim'
Plug 'kyazdani42/nvim-web-devicons'
Plug 'kyazdani42/nvim-tree.lua'

call plug#end()

