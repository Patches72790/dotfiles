M = {}

local util = require('config.util')
local null_ls_sources = require('null-ls.sources')
local formatting_method = require("null-ls").methods.FORMATTING

M.autoformat = true

function M.toggle()
    M.autoformat = not M.autoformat
    if M.autoformat then
        util.info("Enabled format on save", "Formatting")
    else
        util.info("Disabled format on save", "Formatting")
    end
end

function M.format()
    if M.autoformat then
        vim.lsp.buf.formatting_seq_sync(nil, 2000)
    end
end

function M.has_formatter(filetype)
    local available = null_ls_sources.get_available(filetype, formatting_method)
    return #available > 0
end

function M.list_registered()
end

function M.list_supported()
end

function M.setup(client, bufnr)
	local filetype = vim.api.nvim_buf_get_option(bufnr, "filetype")

    local enable = false
    if M.has_formatter(filetype) then
        enable = client.name == 'null-ls'
    else
        enable = not (client.name == 'null-ls')
    end

    client.resolved_capabilities.document_formatting = enable
    client.resolved_capabilities.document_range_formatting = enable

	if client.resolved_capabilities.document_formatting then
		vim.api.nvim_exec(
			[[
         augroup LspAutocommands
             autocmd! * <buffer>
             autocmd BufWritePost <buffer> LspFormatting
         augroup END
         ]],
			true
		)
	end
end

return M
