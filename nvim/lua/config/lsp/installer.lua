local M = {}

local ensure_installed_servers = {
	"rnix",
	"pyright",
	"rust_analyzer",
	"ts_ls",
	"lua_ls",
	"yamlls",
	"gopls",
	"yamlls",
	"bashls",
	"clangd",
	"dockerls",
	"terraformls",
	"eslint",
	"hls",
	"jdtls",
}

function M.setup(options)
	local lsp_installer = require("mason-lspconfig")
	local mason = require("mason")

	mason.setup({
		ui = {
			icons = {
				server_installed = "✓",
				server_pending = "➜",
				server_uninstalled = "✗",
			},
		},
	})

	lsp_installer.setup({
		automatic_enable = true,
		ensure_installed = ensure_installed_servers,
	})

	--for _, server in pairs(ensure_installed_servers) do
	--	vim.lsp.enable(server)
	--end

	vim.lsp.config("*", options)

	require("config.lsp.conform").setup()
end

return M
