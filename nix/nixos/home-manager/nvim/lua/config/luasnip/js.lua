local M = {}

local add_snippets_for_filetypes = require("config.luasnip.util").add_snippets_for_filetypes

M.configure_snippets = function(ls)
	local s = ls.snippet
	local t = ls.text_node
	local i = ls.insert_node
	local fmt = require("luasnip.extras.fmt").fmt

	add_snippets_for_filetypes(ls, { "javascriptreact", "javascript", "typescript", "typescriptreact" }, {
		s(
			"describe",
			fmt('describe("{}", () => {{}})', {
				i(1),
			})
		),
		s(
			"it",
			fmt('it("{}", () => {{}})', {
				i(1),
			})
		),
		s(
			"fnexp",
			fmt("{} = ({}) => {{{}}}", {
				i(1),
				i(2),
				i(3),
			})
		),
		s(
			"fndecl",
			fmt("const {} = ({}) => {{{}}}", {
				i(1),
				i(2),
				i(3),
			})
		),

		s(
			"intfce",
			fmt("export interface {} {{\n{}\n}}", {
				i(1),
				i(2),
			})
		),
	})
end

return M
