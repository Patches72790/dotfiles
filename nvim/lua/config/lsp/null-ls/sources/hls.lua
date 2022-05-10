local h = require("null-ls.helpers")
local formatting = require("null-ls.methods").internal.FORMATTING

return h.make_builtin({
	name = "haskell-language-server",
	meta = {
		url = "https://github.com/haskell/haskell-language-server",
		description = "The official haskell language server implementation",
	},
	method = formatting,
	filetypes = { "haskell" },
	generator_opts = {
		command = "haskell-language-server-wrapper",
		args = {
			"--lsp",
		},
	},
	factory = h.formatter_factory,
})
