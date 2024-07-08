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
		event = "VimEnter",
		lazy = true,
		init_options = {
			userLanguages = {
				rust = "html",
			},
		},
		dependencies = {
			"williamboman/mason.nvim",
			"williamboman/mason-lspconfig.nvim",
			"jayp0521/mason-null-ls.nvim",
			"nvimtools/none-ls.nvim",
			"mrcjkb/rustaceanvim",
			"mfussenegger/nvim-jdtls",
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
		event = "VeryLazy",
		config = function()
			require("config.luasnip").setup()
		end,
	},

	"ellisonleao/gruvbox.nvim",
	"shaunsingh/nord.nvim",
	"rose-pine/neovim",

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
		"goolord/alpha-nvim",
		config = function()
			require("config.alpha")
		end,
	},

	{
		"folke/which-key.nvim",
		config = function()
			require("which-key").setup()
		end,
	},

	--	{
	--		"karb94/neoscroll.nvim",
	--		event = "VeryLazy",
	--		config = function()
	--			require("neoscroll").setup()
	--		end,
	--	},

	{
		"folke/neodev.nvim",
		opts = {},
	},

	{
		"folke/noice.nvim",
		event = "VeryLazy",
		config = function()
			require("noice").setup({
				lsp = {
					-- override markdown rendering so that **cmp** and other plugins use **Treesitter**
					override = {
						["vim.lsp.util.convert_input_to_markdown_lines"] = true,
						["vim.lsp.util.stylize_markdown"] = true,
						["cmp.entry.get_documentation"] = true,
					},
				},
				-- you can enable a preset for easier configuration
				presets = {
					bottom_search = true, -- use a classic bottom cmdline for search
					command_palette = true, -- position the cmdline and popupmenu together
					long_message_to_split = true, -- long messages will be sent to a split
					inc_rename = false, -- enables an input dialog for inc-rename.nvim
					lsp_doc_border = false, -- add a border to hover docs and signature help
				},
			})
		end,
		opts = {},
		dependencies = {
			-- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
			"MunifTanjim/nui.nvim",
			-- OPTIONAL:
			--   `nvim-notify` is only needed, if you want to use the notification view.
			--   If not available, we use `mini` as the fallback
			"rcarriga/nvim-notify",
		},
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
