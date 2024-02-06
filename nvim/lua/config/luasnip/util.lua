local M = {
	FILETYPE_TO_COMMENTS = {
		javascript = "//",
		javascriptreact = "//",
		typescript = "//",
		typescriptreact = "//",
		python = "#",
		bash = "#",
		haskell = "--",
		lua = "--",
		go = "//",
		java = "//",
		terraform = "//",
	},
}

M.add_snippets_for_filetypes = function(luasnip, filetypes, snippets)
	for _, filetype in pairs(filetypes) do
		luasnip.add_snippets(filetype, snippets)
	end
end

M.configure_ls_table = function(ls)
	return {
		snippet = ls.snippet,
		insert = ls.insert_node,
		text = ls.text_node,
		dynamic = ls.dynamic_node,
		format = require("luasnip.extras.fmt").fmt,
		rep = require("luasnip.extras").rep,
	}
end

return M
