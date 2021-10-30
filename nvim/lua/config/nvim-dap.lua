local dap = require('dap');
local map = require('config.util').map;

local attach_python_debugger = function()
    local dap = require('dap')
    local host = '127.0.0.1'
    local port = 5678;
    local pythonAttachAdapter = {type = 'server', host = host, port = port}
    local pythonAttachConfig = {
        type = "python",
        request = "attach",
        connect = {port = port, host = host},
        mode = 'remote',
        name = 'Remote Attach Debugger'
    }

    local session = dap.attach(pythonAttachAdapter, pythonAttachConfig);
    if session == nil then io.write("Error launching adapter") end
    dap.repl.open()
end

dap.adapters.python = {
    type = 'executable',
    command = os.getenv('HOME') .. '/.pyenv/versions/3.7.11/bin/python3',
    args = {'-m', 'debugpy.adapter'}
}

dap.configurations.python = {
    {
        type = 'python',
        request = 'launch',
        name = 'Launch file',
        program = "${file}",
        pythonPath = function()
            local cwd = vim.fn.getcwd();
            if vim.fn.executable(cwd .. '/env/bin/python3') == 1 then
                return cwd .. '/env/bin/python3';
            elseif vim.fn.executable(cwd .. '/venv/bin/python3') == 1 then
                return cwd .. '/venv/bin/python3';
            else
                return os.getenv("HOME") .. '/miniconda/envs/env/bin/python';
            end
        end
    }, {
        type = 'python',
        request = 'attach',
        port = 5678,
        host = '127.0.0.1',

        name = 'Debug (attach) Remote',
        pythonPath = function()
            return os.getenv("HOME") .. '/miniconda/envs/env/bin/python';
        end
    }
}

dap.adapters.javascript = {
    type = 'executable',
    command = 'node',
    args = {
        os.getenv('XDG_DATA_HOME') ..
            '/nvim/nvim-dap-adapters/vscode-js-debug/out/src/vsDebugServer.js'
    }
}

dap.configurations.javascript = {
    {
        type = 'vscode-js-debug',
        request = 'launch',
        program = '${workspaceFolder}/${file}',
        cwd = vim.fn.getcwd(),
        sourceMaps = true,
        protocol = 'inspector',
        console = 'integratedTerminal',
        skipFiles = {'**/node_modules/**', '<node_internals>/**'},
        restart = true
    }
}

-- TODO create new attach config for vscode-js-debug
local attach_vscode_debugger = function()
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
    dap.repl.open()
end

-- Key mappings for nvim-dap debugging
map("n", "<F5>", ":lua require('dap').continue()<CR>");
map('n', "<F9>", ":lua require('dap').toggle_breakpoint()<CR>");
map("n", "<F10>", ":lua require'dap'.step_over()<CR>");
map("n", "<F11>", ":lua require'dap'.step_into()<CR>");
map("n", "<F12>", ":lua require'dap'.step_out()<CR>");
map("n", "<leader>B",
    ":lua require'dap'.set_breakpoint(vim.fn.input('Breakpoint condition: '))<CR>");
map("n", "<leader>lp",
    ":lua require'dap'.set_breakpoint(nil, nil, vim.fn.input('Log point message: '))<CR>");
map("n", "<leader>dr", ":lua require'dap'.repl.open()<CR>");
map("n", "<leader>dl", ":lua require'dap'.run_last()<CR>");
map("n", "<leader>dR", ":lua attach_python_debugger()<CR>");

-- telescope-dap commands and mappings
-- :Telescope dap commands
-- :Telescope dap variables
-- :Telescope dap frames
-- :Telescope dap list_breakpoints
-- :Telescope dap configurations
