local M = {}

function M.setup(_)
    require('dap-python').setup("python", {})
    require('dap-python').test_runner = 'pytest'
end

return M
