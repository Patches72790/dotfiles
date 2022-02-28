local formatter = require('formatter')

formatter.setup {
    filetype = {
        lua = {function() return {exe = 'lua-format', stdin = true} end},
        python = {
            function()
                return { exe = 'darker',
                         args = { '--quiet',
                                  '--stdout',
                                  '--isort',
                                  vim.fn.fnameescape(vim.api.nvim_buf_get_name(0))},
                                  stdin = true }
                --return {exe = 'black', args = {'--quiet', '-'}, stdin = true}
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
        },
        html = {
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
        },
        typescriptreact = {
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
        },
        typescript = {
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
        },
        javascript = {
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
        },
        javascriptreact = {
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
        },
    }
}
