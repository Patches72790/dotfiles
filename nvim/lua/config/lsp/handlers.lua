local M = {}

local format_async = function(err, _, result, _, bufnr)
	if err ~= nil or result == nil then
		return
	end
	if not vim.api.nvim_buf_get_option(bufnr, "modified") then
		local view = vim.fn.winsaveview()
		vim.lsp.util.apply_text_edits(result, bufnr)
		vim.fn.winrestview(view)
		if bufnr == vim.api.nvim_get_current_buf() then
			vim.api.nvim_command("noautocmd :update")
		end
	end
end

function M.setup()
	-- let telescope use this LSP stuff
	vim.lsp.handlers["textDocument/formatting"] = format_async
	vim.lsp.handlers["textDocument/references"] = require("telescope.builtin").lsp_references
	vim.lsp.handlers["textDocument/definition"] = require("telescope.builtin").lsp_definitions
end

return M
