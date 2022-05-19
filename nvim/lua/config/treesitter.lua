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
		},
		highlight = { enable = true },
	})
end

return M
