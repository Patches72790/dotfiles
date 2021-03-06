local M = {}

local custom_configurations = {
	name = "Gunicorn Test Debugger",
	type = "python",
	request = "attach",
	host = "127.0.0.1",
	port = 5678,
	justMyCode = false,
    gevent = true,
}

function M.setup(_)
	require("dap-python").setup("python", {})
	table.insert(require("dap").configurations.python, custom_configurations)
	require("dap-python").test_runner = "pytest"
end

return M
