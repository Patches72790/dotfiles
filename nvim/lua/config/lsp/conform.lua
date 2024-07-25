local M = {}

-- Empty tables use the LSP for formatting
M.setup = function()
	require("conform").setup({
		formatters_by_ft = {
			lua = { "stylua" },
			python = { "blackd-client", "black" },
			javascript = { { "prettierd", "prettier" } },
			typescript = { { "prettierd", "prettier" } },
			markdown = { "prettierd" },
			css = { "prettierd" },
			scss = { "prettierd" },
			html = { "prettierd" },
			json = { "prettierd" },
			yaml = { "prettierd" },
			go = { "goimports", "gofmt" },
			sh = { "shfmt" },
			xml = { "xmlformat" },
			rust = {},
			java = {},
			dockerfile = {},
			terraform = { "terraform_fmt" },
			haskell = {},
			nix = {},
		},
		format_on_save = function(bufnr)
			if vim.g.conform_autoformat_disabled or vim.b[bufnr].conform_autoformat_disabled then
				return
			end
			return {
				timeout_ms = 500,
				lsp_fallback = true,
			}
		end,
	})

	vim.api.nvim_create_user_command("ConformFormatDisable", function(args)
		if args.bang then
			vim.b.conform_autoformat_disabled = true
		else
			vim.g.conform_autoformat_disabled = true
		end
	end, { desc = "Disable Conform auto-format-on-save", bang = true })
	vim.api.nvim_create_user_command("ConformFormatEnable", function(args)
		vim.b.conform_autoformat_disabled = false
		vim.g.conform_autoformat_disabled = false
	end, { desc = "Disable Conform auto-format-on-save" })
end

return M
