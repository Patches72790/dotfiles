local M = {}

local null_ls = require("null-ls")
local null_ls_utils = require("null-ls.utils")
local builtins = null_ls.builtins

local sources = {
	builtins.formatting.black.with({ extra_args = { "--fast" }, filetypes = { "python" } }),
	builtins.formatting.prettierd.with({ filetypes = { "javascript, javascriptreact, typescript, typescriptreact" } }),
	builtins.formatting.isort.with({ filetypes = { "python" } }),
	builtins.formatting.stylua.with({ filetypes = { "lua" } }),
}

function M.setup(opts)
	local on_attach = opts and opts.on_attach
	null_ls.setup({
		sources = sources,
		debounce = 150,
		save_after_format = false,
		on_attach = on_attach,
		root_dir = null_ls_utils.root_pattern(".git", ".package.json"),
	})
end

return M
