local M = {}

-- Empty tables use the LSP for formatting
M.setup = function()
	require("conform").setup({
		formatters_by_ft = {
			lua = { "stylua" },
			python = { "black" },
			javascript = { { "prettierd", "prettier" } },
			typescript = { { "prettierd", "prettier" } },
			css = { "prettierd" },
			html = { "prettierd" },
			json = { "prettierd" },
			yaml = { "prettierd" },
			go = { "goimports", "gofmt" },
			sh = { "shfmt" },
			xml = { "xmlformat" },
			rust = {},
			java = {},
			dockerfile = {},
			terraform = {},
			haskell = {},
		},
		format_on_save = {
			timeout_ms = 500,
			lsp_fallback = true,
		},
	})
end

return M
