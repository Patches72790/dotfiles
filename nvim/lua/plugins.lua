local packer = require("packer")
local use = packer.use

local function plugins_startup()
	-- auto-update packer
	use({ "wbthomason/packer.nvim" })

	-- file explorer tree
	use({
		"kyazdani42/nvim-tree.lua",
		requires = { "kyazdani42/nvim-web-devicons" },
		config = function()
			require("config.nvim-tree")
			require("nvim-tree").setup({
				open_on_setup = true,
				view = { side = "right", width = "25%" },
			})
		end,
	})

	-- telescope search tool
	use({
		"nvim-telescope/telescope.nvim",
		requires = { "nvim-lua/plenary.nvim" },
		config = function()
			require("config.telescope")
		end,
	})

	use({ "nvim-telescope/telescope-dap.nvim" })

	-- lsp config
	use({
		"neovim/nvim-lspconfig",
		opt = true,
		event = "VimEnter",
		wants = { "nvim-lsp-installer", "cmp-nvim-lsp", "null-ls.nvim" },
		config = function()
			require("config.lsp").setup()
		end,
		requires = {
			"williamboman/nvim-lsp-installer",
			"jose-elias-alvarez/null-ls.nvim",
		},
	})

	--use({
	--	"folke/trouble.nvim",
	--	requires = "kyazdani42/nvim-web-devicons",
	--	cmd = { "TroubleToggle", "Trouble" },
	--	config = function()
	--		require("trouble").setup({
	--			use_diagnostic_signs = true,
	--		})
	--	end,
	--})

	use({
		"nvim-treesitter/nvim-treesitter",
		run = ":TSUpdate",
		config = function()
			require("nvim-treesitter.configs").setup({
				ensure_installed = {
					"rust",
					"python",
					"javascript",
					"typescript",
					"c",
					"cpp",
				},
				highlight = { enable = true },
			})
		end,
	})

	-- general language packages
	use({
		"leafgarland/typescript-vim",
		"peitalin/vim-jsx-typescript",
		"rust-lang/rust.vim",
		{ "prettier/vim-prettier", run = "npm install" },
		"mfussenegger/nvim-jdtls",
	})

	-- debugger (nvim-dap)
	use({
		"mfussenegger/nvim-dap",
		config = function()
			require("config.nvim-dap")
		end,
	})

	use({
		"rcarriga/nvim-dap-ui",
		requires = { "mfussenegger/nvim-dap" },
		config = function()
			require("dapui").setup()
		end,
	})

	-- autocomplete
	use({
		"hrsh7th/nvim-cmp",
		requires = {
			"L3MON4D3/LuaSnip",
			{ "hrsh7th/cmp-buffer", after = "nvim-cmp" },
			"hrsh7th/cmp-nvim-lsp",
			{ "hrsh7th/cmp-path", after = "nvim-cmp" },
			{ "hrsh7th/cmp-nvim-lua", after = "nvim-cmp" },
			{ "saadparwaiz1/cmp_luasnip", after = "nvim-cmp" },
			{ "hrsh7th/cmp-buffer", after = "nvim-cmp" },
			{ "lukas-reineke/cmp-rg", after = "nvim-cmp" },
		},
		config = function()
			require("config.nvim-cmp")
		end,
	})

	use({
		"onsails/lspkind-nvim",
	})

	-- colorschemes
	use({ "ellisonleao/gruvbox.nvim" })
	use({ "doums/darcula" })

	-- git
	use({
		"lewis6991/gitsigns.nvim",
		requires = { "nvim-lua/plenary.nvim" },
		config = function()
			require("gitsigns").setup({
				on_attach = require("config.gitsigns").gitsigns_attach,
			})
		end,
	})

	-- status line
	use({
		"nvim-lualine/lualine.nvim",
		requires = { "kyazdani42/nvim-web-devicons", opt = true },
		config = function()
			require("config.lualine")
		end,
	})

	-- markdown previewer
	use({
		"ellisonleao/glow.nvim",
	})

	use({
		"mickael-menu/zk-nvim",
		config = function()
			require("zk").setup()
		end,
	})
	-- startup screen
	use({
		"goolord/alpha-nvim",
		config = function()
			--require("alpha").setup(require("alpha.themes.dashboard").config)
			require("config.alpha")
		end,
	})

	use({
		"folke/which-key.nvim",
		config = function()
			require("which-key").setup()
		end,
	})
end

return packer.startup(plugins_startup)
