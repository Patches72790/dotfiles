local M = {}
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
	--["eslint"] = function(opts)
	--	local enhanced_opts = {}
	--	enhanced_opts.on_attach = function(client, bufnr)
	--		client.resolved_capabilities.document_formatting = false
	--		client.resolved_capabilities.document_range_formatting = false
	--	end
	--	return enhanced_opts
	--end,
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
	rust_analyzer = function(options, server)
		local extension_path = vim.env.HOME .. "/.vscode/extensions/vadimcn.vscode-lldb-1.7.0/"
		local codelldb_path = extension_path .. "adapter/codelldb"
		local liblldb_path = extension_path .. "lldb/lib/liblldb.so"

		local rust_opts = {
			tools = {
				autoSetHints = true,
				hover_with_actions = false,
				inlay_hints = {
					show_parameter_hints = true,
					parameter_hints_prefix = "",
					other_hints_prefix = "",
				},
			},
			server = vim.tbl_deep_extend("force", options, server:get_default_options(), {
				settings = {
					["rust-analyzer"] = {
						completion = {
							postfix = {
								enable = false,
							},
						},
						checkOnSave = {
							command = "clippy",
						},
					},
				},
			}),
			dap = {
				--adapter = require("rust-tools.dap").get_codelldb_adapter(codelldb_path, liblldb_path),
				adapter = {
					type = "executable",
					command = "lldb-vscode-13",
					name = "rt_lldb",
				},
			},
		}
		return rust_opts
	end,
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
		local enhanced_server_opts = servers[server.name] and servers[server.name](options, server) or {}
		if server.name == "rust_analyzer" then
			require("rust-tools").setup(enhanced_server_opts)
			server:attach_buffers()
		else
			local opts = vim.tbl_deep_extend("force", options, enhanced_server_opts)
			-- setup server
			server:setup(opts)
		end
	end)
end

return M
