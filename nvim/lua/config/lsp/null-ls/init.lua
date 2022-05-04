local M = {}

local null_ls = require("null-ls")
local null_ls_utils = require("null-ls.utils")
local formatting = null_ls.builtins.formatting
local diagnostics = null_ls.builtins.diagnostics

local sources = {
	require("config.lsp.null-ls.sources.darker").with({
		extra_args = { "--isort" },
	}), -- darker formatter for python = black + isort
	formatting.stylua,
	formatting.prettierd.with({
		filetypes = { "html", "json", "css" },
	}),
	formatting.eslint_d,
	formatting.shfmt,
	formatting.gofmt,
	diagnostics.eslint_d,
}

function M.setup(_)
	local augroup = vim.api.nvim_create_augroup("LspFormatting", {})
	null_ls.setup({
		debug = true,
		sources = sources,
		debounce = 150,
		on_attach = function(client, bufnr)
			if client.supports_method("textDocument/formatting") then
				vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
				vim.api.nvim_create_autocmd("BufWritePost", {
					group = augroup,
					buffer = bufnr,
					callback = function()
						-- 0.8 Note -- use vim.lsp.buf.format({ bufnr = bufnr })
						vim.lsp.buf.formatting_sync(nil, 2000)
					end,
				})
			end
		end,
		root_dir = null_ls_utils.root_pattern(".git"),
		update_in_insert = true,
	})
end

return M
