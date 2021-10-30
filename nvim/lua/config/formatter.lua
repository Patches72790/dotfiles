local formatter = require('formatter')

formatter.setup {
    filetype = {
        lua = {function() return {exe = 'lua-format', stdin = true} end},
        python = {
            function()
                return {exe = 'black', args = {'--quiet', '-'}, stdin = true}
            end
        }
    }
}
