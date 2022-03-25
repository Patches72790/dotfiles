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
	formatting.eslint_d,
	formatting.rustfmt,
	formatting.shfmt,
	diagnostics.eslint_d,
}

function M.setup(opts)
	local on_attach = opts and opts.on_attach
	null_ls.setup({
		debug = true,
		sources = sources,
		debounce = 150,
		on_attach = on_attach,
		root_dir = null_ls_utils.root_pattern(".git"),
	})
end

return M
