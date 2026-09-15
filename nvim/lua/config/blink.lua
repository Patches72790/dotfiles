local M = {}

function M.opts()
	return {
		-- 1. VS Code style Keymaps
		keymap = {
			preset = "none", -- We explicitly map behaviors to mimic VS Code
			["<C-space>"] = { "show", "show_documentation", "hide_documentation" },
			["<C-e>"] = { "hide" },
			["<CR>"] = { "accept", "fallback" },

			-- Tab behavior mirrors VS Code item cycling and snippet parameter jumping
			["<Tab>"] = { "select_next", "snippet_forward", "fallback" },
			["<S-Tab>"] = { "select_prev", "snippet_backward", "fallback" },

			["<Up>"] = { "select_prev", "fallback" },
			["<Down>"] = { "select_next", "fallback" },
			["<C-b>"] = { "scroll_documentation_up", "fallback" },
			["<C-f>"] = { "scroll_documentation_down", "fallback" },
		},

		-- 2. Visuals & Layout mimicking VS Code
		appearance = {
			use_nvim_cmp_as_default = true, -- Inherits clean highlighting from your theme
			nerd_font_variant = "mono",
		},

		completion = {
			-- Automatically show the documentation window just like VS Code does
			documentation = {
				auto_show = true,
				auto_show_delay_ms = 200,
				window = { border = "rounded" },
			},

			-- Customizing the menu elements to look structured
			menu = {
				border = "rounded",
				draw = {
					columns = {
						{ "kind_icon", "kind" },
						{ "label", "label_description", gap = 1 },
					},
				},
			},
		},

		-- 3. Snippets Engine
		snippets = {
			preset = "default", -- Uses Neovim's native engine to parse VS Code snippets
		},
	}
end

--local opts2 = {
--	keymap = {
--		preset = "default",
--	},
--	appearance = {
--		use_nvim_cmp_as_default = false,
--		nerd_font_variant = "mono",
--	},
--	completion = {
--		menu = {
--			draw = {
--				columns = { { "label", "label_description", gap = 1 }, { "kind" } },
--			},
--		},
--	},
--
--	sources = {
--		default = { "lsp", "path", "snippets", "buffer" },
--	},
--	signature = { enabled = true },
--}

return M
