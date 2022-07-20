local M = {}

local whichkey = require("which-key")
local keymap = vim.api.nvim_set_keymap
local buf_keymap = vim.api.nvim_buf_set_keymap
local create_user_command = vim.api.nvim_create_user_command

local function keymappings(client, bufnr)
	local opts = { noremap = true, silent = true }

	-- lsp hover
	buf_keymap(bufnr, "n", "K", "<cmd>lua vim.lsp.buf.hover()<CR>", opts)

	-- lsp diagnostics gotos
	create_user_command(
		"LspDiagPrev",
		"lua vim.diagnostic.goto_prev()",
		{ desc = "Go to the previous lsp diagnostic from cursor" }
	)
	create_user_command("LspDiagNext", "lua vim.diagnostic.goto_next()", {
		desc = "Go to the next lsp diagnostic from cursor",
	})
	keymap("n", "[a", ":LspDiagPrev<CR>", opts)
	keymap("n", "]a", ":LspDiagNext<CR>", opts)

	-- <leader> + l + [key]
	local keymap_l = {
		l = {
			name = "Code",
			R = { "<cmd>Telescope lsp_references<CR>", "References" },
			a = { "<cmd>Telescope lsp_code_actions<CR>", "Code Action" },
			n = { "<cmd>lua vim.lsp.buf.rename()<CR>", "Rename" },
			i = { "<cmd>LspInfo <CR>", "Lsp Info" },
			d = { "<cmd>Telescope diagnostics bufnr=0<CR>", "Diagnostics" },
			s = { "<cmd>Telescope lsp_document_symbols<CR>", "Document Symbols" },
			t = { "<cmd>TroubleToggle<CR>", "Trouble" },
		},
	}

	if client.resolved_capabilities.document_formatting then
		create_user_command("LspFormat", "lua vim.lsp.buf.formatting_sync(nil, 2000)", {})
		keymap_l.l.F = { "<cmd>:LspFormat<CR>", "LspFormat" }
	end

	-- utilities <leader> + u + [key]
	local keymap_u = {
		u = {
			name = "Utilities",
			t = { "<cmd> lua require('config.lsp.null-ls.formatters').toggle()<CR>", "Toggle Auto Format" },
		},
	}

	-- Gotos g + [key]
	local keymap_g = {
		name = "Goto",
		d = { "<cmd>Telescope lsp_definitions<CR>", "Definition" },
		D = { "<cmd>lua vim.lsp.buf.declaration()<CR>", "Declaration" },
		s = { "<cmd>lua vim.lsp.buf.signature_help()<CR>", "Signature Help" },
		I = { "<cmd>Telescope lsp_implementations<CR>", "Goto Implementation" },
		t = { "<cmd>Telescope lsp_type_definitions<CR>", "Goto Type Definition" },
	}

	-- register which key keymaps
	whichkey.register(keymap_l, { buffer = bufnr, prefix = "<leader>" })
	whichkey.register(keymap_g, { buffer = bufnr, prefix = "g" })
	whichkey.register(keymap_u, { buffer = bufnr, prefix = "<leader>" })
end

-- Setup the keymappings for client and bufnr
function M.setup(client, bufnr)
	keymappings(client, bufnr)
end

return M
