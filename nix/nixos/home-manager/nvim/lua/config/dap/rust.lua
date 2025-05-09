local M = {}
local dap = require("dap")

local lldb_adapter = {
	type = "server",
	name = "codelldb",
	port = "${port}",
	executable = {
		command = vim.fn.stdpath("data") .. "/mason/bin/codelldb",
		args = { "--port", "${port}" },
	},
}

local rust_configuration = {
	name = "Launch Rust",
	type = "lldb",
	request = "launch",
	program = "${file}",
	cwd = "${workspaceFolder}",
}

function M.setup()
	dap.adapters.lldb = lldb_adapter
	dap.configurations.rust = { rust_configuration }
end

return M
