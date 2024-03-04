local M = {}

local function keymappings(client, bufnr)
	local builtin = require("telescope.builtin")

	vim.keymap.set("n", "[a", vim.diagnostic.goto_prev, { desc = "Go to previous diagnostic" })
	vim.keymap.set("n", "]a", vim.diagnostic.goto_next, { desc = "Go to next diagnostic" })
	vim.keymap.set("n", "<leader>t", vim.diagnostic.setloclist, { desc = "Open diagnostic [Q]uickfix list" })
	vim.keymap.set("n", "K", vim.lsp.buf.hover, { desc = "LSP Hover" })

	vim.keymap.set("n", "<leader>lR", builtin.lsp_references, { desc = "LSP References" })
	vim.keymap.set("n", "<leader>la", vim.lsp.buf.code_action, { desc = "LSP Code Actions" })
	vim.keymap.set("n", "<leader>ln", vim.lsp.buf.rename, { desc = "LSP Rename" })
	vim.keymap.set("n", "<leader>li", "<cmd>LspInfo<CR>", { desc = "LSP Info" })
	vim.keymap.set("n", "<leader>ls", builtin.diagnostics, { desc = "Diagnostics" })
	vim.keymap.set("n", "<leader>ls", builtin.lsp_document_symbols, { desc = "LSP Document Symbols" })
	vim.keymap.set("n", "<leader>lS", builtin.lsp_dynamic_workspace_symbols, { desc = "LSP Dynamic Document Symbols" })
	vim.keymap.set("n", "<leader><Esc>", "<cmd>nohl<CR>", { desc = "Turn on highlighting" })

	if client.server_capabilities.documentFormattingProvider then
		--vim.api.nvim_create_user_command("LspFormat", vim.lsp.buf.format, { desc = "LSP Format the current buffer" })
		vim.api.nvim_create_user_command("LspFormat", "lua vim.lsp.buf.format()", {})
		vim.keymap.set("n", "<leader>lF", "<cmd>:LspFormat<CR>", { desc = "LSP Format" })
	end

	vim.keymap.set("n", "gd", builtin.lsp_definitions, { desc = "LSP Definitions" })
	vim.keymap.set("n", "gD", vim.lsp.buf.declaration, { desc = "LSP Declaration" })
	vim.keymap.set("n", "gs", vim.lsp.buf.signature_help, { desc = "LSP Signature Help" })
	vim.keymap.set("n", "gI", builtin.lsp_implementations, { desc = "LSP Implementations" })
	vim.keymap.set("n", "gt", builtin.lsp_type_definitions, { desc = "LSP Type Definitions" })
end

-- Setup the keymappings for client and bufnr
function M.setup(client, bufnr)
	keymappings(client, bufnr)
end

return M
