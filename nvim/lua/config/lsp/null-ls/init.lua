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
	formatting.prettierd,
	diagnostics.eslint_d,
	formatting.shfmt,
	formatting.gofmt,
	formatting.rustfmt.with({ extra_args = { "--edition=2021" } }),
	formatting.taplo,
}

local filetype_to_buffer_event = {
	python = "BufWritePost",
}

function M.setup(_)
	local augroup = vim.api.nvim_create_augroup("LspFormatting", {})
	null_ls.setup({
		debug = true,
		sources = sources,
		debounce = 150,
		on_attach = function(client, bufnr)
			if
				client.supports_method("textDocument/formatting")
				and client.server_capabilities.documentFormattingProvider
			then
				local event_fn = filetype_to_buffer_event[vim.bo.filetype] or "BufWritePre"
				vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
				vim.api.nvim_create_autocmd(event_fn, {
					group = augroup,
					buffer = bufnr,
					callback = function()
						vim.lsp.buf.format({ bufnr = bufnr })
					end,
				})
			end
		end,
		root_dir = null_ls_utils.root_pattern(".git"),
		update_in_insert = true,
	})
end

return M
