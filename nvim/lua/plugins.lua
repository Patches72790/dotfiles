local packer = require("packer")
local use = packer.use

local function plugins_startup()
	-- auto-update packer
	use({ "wbthomason/packer.nvim" })

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
		--"/Users/PXH050/Projects/neovim_plugins/dev-search.nvim",
		requires = {
			"nvim-lua/plenary.nvim",
		},
		opt = false,
		config = function()
			require("dev-search").setup({
				settings = {
					base_url = "https://cse.google.com",
					context_id = "c897a4eacb3fd1332",
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
		wants = { "nvim-lsp-installer", "cmp-nvim-lsp", "null-ls.nvim" },
		config = function()
			require("config.lsp").setup()
		end,
		requires = {
			"williamboman/nvim-lsp-installer",
			"jose-elias-alvarez/null-ls.nvim",
			"simrat39/rust-tools.nvim",
		},
	})

	use({
		"nvim-treesitter/nvim-treesitter",
		run = ":TSUpdate",
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
	use({ "ellisonleao/gruvbox.nvim", "doums/darcula" })

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
