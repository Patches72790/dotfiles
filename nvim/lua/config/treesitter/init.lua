local M = {}

function M.setup()
	require("nvim-treesitter.configs").setup({
		sync_install = false,
		auto_install = true,
		ignore_install = {},
		modules = {},
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
			"regex",
			"markdown",
			"markdown_inline",
			"vim",
			"bash",
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
