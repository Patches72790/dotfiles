return {

	{
		"Julian/lean.nvim",
		event = { "BufReadPre *.lean", "BufNewFile *.lean" },

		dependencies = {
			"neovim/nvim-lspconfig",
			"nvim-lua/plenary.nvim",
			"nvim-telescope/telescope.nvim", -- for 2 Lean-specific pickers
			-- 'andrewradev/switch.vim',        -- for switch support
			-- 'tomtom/tcomment_vim',           -- for commenting
		},

		---@type lean.Config
		opts = { -- see below for full configuration options
			mappings = true,
		},
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
		"folke/lazydev.nvim",
		ft = "lua", -- only load on lua files
		opts = {
			library = {
				-- See the configuration section for more details
				-- Load luvit types when the `vim.uv` word is found
				{ path = "${3rd}/luv/library", words = { "vim%.uv" } },
			},
		},
	},
	{
		"saghen/blink.cmp",
		dependencies = {
			"saghen/blink.lib",
			"rafamadriz/friendly-snippets",
		},
		build = function()
			require("config.blink").setup()
		end,
	},

	{

		"echasnovski/mini.nvim",
		config = function()
			-- Around/inside objects commands
			require("mini.ai").setup({ n_lines = 500 })

			-- Mutate around/inside objects more easily
			require("mini.surround").setup()

			local statusline = require("mini.statusline")
			statusline.setup()
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
			"mason-org/mason.nvim",
			"saghen/blink.cmp",
			"mason-org/mason-lspconfig.nvim",
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
	--	{
	--		"romus204/tree-sitter-manager.nvim",
	--		dependencies = {}, -- tree-sitter CLI must be installed system-wide
	--		config = function()
	--			require("config.treesitter").setup()
	--		end,
	--	},
	{
		"nvim-treesitter/nvim-treesitter",
		branch = "main",
		build = ":TSUpdate",
		lazy = false,
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
		"folke/which-key.nvim",
		config = function()
			require("which-key").setup()
		end,
	},

	{
		"chomosuke/typst-preview.nvim",
		lazy = false, -- or ft = 'typst'
		version = "1.*",
		opts = {}, -- lazy.nvim will implicitly calls `setup {}`
		config = function()
			require("typst-preview").setup({
				debug = true,
				open_cmd = "open -a Preview %s",
				dependencies_bin = {
					["tinymist"] = "tinymist",
				},
			})
		end,
	},
}
