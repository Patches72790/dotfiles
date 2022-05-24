local M = {}

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
	rust_analyzer = function(options)
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
			-- add the custom on_attach and resolved_capabilities from lsp/init.lua
			server = vim.tbl_deep_extend("force", options, {
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
	clangd = function() -- C, C++, etc.
		return {}
	end,
	vimls = function() -- vimscript
		return {}
	end,
	gopls = function() -- Go
		return {}
	end,
	hls = function(opts) -- haskell
		local enhanced_opts = {}
		enhanced_opts.on_attach = function(client, bufnr)
			client.resolved_capabilities.document_formatting = true
			client.resolved_capabilities.document_range_formatting = true
			vim.api.nvim_create_autocmd({ "BufWritePre" }, {
				group = "LspFormatting",
				desc = "Format on save for haskell language server",
				pattern = { "*.hs" },
				callback = function()
					vim.lsp.buf.formatting_sync(nil, 2000)
				end,
			})
			opts.on_attach(client, bufnr)
		end
		return enhanced_opts
	end,
	dockerls = function()
		return {}
	end,
	awk_ls = function()
		return {}
	end,
}

function M.setup(options)
	local lsp_installer = require("nvim-lsp-installer")
	local lsp_config = require("lspconfig")

	-- per https://github.com/williamboman/nvim-lsp-installer/discussions/636
	-- server:setup no longer used
	lsp_installer.setup({
		ensure_installed = vim.tbl_keys(servers),
		automatic_installation = true,
		ui = {
			icons = {
				server_installed = "✓",
				server_pending = "➜",
				server_uninstalled = "✗",
			},
		},
	})

	-- use lspconfig for server setup
	for server_name, enhanced_setup_opts_func in pairs(servers) do
		local enhanced_server_opts = enhanced_setup_opts_func(options)
		if server_name == "rust_analyzer" then
			require("rust-tools").setup(enhanced_server_opts)
		else
			local server_opts = vim.tbl_deep_extend("force", options, enhanced_server_opts)
			lsp_config[server_name].setup(server_opts)
		end
	end
end

return M
