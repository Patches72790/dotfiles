local M = {}

local null_ls = require("null-ls")
local null_ls_utils = require("null-ls.utils")
local formatting = null_ls.builtins.formatting
local diagnostics = null_ls.builtins.diagnostics

local sources = {
	formatting.black.with({ extra_args = { "--fast" } }),
	formatting.isort.with({ filetypes = { "python" } }),
	formatting.prettier.with({
		prefer_local = "node_modules/.bin",
		extra_args = { "--single-quote", "--no-semi", "--jsx-single-quote" },
	}),
	formatting.stylua,
	formatting.eslint.with({
		prefer_local = "node_modules/.bin/",
		extra_args = { "--config", vim.fn.expand("~/Projects/atlas-webapp/app/webapp/app/.eslintrc.js") },
	}),
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
