local packer = require("packer")
local use = packer.use

local function plugins_startup()
	-- auto-update packer
	use({ "wbthomason/packer.nvim" })

	use({
		"s1n7ax/nvim-terminal",
		config = function()
			vim.o.hidden = true
			require("nvim-terminal").setup()
		end,
	})

	use({
		"lervag/vimtex",
		config = function()
			require("config.vimtex").setup()
		end,
	})

	use({
		"Patches72790/neo-notes.nvim",
		requires = {
			"nvim-lua/plenary.nvim",
			"nvim-telescope/telescope.nvim",
		},
		config = function()
			require("notes").setup()
		end,
	})

	use({
		"Patches72790/dev-search.nvim",
		requires = {
			"nvim-lua/plenary.nvim",
			"nvim-telescope/telescope.nvim",
		},
		opt = false,
		config = function()
			require("dev-search").setup({
				settings = {
					base_url = "https://cse.google.com",
					context_id = "c897a4eacb3fd1332",
					rest_api_url = "https://www.googleapis.com/customsearch/v1?",
					api_key = "AIzaSyBIlieV20utBzXYcXCkBJ97VSk7qivkXas",
				},
			})
		end,
	})

	-- file explorer tree
	use({
		"nvim-neo-tree/neo-tree.nvim",
		branch = "v2.x",
		requires = {
			"nvim-lua/plenary.nvim",
			"kyazdani42/nvim-web-devicons",
			"MunifTanjim/nui.nvim",
		},
		config = function()
			require("config.neo-tree").setup()
		end,
	})

	-- telescope search tool
	use({
		"nvim-telescope/telescope.nvim",
		requires = { "nvim-lua/plenary.nvim", "nvim-telescope/telescope-ui-select.nvim" },
		config = function()
			require("config.telescope").setup()
		end,
	})

	-- lsp config
	use({
		"neovim/nvim-lspconfig",
		event = "VimEnter",
		wants = { "mason.nvim", "cmp-nvim-lsp", "null-ls.nvim" },
		config = function()
			require("config.lsp").setup()
		end,
		requires = {
			"williamboman/mason.nvim",
			"williamboman/mason-lspconfig.nvim",
			"jayp0521/mason-null-ls.nvim",
			"jose-elias-alvarez/null-ls.nvim",
			"simrat39/rust-tools.nvim",
		},
	})

	use({
		"nvim-treesitter/nvim-treesitter",
		run = ":TSUpdate",
		requires = {
			"nvim-treesitter/playground",
		},
		config = function()
			require("config.treesitter").setup()
		end,
	})

	-- java specialized language server
	use({
		"mfussenegger/nvim-jdtls",
	})

	-- debugger (nvim-dap)
	use({
		"mfussenegger/nvim-dap",
		config = function()
			require("config.debugging").setup()
		end,
		requires = {
			"mfussenegger/nvim-dap-python",
			"nvim-telescope/telescope-dap.nvim",
			"rcarriga/nvim-dap-ui",
		},
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
			{ "hrsh7th/cmp-cmdline", after = "nvim-cmp" },
			{ "hrsh7th/cmp-omni", after = "nvim-cmp" },
			"onsails/lspkind-nvim", -- VScode pictograms
			"dmitmel/cmp-digraphs",
		},
		config = function()
			require("config.nvim-cmp").setup()
		end,
	})

	use({
		"L3MON4D3/LuaSnip",
		config = function()
			require("config.luasnip").setup()
		end,
	})

	-- colorschemes
	use({ "ellisonleao/gruvbox.nvim", "doums/darcula", "shaunsingh/nord.nvim" })

	-- git
	use({
		"lewis6991/gitsigns.nvim",
		requires = { "nvim-lua/plenary.nvim" },
		config = function()
			require("config.gitsigns").setup()
		end,
	})

	-- status line
	use({
		"nvim-lualine/lualine.nvim",
		requires = { "kyazdani42/nvim-web-devicons", opt = true },
		config = function()
			require("config.lualine").setup()
		end,
	})

	-- markdown previewer
	use({
		"ellisonleao/glow.nvim",
	})

	-- startup screen
	use({
		"goolord/alpha-nvim",
		config = function()
			require("config.alpha")
		end,
	})

	use({
		"folke/which-key.nvim",
		config = function()
			require("config.whichkey").setup()
		end,
	})

	use({
		"karb94/neoscroll.nvim",
		config = function()
			require("neoscroll").setup()
		end,
	})
end

return packer.startup(plugins_startup)
