local M = {}

local function configure_lsp_diagnostics()
	vim.diagnostic.config({
		--virtual_text = {
		--	source = "always",
		--},
		float = {
			source = "always",
		},
	})
end

function M.setup()
	configure_lsp_diagnostics()
end

return M
