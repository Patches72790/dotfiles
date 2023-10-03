local M = {}

local function configure_lsp_diagnostics()
	vim.diagnostic.config({
		underline = true,
		float = {
			border = "rounded",
			source = "always",
		},
	})
end

function M.setup()
	configure_lsp_diagnostics()
end

return M
