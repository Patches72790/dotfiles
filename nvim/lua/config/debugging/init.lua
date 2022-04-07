local M = {}

local function configure()
	-- sign definitions
	vim.fn.sign_define("DapBreakpoint", { text = "🟥", texthl = "", linehl = "", numhl = "" })
	vim.fn.sign_define("DapBreakpointRejected", { text = "🟦", texthl = "", linehl = "", numhl = "" })
	vim.fn.sign_define("DapStopped", { text = "⭐️", texthl = "", linehl = "", numhl = "" })
end

local function configure_exts()
	local dapui = require("dapui")
	dapui.setup()
end

local function configure_debuggers()
	require("config.debugging.python").setup()
end

function M.setup()
	configure()
	configure_exts()
    configure_debuggers()
	require("config.debugging.keymap").setup()
end

return M
