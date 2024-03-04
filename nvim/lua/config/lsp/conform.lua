local M = {}

M.setup = function()
	require("conform").setup({
		formatters_by_ft = {
			lua = { "stylua" },
			python = { "black" },
			javascript = { { "prettierd", "prettier" } },
			go = { "goimports", "gofmt" },
			rust = {},
		},
		format_on_save = {
			timeout_ms = 500,
			lsp_fallback = true,
		},
	})
end

return M
