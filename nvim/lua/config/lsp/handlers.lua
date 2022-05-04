local M = {}

function M.setup()
	vim.lsp.handlers["textDocument/references"] = require("telescope.builtin").lsp_references
	vim.lsp.handlers["textDocument/definition"] = require("telescope.builtin").lsp_definitions
end

return M
