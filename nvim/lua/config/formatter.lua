local formatter = require('formatter')

formatter.setup {
    filetype = {
        lua = {function() return {exe = 'lua-format', stdin = true} end}
    }
}
