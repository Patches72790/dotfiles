local M = {}

local add_snippets_for_filetypes = require("config.luasnip.util").add_snippets_for_filetypes

M.configure_web_snippets = function(ls)
	local s = ls.snippet
	local t = ls.text_node
	local i = ls.insert_node

	add_snippets_for_filetypes(ls, { "javascriptreact", "javascript", "typescript", "typescriptreact" }, {
		s("div", {
			t("<div>"),
			i(1),
			t("</div>"),
		}),
	})
end

return M
