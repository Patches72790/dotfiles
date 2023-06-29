local M = {}

function M.setup()
	require("nvim-treesitter.configs").setup({
		ensure_installed = {
			"rust",
			"python",
			"javascript",
			"typescript",
			"c",
			"cpp",
			"go",
			"lua",
			"query",
			"haskell",
			"yaml",
			"json",
			"html",
			"css",
		},
		highlight = { enable = true },
		playground = {
			enable = true,
		},
		indent = {
			enable = true,
		},
	})
end

return M
