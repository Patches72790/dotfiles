M = {}

local formatting_method = require('null-ls').methods.FORMATTING

function M.setup(client, bufnr)
    local filetype = vim.api.nvim_buf_get_option(bufnr, 'filetype')

    if client.resolved_capabilities.document_formatting then
        vim.api.nvim_exec([[
         augroup LspAutocommands
             autocmd! * <buffer>
             autocmd BufWritePost <buffer> LspFormatting
         augroup END
         ]], true)
    end
end


return M
