local M = {}
local opts = {
	keymap = {
		preset = "default",
	},
	appearance = {
		use_nvim_cmp_as_default = false,
		nerd_font_variant = "mono",
	},
	completion = {
		menu = {
			draw = {
				columns = { { "label", "label_description", gap = 1 }, { "kind" } },
			},
		},
	},

	sources = {
		default = { "lsp", "path", "snippets", "buffer" },
	},
	signature = { enabled = true },
}

function M.setup()
	require("blink.cmp").setup(opts)
end

return M
