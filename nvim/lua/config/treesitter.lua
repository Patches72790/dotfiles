local M = {}

function M.setup()
	local orgmode = require("orgmode")

	orgmode.setup_ts_grammar()
	require("nvim-treesitter.configs").setup({
		ensure_installed = {
			"rust",
			"python",
			"javascript",
			"typescript",
			"c",
			"cpp",
			"org",
		},
		highlight = { enable = true, additional_vim_regex_highlighting = { "org" } },
	})

	local org_path = os.getenv("ORG_PATH") or os.getenv("HOME") .. "/org"
	orgmode.setup_ts_grammar({
		org_agenda_files = { org_path .. "/*", org_path .. "/**/*" },
		org_default_notes_file = org_path .. "/refile.org",
	})
end

return M
