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

return M
