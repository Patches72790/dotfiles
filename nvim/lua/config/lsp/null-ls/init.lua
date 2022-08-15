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
	formatting.rustfmt.with({ extra_args = { "--edition=2021" } }),
	formatting.taplo,
	formatting.remark,
	--require('config.lsp.null-ls.sources.yamlls'),
	diagnostics.eslint_d,
}

local filetype_to_buffer_event = {
	python = "BufWritePost",
}

-- Used from null-ls.nvim wiki for async_formatting
-- Use at your own risk, usually safer to synchronous format
local async_format = function(bufnr)
	bufnr = bufnr or vim.api.nvim_get_current_buf()

	vim.lsp.buf_request(
		bufnr,
		"textDocument/formatting",
		{ textDocument = { uri = vim.uri_from_bufnr(bufnr) } },
		function(err, res)
			if err then
				local err_msg = type(err) == "string" and err or err.message
				vim.notify("formatting: " .. err_msg, vim.log.levels.WARN)
				return
			end

			-- don't apply results f buffer is unloaded or modified
			if not vim.api.nvim_buf_is_loaded(bufnr) or vim.api.nvim_buf_get_option(bufnr, "modified") then
				return
			end

			if res then
				vim.lsp.util.apply_text_edits(res, bufnr)
				vim.api.nvim_buf_call(bufnr, function()
					vim.cmd("silent noautocmd update")
				end)
			end
		end
	)
end

function M.setup(_)
	local augroup = vim.api.nvim_create_augroup("LspFormatting", {})
	null_ls.setup({
		debug = true,
		sources = sources,
		debounce = 150,
		on_attach = function(client, bufnr)
			if
				client.supports_method("textDocument/formatting") and client.resolved_capabilities.document_formatting
			then
				local event_fn = filetype_to_buffer_event[vim.bo.filetype] or "BufWritePre"
				vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
				vim.api.nvim_create_autocmd(event_fn, {
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
