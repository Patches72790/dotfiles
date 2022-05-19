local M = {}
local whichkey = require("which-key")

local misc_mapping = {
	name = "Miscellaneous",
	w = { ":w<CR>", "Save buffer" },
	q = { ":qa<CR>", "Close neovim" },
	x = { ":x!<CR>", "Close buffer" },
	G = { ":Glow<CR>", "Open Glow" },
}

local meta_mapping = {
	name = "Meta",
	u = {
		s = { ":e $MYVIMRC<CR>", "Neovim Settings" },
		n = { ":e $NV_NOTES_PATH<CR>", "Neovim Note" },
	},
}

function M.setup()
	whichkey.setup()
	whichkey.register(meta_mapping, { prefix = "<leader>" })
	whichkey.register(misc_mapping, { prefix = "<leader>" })
end

return M
