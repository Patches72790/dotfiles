local M = {}
local whichkey = require("which-key")

local terminal_window_mapping = {
	name = "Terminal",
	["<C-w>h"] = { "<C-\\><C-n><C-w>h" },
	["<C-w>j"] = { "<C-\\><C-n><C-w>j" },
	["<C-w>k"] = { "<C-\\><C-n><C-w>k" },
	["<C-w>l"] = { "<C-\\><C-n><C-w>l" },
}

function M.setup()
	whichkey.setup()
	--whichkey.register(terminal_window_mapping, { mode = "t", prefix = "<leader>" })
end

return M
