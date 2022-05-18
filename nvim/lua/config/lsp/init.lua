local M = {}

local function on_attach(client, bufnr)
	-- configure the keymappings
	require("config.lsp.keymapping").setup(client, bufnr)

	-- Configure Formatting
	require("config.lsp.null-ls.formatters").setup(client, bufnr)

    require('config.lsp.diagnostics').setup()
end

-- update nvim cmp capabilities
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require("cmp_nvim_lsp").update_capabilities(capabilities)

-- setup LSP handlers
require("config.lsp.handlers").setup()

function M.setup()
	local opts = {
		on_attach = on_attach,
		capabilities = capabilities,
		flags = {
			debounce_text_changes = 150,
		},
	}

	require("config.lsp.installer").setup(opts)
	require("config.lsp.null-ls").setup(opts)
end

return M
