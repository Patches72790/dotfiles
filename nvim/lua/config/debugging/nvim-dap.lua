local dap = require("dap")
local map = require("config.util").map

dap.adapters.lldb = {
	type = "executable",
	command = "/usr/local/bin/lldb-vscode",
	name = "lldb",
}

dap.configurations.rust = {
	{
		name = "Launch",
		type = "lldb",
		request = "launch",
		program = function()
			return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
		end,
		cwd = "${workspaceFolder}",
		stopOnEntry = false,
		args = function()
			return vim.fn.input("Args for executable: ")
		end,
		runInTerminal = false,
	},
}

dap.adapters.python = {
	type = "executable",
	command = os.getenv("PYHTON_CONDA_EXE"),
	args = { "-m", "debugpy.adapter" },
}

dap.configurations.python = {
	{
		type = "server",
		request = "attach",
		name = "Attach",
		program = "${file}",
		pythonPath = function()
			return os.getenv("PYHTON_CONDA_EXE")
		end,
	},
}

dap.adapters.javascript = {
	type = "executable",
	command = "node",
	args = {
		os.getenv("XDG_DATA_HOME") .. "/nvim/nvim-dap-adapters/vscode-js-debug/out/src/vsDebugServer.js",
	},
}

dap.configurations.javascript = {
	{
		type = "vscode-js-debug",
		request = "launch",
		program = "${workspaceFolder}/${file}",
		cwd = vim.fn.getcwd(),
		sourceMaps = true,
		protocol = "inspector",
		console = "integratedTerminal",
		skipFiles = { "**/node_modules/**", "<node_internals>/**" },
		restart = true,
	},
}


