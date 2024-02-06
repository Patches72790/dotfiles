local M = {}

local add_snippets_for_filetypes = require("config.luasnip.util").add_snippets_for_filetypes

local err_string = "\
if {} != nil {{\
    panic({})\
}}\
"

M.configure_snippets = function(ls)
	local s = ls.snippet
	local i = ls.insert_node
	local fmt = require("luasnip.extras.fmt").fmt
	local rep = require("luasnip.extras").rep

	add_snippets_for_filetypes(ls, { "go" }, {
		s("err", fmt(err_string, { i(1), rep(1) })),
	})
end

return M
