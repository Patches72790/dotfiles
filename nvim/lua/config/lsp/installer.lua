local M = {}

local make_formatting_on_attach = function(desc, opts)
	return function(client, bufnr)
		client.server_capabilities.documentFormattingProvider = true
		client.server_capabilities.documentRangeFormattingProvider = true
		vim.api.nvim_create_autocmd({ "BufWritePre" }, {
			group = "LspFormatting",
			desc = desc,
			buffer = bufnr,
			callback = function()
				vim.lsp.buf.format({ bufnr = bufnr })
			end,
		})
		opts.on_attach(client, bufnr)
	end
end

-- server options to be used in setup function for lsp_installer
local servers = {
	["sumneko_lua"] = function(opts)
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
				diagnostics = { globals = { "vim", "require" } },
				workspace = {
					library = {
						[vim.fn.expand("~/.luarocks/share/lua/5.3")] = true,
						["/usr/share/lua/5.3"] = true,
					},
					checkThirdParty = false,
				},
			},
		}
		default_opts.on_attach = function(client, bufnr)
			client.server_capabilities.documentFormattingProvider = false
			client.server_capabilities.documentRangeFormattingProvider = false
			opts.on_attach(client, bufnr)
		end
		return default_opts
	end,
	["tsserver"] = function(opts)
		local enhanced_opts = {}
		enhanced_opts.on_attach = function(client, bufnr)
			client.server_capabilities.documentFormattingProvider = false
			client.server_capabilities.documentRangeFormattingProvider = false
			opts.on_attach(client, bufnr)
		end
		return enhanced_opts
	end,
	yamlls = function(opts)
		local enhanced_opts = {}
		enhanced_opts.on_attach = make_formatting_on_attach("Formatting command for yaml files", opts)
		return enhanced_opts
	end,
	cssls = function()
		return {}
	end,
	["pyright"] = function(_)
		return {}
	end,
	-- other language servers
	bashls = function()
		return {}
	end,
	rust_analyzer_rust_tools = function(options)
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
				adapter = require("rust-tools.dap").get_codelldb_adapter(codelldb_path, liblldb_path),
				--adapter = {
				--	type = "executable",
				--	command = "lldb-vscode-13",
				--	name = "rt_lldb",
				--},
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
		enhanced_opts.on_attach = make_formatting_on_attach("Format on save for haskell language server", opts)
		return enhanced_opts
	end,
	dockerls = function()
		return {}
	end,
	awk_ls = function()
		return {}
	end,
	jdtls = function()
		return {}
	end,
	rnix = function()
		return {}
	end,
	ltex = function()
		return {}
	end,
}

function M.setup(options)
	local lsp_installer = require("mason-lspconfig")
	local mason = require("mason")
	local lsp_config = require("lspconfig")

	lsp_installer.setup({
		ensure_installed = vim.tbl_keys(servers),
		automatic_installation = true,
	})

	mason.setup({
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
		if server_name == "rust_analyzer_rust_tools" then
			require("rust-tools").setup(enhanced_server_opts)
		else
			local server_opts = vim.tbl_deep_extend("force", options, enhanced_server_opts)
			lsp_config[server_name].setup(server_opts)
		end
	end
end

return M
