local h = require("null-ls.helpers")
local formatting = require("null-ls.methods").internal.FORMATTING

return h.make_builtin({
	name = "yaml-language-server",
	meta = {
		url = "https://github.com/redhat-developer/yaml-language-server",
	},
	method = formatting,
	filetypes = { "yaml", "yml" },
	generator_opts = {
		command = "node",
		args = {
			os.getenv("XDG_DATA_HOME")
				.. "/nvim/lsp_servers/yamlls/node_modules/yaml-language-server/out/server/src/server.js",
			"--stdio",
		},
	},
	factory = h.formatter_factory,
})
