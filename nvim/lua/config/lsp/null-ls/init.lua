local M = {}

local null_ls = require("null-ls")
local null_ls_utils = require("null-ls.utils")
local builtins = null_ls.builtins

local sources = {
	builtins.formatting.black.with({ extra_args = { "--fast" } }),
	builtins.formatting.prettierd,
	builtins.formatting.isort,
	builtins.formatting.stylua,
}

function M.setup(opts)
	null_ls.setup({
		sources = sources,
		debounce = 150,
		save_after_format = false,
		on_attach = opts.on_attach,
		root_dir = null_ls_utils.root_pattern(".git", ".package.json"),
	})
end

return M
