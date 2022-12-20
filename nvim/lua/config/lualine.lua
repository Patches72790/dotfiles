local M = {}

local lualine = require("lualine")

function M.get_abbreviated_filename()
	-- TODO - Need to abbreviate string with first letters of filepath
	return vim.fn.getreg("%")
end

function M.setup()
	lualine.setup({
		options = {
			theme = "nord",
		},
		sections = {
			lualine_c = {},
		},
		tabline = {
			lualine_a = { "tabs" },
			lualine_b = { "require('config.lualine').get_abbreviated_filename()" },
			lualine_c = {},
			lualine_x = {},
			lualine_y = {},
			lualine_z = {},
		},
	})
end

return M
