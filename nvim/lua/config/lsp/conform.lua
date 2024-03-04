local M = {}

M.setup = function()
	require("conform").setup({
		formatters_by_ft = {
			lua = { "stylua" },
			python = { "black" },
			javascript = { { "prettierd", "prettier" } },
			go = { "gofmt" },
		},
		format_on_save = {
			timeout_ms = 500,
			lsp_fallbck = true,
		},
	})
end

return M
