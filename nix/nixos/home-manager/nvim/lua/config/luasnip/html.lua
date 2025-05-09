local M = {}

local add_snippets_for_filetypes = require("config.luasnip.util").add_snippets_for_filetypes

M.configure_snippets = function(ls)
	local s = ls.snippet
	local i = ls.insert_node
	local fmt = require("luasnip.extras.fmt").fmt
	local rep = require("luasnip.extras").rep

	add_snippets_for_filetypes(ls, { "html" }, {
		s(
			"htelement",
			fmt('<{} class="{}">{}</{}>', {
				i(1, "div"),
				i(2),
				i(3),
				rep(1),
			})
		),
	})
end

return M
