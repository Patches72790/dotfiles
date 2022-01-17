local dap = require('dap');
local map = require('config.util').map;

dap.adapters.python = {
    type = 'executable',
    command = os.getenv('PYHTON_CONDA_EXE'), 
    args = {'-m', 'debugpy.adapter'}
}

dap.configurations.python = {
    {
        type = 'server',
        request = 'attach',
        name = 'Attach',
        program = "${file}",
        pythonPath = function()
            return os.getenv("PYHTON_CONDA_EXE")
        end,
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

-- sign definitions
vim.fn.sign_define('DapBreakpoint', {text='🟥', texthl='', linehl='', numhl=''})
vim.fn.sign_define('DapBreakpointRejected', {text='🟦', texthl='', linehl='', numhl=''})
vim.fn.sign_define('DapStopped', {text='⭐️', texthl='', linehl='', numhl=''})

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
map("n", "<leader>dR", ":lua require('config.nvim-dap-config').attach_python_debugger()<CR>");

-- mapping for nvim-dap-ui
map("n", "<F24>", ":lua require('dapui').toggle()<CR>")

-- telescope-dap commands and mappings
-- :Telescope dap commands
-- :Telescope dap variables
-- :Telescope dap frames
-- :Telescope dap list_breakpoints
-- :Telescope dap configurations
