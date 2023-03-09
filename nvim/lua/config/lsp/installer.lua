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
local server_handlers = {
	["lua_ls"] = function(opts)
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
	hls = function(opts) -- haskell
		local enhanced_opts = {}
		enhanced_opts.on_attach = make_formatting_on_attach("Format on save for haskell language server", opts)
		return enhanced_opts
	end,
	jdtls = function(opts)
		local enhanced_opts = {}
		enhanced_opts.on_attach = make_formatting_on_attach("Format on save for jdtls", opts)
		return enhanced_opts
	end,
}

-- Add additional configuration for servers into server handlers table
-- other servers are setup by default
local setup_handlers = function(options)
	local lspconfig = require("lspconfig")
	return {
		-- default handler
		function(server_name)
			lspconfig[server_name].setup(options)
		end,
		["rust_analyzer"] = function()
			local server_opts = server_handlers["rust_analyzer"](options)
			require("rust-tools").setup(server_opts)
		end,
		["tsserver"] = function()
			local server_opts = server_handlers["tsserver"](options)
			lspconfig["tsserver"].setup(server_opts)
		end,
		["lua_ls"] = function()
			local server_opts = server_handlers["lua_ls"](options)
			lspconfig["lua_ls"].setup(server_opts)
		end,
		["hls"] = function()
			local server_opts = server_handlers["hls"](options)
			lspconfig["hls"].setup(server_opts)
		end,
		["yamlls"] = function()
			local server_opts = server_handlers["yamlls"](options)
			lspconfig["yamlls"].setup(server_opts)
		end,
		["jdtls"] = function()
			local server_opts = server_handlers["jdtls"](options)
			lspconfig["jdtls"].setup(server_opts)
		end,
	}
end

local ensure_installed_servers = {
	"rust_analyzer",
	"tsserver",
	"lua_ls",
	"hls",
	"yamlls",
	"jdtls",
	"gopls",
	"yamlls",
	"bashls",
	"clangd",
	"dockerls",
	"terraformls",
}

function M.setup(options)
	local lsp_installer = require("mason-lspconfig")
	local mason = require("mason")

	lsp_installer.setup({
		automatic_installation = true,
		ensure_installed = ensure_installed_servers,
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

	-- auto setup server handlers
	lsp_installer.setup_handlers(setup_handlers(options))

	-- initializes null ls directly
	require("config.lsp.null-ls").setup()
	require("mason-null-ls").setup({
		ensure_installed = nil,
		automatic_installation = true,
		automatic_setup = false,
	})
end

return M
