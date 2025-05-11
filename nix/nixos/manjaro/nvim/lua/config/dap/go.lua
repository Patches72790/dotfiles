local M = {}
local dap = require("dap")

local delve_adapter = {
	type = "server",
	port = "${port}",
	executable = {
		command = vim.fn.stdpath("data") .. "/mason/bin/dlv",
		args = { "dap", "-l", "127.0.0.1:${port}" },
	},
}

local go_configuraions = {
	{
		name = "Debug",
		type = "go",
		request = "launch",
		program = "${file}",
	},
	{
		type = "go",
		name = "Attach (Pick Process)",
		mode = "local",
		request = "attach",
		processId = require("dap.utils").pick_process,
	},
}

function M.setup()
	dap.adapters.go = delve_adapter
	dap.configurations.go = go_configuraions
end

return M
