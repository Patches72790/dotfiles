local M = {}
local whichkey = require("which-key")

local misc_mapping = {
	name = "Miscellaneous",
	u = {
		s = { ":e $MYVIMRC<CR>", "Neovim Settings" },
		n = { ":e $NV_NOTES_PATH<CR>", "Neovim Note" },
	},
}

function M.setup()
	whichkey.setup()
	whichkey.register(misc_mapping, { prefix = "<leader>" })
end

return M
