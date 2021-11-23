local formatter = require('formatter')

formatter.setup {
    filetype = {
        lua = {function() return {exe = 'lua-format', stdin = true} end},
        python = {
            function()
                return {exe = 'black', args = {'--quiet', '-'}, stdin = true}
            end
        },
        json = {
            function()
                return  {
                            exe = 'prettier', 
                            args = {"--stdin-filepath", 
                                    vim.fn.fnameescape(vim.api.nvim_buf_get_name(0)),
                                    '--config ' .. os.getenv("HOME") .. "/Projects/project_configs/.prettierrc.js"
                                   },
                            stdin = true 
                        }
            end
        }
    }
}
