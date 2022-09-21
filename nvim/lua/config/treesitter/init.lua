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
		},
		highlight = { enable = true },
		playground = {
			enable = true,
		},
	})

	require("config.treesitter.helpers")
end

return M
