local M = {}
local dap = require("dap")

local lldb_adapter = {
	type = "executable",
	command = "code-lldb",
	name = "lldb",
}

local rust_configuration = {
	name = "Launch Rust",
	type = "lldb",
	request = "launch",
	program = "${file}",
	cwd = "${workspaceFolder}",
	stopOnEntry = false,
	args = function()
		return vim.fn.input("Args for rust executable: ")
	end,
	runInTerminal = false,
}

function M.setup()
	dap.configurations.rust = { rust_configuration }
end

return M
