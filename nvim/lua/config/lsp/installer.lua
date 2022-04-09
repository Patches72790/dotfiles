local M = {}
local autocmd = require("config.util").autocmd
local lsp_installer = require("nvim-lsp-installer")

-- server options to be used in setup function for lsp_installer
local servers = {
	["sumneko_lua"] = function(_)
		local default_opts = {}
		default_opts.settings = {
			Lua = {
				runtime = {
					version = "LuaJIT",
					path = {
						"?.lua",
						"?/init.lua",
						vim.fn.expand("~/.luarocks/share/lua/5.3/?.lua"),
						vim.fn.expand("~/.luarocks/share/lua/5.3/?/init.lua"),
						"/usr/share/5.3/?.lua",
						"/usr/share/lua/5.3/?/init.lua",
					},
				},
				diagnostics = { globals = { "vim" } },
				workspace = {
					library = {
						[vim.fn.expand("~/.luarocks/share/lua/5.3")] = true,
						["/usr/share/lua/5.3"] = true,
					},
					checkThirdParty = false,
				},
			},
		}
		return default_opts
	end,
	["eslint"] = function(opts)
		local enhanced_opts = {}
		enhanced_opts.on_attach = function(client, bufnr)
			client.resolved_capabilities.document_formatting = false
			client.resolved_capabilities.document_range_formatting = false
		end
		return enhanced_opts
	end,
	["tsserver"] = function(opts)
		local enhanced_opts = {}
		enhanced_opts.on_attach = function(client, bufnr)
			client.resolved_capabilities.document_formatting = false
			client.resolved_capabilities.document_range_formatting = false
			opts.on_attach(client, bufnr)
		end
		return enhanced_opts
	end,
	["pyright"] = function(_)
		return {}
	end,

	-- other language servers
	bashls = function()
		return {}
	end,
	jdtls = function()
		return {}
	end,
	--rust_analyzer = function()
	--	return {}
	--end,
	clangd = function()
		return {}
	end,
	vimls = function()
		return {}
	end,
	gopls = function() -- Go
		return {}
	end,
	hls = function() -- haskell
		return {}
	end,
}

function M.setup(options)
	-- Provide settings first!
	lsp_installer.settings({
		ui = {
			icons = {
				server_installed = "✓",
				server_pending = "➜",
				server_uninstalled = "✗",
			},
		},
	})

	for server_name, _ in pairs(servers) do
		local server_is_found, server = lsp_installer.get_server(server_name)
		if server_is_found and not server:is_installed() then
			print("Installing " .. server_name)
			server:install()
		end
	end

	lsp_installer.on_server_ready(function(server)
		-- extend options with any language specific options
		local enhanced_server_opts = servers[server.name] and servers[server.name](options) or {}
		local opts = vim.tbl_deep_extend("force", options, enhanced_server_opts)
		-- setup server
		server:setup(opts)
	end)

	-- rust uses rust-tools.nvim
	require("rust-tools").setup({
		dap = {
			adapter = {
				type = "executable",
				command = "lldb-vscode-13",
				name = "rt_lldb",
			},
		},
	})
end

return M
