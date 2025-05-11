local M = {}

-- To instead override globally
local orig_util_open_floating_preview = vim.lsp.util.open_floating_preview
function vim.lsp.util.open_floating_preview(contents, syntax, opts, ...)
	opts = vim.tbl_deep_extend("force", opts, { border = "rounded" })
	return orig_util_open_floating_preview(contents, syntax, opts, ...)
end

function M.setup()
	-- Define the on attach handler
	vim.api.nvim_create_autocmd("LspAttach", {
		group = vim.api.nvim_create_augroup("lsp-attach", { clear = true }),
		callback = function(event)
			vim.diagnostic.config({
				underline = true,
				virtual_text = true,
				float = {
					border = "rounded",
					severity_sort = true,
					source = true,
				},
			})

			local map = function(keys, func, desc)
				vim.keymap.set("n", keys, func, { buffer = event.buf, desc = "LSP: " .. desc })
			end

			map("gd", require("telescope.builtin").lsp_definitions, "[G]oto [D]efinition")
			map("gr", require("telescope.builtin").lsp_references, "[G]oto [R]eferences")
			map("gI", require("telescope.builtin").lsp_implementations, "[G]oto [I]mplementation")
			map("<leader>D", require("telescope.builtin").lsp_type_definitions, "Type [D]efinition")
			map("<leader>ds", require("telescope.builtin").lsp_document_symbols, "[D]ocument [S]ymbols")
			map("<leader>ws", require("telescope.builtin").lsp_dynamic_workspace_symbols, "[W]orkspace [S]ymbols")
			map("<leader>rn", vim.lsp.buf.rename, "[R]e[n]ame")
			map("<leader>ca", vim.lsp.buf.code_action, "[C]ode [A]ction")
			map("K", vim.lsp.buf.hover, "Hover Documentation")
			map("gD", vim.lsp.buf.declaration, "[G]oto [D]eclaration")
		end,
	})

	local capabilities = vim.lsp.protocol.make_client_capabilities()
	-- blink merges the capabilities
	capabilities = require("blink.cmp").get_lsp_capabilities(capabilities, true)

	local opts = {
		capabilities = capabilities,
		flags = {
			debounce_text_changes = 150,
		},
	}

	require("config.lsp.installer").setup(opts)
	require("config.dap").setup()
end

return M
