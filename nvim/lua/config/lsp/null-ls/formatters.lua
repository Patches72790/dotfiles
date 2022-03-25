M = {}

local util = require("config.util")
local null_ls_sources = require("null-ls.sources")
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
		util.warn("Formatting buffer in null-ls", "Formatting")
		vim.lsp.buf.formatting_sync(nil, 2000)
	end
end

function M.has_formatter(filetype)
	local available = null_ls_sources.get_available(filetype, formatting_method)
	return #available > 0
end

function M.list_registered() end

function M.list_supported(filetype)
	local supported = null_ls_sources.get_supported(filetype, "formatting")
	table.sort(supported)
	return supported
end

function M.setup(client, bufnr)
	local filetype = vim.api.nvim_buf_get_option(bufnr, "filetype")

	local enable = false
	if M.has_formatter(filetype) then
		enable = client.name == "null-ls"
	else
		enable = not (client.name == "null-ls")
	end

	--enable = true
	client.resolved_capabilities.document_formatting = enable
	client.resolved_capabilities.document_range_formatting = enable

	if client.resolved_capabilities.document_formatting then
		vim.cmd([[
         augroup LspFormat
             autocmd! * <buffer>
             autocmd BufWritePre <buffer> lua require('config.lsp.null-ls.formatters').format()
         augroup END
         ]])
	end
end

return M
