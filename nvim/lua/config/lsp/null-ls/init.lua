local M = {}

local null_ls = require('null-ls')


function M.setup()
    null_ls.setup ({
        sources = {
            null_ls.builtins.formatting.black,
            null_ls.builtins.formatting.prettier.with({
                filetypes = {'html', 'json', 'yaml', 'markdown'},
                prefer_local = 'node_modules/.bin'
            })
        }
    })
end

return M
