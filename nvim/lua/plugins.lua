return {
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
		"saghen/blink.cmp",
		dependencies = "rafamadriz/friendly-snippets",

		version = "*",
		opts_extend = { "sources.default" },
		config = function()
			require("config.blink").setup()
		end,
	},

	{
		"stevearc/oil.nvim",
		---@module 'oil'
		---@type oil.SetupOpts
		opts = {},
		-- Optional dependencies
		-- dependencies = { { "echasnovski/mini.icons", opts = {} } },
		dependencies = { "nvim-tree/nvim-web-devicons" }, -- use if you prefer nvim-web-devicons
		config = function()
			require("oil").setup()
		end,
		-- Lazy loading is not recommended because it is very tricky to make it work correctly in all situations.
		lazy = false,
	},

	{
		"neovim/nvim-lspconfig",
		event = "VimEnter",
		lazy = true,
		init_options = {
			userLanguages = {
				rust = "html",
			},
		},
		dependencies = {
			"williamboman/mason.nvim",
			"saghen/blink.cmp",
			"williamboman/mason-lspconfig.nvim",
			"jayp0521/mason-null-ls.nvim",
			"nvimtools/none-ls.nvim",
			"mrcjkb/rustaceanvim",
			--"mfussenegger/nvim-jdtls",
			--"nvim-java/nvim-java",
			"mfussenegger/nvim-dap",
			"rcarriga/nvim-dap-ui",
			"stevearc/conform.nvim",
			"nvim-neotest/nvim-nio",
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

	-- themes
	{
		"marko-cerovac/material.nvim",
		"ellisonleao/gruvbox.nvim",
		"shaunsingh/nord.nvim",
		"rose-pine/neovim",
	},

	{
		"lewis6991/gitsigns.nvim",
		event = "VeryLazy",
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
		"folke/which-key.nvim",
		config = function()
			require("which-key").setup()
		end,
	},

	{
		"folke/neodev.nvim",
		opts = {},
	},

	{
		"toppair/peek.nvim",
		event = { "VeryLazy" },
		build = "deno task --quiet build:fast",
		config = function()
			require("peek").setup()
			vim.api.nvim_create_user_command("PeekOpen", require("peek").open, {})
			vim.api.nvim_create_user_command("PeekClose", require("peek").close, {})
		end,
	},
}
