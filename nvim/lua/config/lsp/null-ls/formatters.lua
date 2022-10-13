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
		vim.lsp.buf.format()
	end
end

function M.has_formatter(filetype)
	local available = null_ls_sources.get_available(filetype, formatting_method)
	return #available > 0
end

-- Enables formatting for buffer according to whether
-- Null-Ls is enabled for given filetype or the native LSP
-- has its own formatting method
function M.setup(client, bufnr)
	local filetype = vim.api.nvim_buf_get_option(bufnr, "filetype")

	local enable = false
	if M.has_formatter(filetype) then
		enable = client.name == "null-ls"
	else
		enable = not (client.name == "null-ls")
	end

	client.server_capabilities.documentFormattingProvider = enable
	client.server_capabilities.documentRangeFormattingProvider = enable
end

return M
