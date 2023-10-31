return {
	{
		"nvim-neo-tree/neo-tree.nvim",
		branch = "v2.x",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"kyazdani42/nvim-web-devicons",
			"MunifTanjim/nui.nvim",
		},
		config = function()
			require("config.neo-tree").setup()
		end,
	},

	{
		"nvim-telescope/telescope.nvim",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-telescope/telescope-ui-select.nvim",
			"nvim-telescope/telescope-file-browser.nvim",
			"nvim-telescope/telescope-dap.nvim",
		},
		config = function()
			require("config.telescope").setup()
		end,
	},

	{
		"neovim/nvim-lspconfig",
		--event = "VimEnter",
		dependencies = {
			"williamboman/mason.nvim",
			"williamboman/mason-lspconfig.nvim",
			"jayp0521/mason-null-ls.nvim",
			--"jose-elias-alvarez/null-ls.nvim",
			-- archived 08/01/2023 now use none-ls.nvim
			"nvimtools/none-ls.nvim",
			"simrat39/rust-tools.nvim",
			"mfussenegger/nvim-jdtls",
			"mfussenegger/nvim-dap",
		},
		config = function()
			require("config.lsp").setup()
		end,
	},

	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
		dependencies = {
			"nvim-treesitter/playground",
		},
		config = function()
			require("config.treesitter").setup()
		end,
	},

	{
		"hrsh7th/nvim-cmp",
		dependencies = {
			"L3MON4D3/LuaSnip",
			"hrsh7th/cmp-buffer",
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-path",
			"hrsh7th/cmp-nvim-lua",
			"saadparwaiz1/cmp_luasnip",
			"hrsh7th/cmp-buffer",
			"lukas-reineke/cmp-rg",
			"hrsh7th/cmp-cmdline",
			"hrsh7th/cmp-omni",
			"onsails/lspkind-nvim", -- VScode pictograms
			"dmitmel/cmp-digraphs",
		},
		config = function()
			require("config.nvim-cmp").setup()
		end,
	},

	{
		"L3MON4D3/LuaSnip",
		config = function()
			require("config.luasnip").setup()
		end,
	},

	"ellisonleao/gruvbox.nvim",
	"doums/darcula",
	"shaunsingh/nord.nvim",

	{
		"lewis6991/gitsigns.nvim",
		dependencies = { "nvim-lua/plenary.nvim" },
		config = function()
			require("config.gitsigns").setup()
		end,
	},

	{
		"nvim-lualine/lualine.nvim",
		dependencies = { "kyazdani42/nvim-web-devicons" },
		config = function()
			require("config.lualine").setup()
		end,
	},

	{
		"goolord/alpha-nvim",
		config = function()
			require("config.alpha")
		end,
	},

	{
		"folke/which-key.nvim",
		config = function()
			require("config.whichkey").setup()
		end,
	},

	{
		"karb94/neoscroll.nvim",
		config = function()
			require("neoscroll").setup()
		end,
	},

	-- lazy.nvim
	{
		"folke/noice.nvim",
		event = "VeryLazy",
		config = function()
			require("config.noice").setup()
		end,
		opts = {
			-- add any options here
		},
		dependencies = {
			-- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
			"MunifTanjim/nui.nvim",
			-- OPTIONAL:
			--   `nvim-notify` is only needed, if you want to use the notification view.
			--   If not available, we use `mini` as the fallback
			"rcarriga/nvim-notify",
		},
	},
}
