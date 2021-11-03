local dap = require('dap')

M = {}

M.attach_python_debugger = function()
    local host = '127.0.0.1'
    local port = 5678;
    local pythonAttachAdapter = {type = 'server', host = host, port = port}
    local pythonAttachConfig = {
        type = "python",
        request = "attach",
        connect = {port = port, host = host},
        mode = 'remote',
        name = 'Remote Attach Debugger',
        cwd = vim.fn.getcwd(),
    }

    local session = dap.attach(pythonAttachAdapter, pythonAttachConfig);
    if session == nil then io.write("Error launching adapter") end
    dap.repl.open()
end

M.attach_vscode_debugger = function()
    local dap = require('dap')
    local host = '127.0.0.1'
    local port = 5678
    local adapter = {type = 'server', host = host, port = port}
    local config = {
        type = "pwa-chrome",
        request = 'attach',
        host = host,
        port = port,
        url = "localhost:3000",
        name = 'VsCode Attach Debugger'
    }
    local session = dap.attach(adapter, config)
    if session == nil then
        io.write("Error launching adapter")
        return
    end
    io.write("Attached")
    dap.repl.open()
end


return M
