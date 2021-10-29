local formatter = require('formatter')

formatter.setup{
    filetype = {
        lua = {
            function()
                return {
                    exe = 'luafmt',
                    args = {'--indent-count', 2, '--stdin'},
                    stdin = true
                }
            end
        }
    }
}
