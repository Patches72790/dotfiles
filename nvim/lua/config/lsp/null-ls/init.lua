local M = {}

local null_ls = require("null-ls")
local null_ls_utils = require("null-ls.utils")
local formatting = null_ls.builtins.formatting
local diagnostics = null_ls.builtins.diagnostics

local sources = {
	--formatting.black.with({ extra_args = { "--fast" } }),
	formatting.isort.with({ filetypes = { "python" } }),
	formatting.stylua,
	formatting.eslint_d,
	formatting.rustfmt,
	require("config.lsp.null-ls.sources.darker"),
	diagnostics.eslint_d,
}

function M.setup(opts)
	local on_attach = opts and opts.on_attach
	null_ls.setup({
		debug = true,
		sources = sources,
		debounce = 150,
		save_after_format = false,
		on_attach = on_attach,
		root_dir = null_ls_utils.root_pattern(".git"),
	})
end

return M
