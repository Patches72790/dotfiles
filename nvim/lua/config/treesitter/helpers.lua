local M = {}

local function i(value)
	print(vim.inspect(value))
end

function M.query()
	local buffer = vim.api.nvim_get_current_buf()
	local q = require("vim.treesitter.query")
	local language_tree = vim.treesitter.get_parser(buffer, "lua")
	local syntax_tree = language_tree:parse()
	local root = syntax_tree[1]:root()
	local query = vim.treesitter.parse_query(

		"lua",
		[[
        (
           function_call name: (dot_index_expression
             field: (identifier) @id                       
           )
        )
    ]]
	)

	--i(vim.treesitter.query.list_directives())
	--i(vim.treesitter.query.list_predicates())

	for _, matches, _ in query:iter_matches(root, buffer) do
		for id, node in pairs(matches) do
			local name = q.get_node_text(node, buffer)
			i(node:type())
			i(node:range())
			i(name)
		end
	end
end

M.query()

return M
