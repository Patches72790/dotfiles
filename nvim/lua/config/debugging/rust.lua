local M = {}
local dap = require("dap")

local lldb_adapter = {
	type = "executable",
	command = "lldb-vscode-13",
	name = "lldb",
}

local rust_configuration = {
	name = "Launch Rust",
	type = "lldb",
	request = "launch",
	program = function()
		return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
	end,
	cwd = "${workspaceFolder}",
	stopOnEntry = false,
	args = function()
		return vim.fn.input("Args for rust executable: ")
	end,
	runInTerminal = false,
}

function M.setup()
	dap.adapters.lldb = lldb_adapter
	dap.configurations.rust = { rust_configuration }
end

return M
