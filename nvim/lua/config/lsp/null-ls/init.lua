local M = {}

local null_ls = require("null-ls")
local null_ls_utils = require("null-ls.utils")
local builtins = null_ls.builtins

local with_root_file = function(builtin, file)
    return builtin.with({
        condition = function (utils)
            return utils.root_has_file(file)
        end
    })
end


local sources = {
	builtins.formatting.black.with({ extra_args = { "--fast" }, filetypes = { "python" } }),
	builtins.formatting.isort.with({ filetypes = { "python" } }),
	builtins.formatting.prettierd.with({ prefer_local = "node_modules/.bin", filetypes = { "javascript, javascriptreact, typescript, typescriptreact" } }),
	builtins.formatting.stylua.with({ filetypes = { "lua" } }),
    builtins.formatting.eslint.with({
        prefer_local = "node_modules/.bin",
        filetypes = {"javascript, javascriptreact, javascript.jsx, typescript, typescriptreact, typescript.jsx"},
        extra_args = { "--config-path", vim.fn.expand("~/Projects/atlas-webapp/app/webapp/app/.eslintrc.js") },
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
		root_dir = null_ls_utils.root_pattern(".git", "package.json"),
	})
end

return M
