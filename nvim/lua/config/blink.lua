local M = {}
local opts = {
	keymap = {
		preset = "default",
	},
	completion = {
		menu = {
			draw = {
				columns = { { "label", "label_description", gap = 1 }, { "kind" } },
			},
		},
	},

	sources = {
		default = { "lazydev", "lsp", "path", "snippets", "buffer" },
	},
	signature = { enabled = true },
}

function M.setup()
	require("blink.cmp").setup(opts)
end

return M
