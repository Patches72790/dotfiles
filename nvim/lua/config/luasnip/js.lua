local M = {}

local add_snippets_for_filetypes = require("config.luasnip.util").add_snippets_for_filetypes

M.configure_web_snippets = function(ls)
	local s = ls.snippet
	local t = ls.text_node
	local i = ls.insert_node
	local fmt = require("luasnip.extras.fmt").fmt

	add_snippets_for_filetypes(ls, { "javascriptreact", "javascript", "typescript", "typescriptreact" }, {
		s(
			"select",
			fmt("const {} = useSelector(select{})", {
				i(1),
				i(2),
			})
		),
	})
end

return M
