local M = {}

-- server options to be used in setup function for lsp_installer
local server_handlers = {
	lua_ls = function()
		return {
			settings = {
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
					telemetry = {
						enable = false,
					},
				},
			},
		}
	end,
	yamlls = function()
		return {
			settings = {
				yaml = {
					schemas = {
						["https://gitlab.com/gitlab-org/gitlab/-/raw/master/app/assets/javascripts/editor/schema/ci.json"] = "/gitlab-ci.yml",
					},
					format = {
						enable = true,
					},
					hover = true,
				},
			},
		}
	end,
	rust_analyzer = function(options)
		return {
			-- add the custom on_attach and resolved_capabilities from lsp/init.lua
			server = vim.tbl_deep_extend("force", options, {
				default_settings = {
					["rust-analyzer"] = {
						check = {
							command = "clippy",
						},
					},
				},
			}),
		}
	end,
	jdtls = function()
		return {
			settings = {
				java = {
					format = {
						enabled = true,
					},
					saveActions = {
						organizeImports = true,
					},
					import = {
						maven = {
							enabled = true,
						},
					},
				},
			},
		}
	end,
	terraformls = function()
		return {
			init_options = {
				terraform = {
					path = "/opt/homebrew/bin/terraform",
				},
			},
		}
	end,
}

-- Fetches the appropriate server handler options and merges with default options
-- If server name doesn't exist in table, the just return base options
local server_handlers_fn = function(server_name, options)
	local server_handler = server_handlers[server_name]
	if server_handler ~= nil then
		local more_opts = vim.tbl_deep_extend("force", {}, options, server_handler(options))
		--P(more_opts)
		return more_opts
	end

	return options
end

-- Add additional configuration for servers into server handlers table
-- other servers are setup by default
local setup_handlers = function(options)
	local lspconfig = require("lspconfig")
	return {
		-- default handler
		function(server_name)
			lspconfig[server_name].setup(options)
		end,
		["terraformls"] = function()
			local server_opts = server_handlers_fn("terraformls", options)
			lspconfig["terraformls"].setup(server_opts)
			vim.api.nvim_create_autocmd({ "BufWritePre" }, {
				desc = "Terraform-ls format on save",
				group = vim.api.nvim_create_augroup("terraform-ls-format", { clear = true }),
				pattern = { "*.tf", "*.tfvars" },
				callback = function()
					vim.lsp.buf.format()
				end,
			})
		end,

		["rust_analyzer"] = function()
			-- rust analyzer uses rust-tools, which handles lsp settings on its own
			--local server_opts = server_handlers["rust_analyzer"](options)
			--require("rust-tools").setup(server_opts)
			vim.g.rustaceanvim = function()
				return server_handlers["rust_analyzer"](options)
			end
		end,
		["jdtls"] = function()
			local server_opts = server_handlers_fn("jdtls", options)
			lspconfig["jdtls"].setup(server_opts)
			-- TODO add support for nvim_jdtls here and use their method instead of default lsp
			--local server_opts = server_handlers["jdtls"](options)
			--require("jdtls").start_or_attach(server_opts)
		end,
		["lua_ls"] = function()
			local server_opts = server_handlers_fn("lua_ls", options)
			require("neodev").setup()
			lspconfig["lua_ls"].setup(server_opts)
		end,
		["yamlls"] = function()
			local server_opts = server_handlers_fn("yamlls", options)
			lspconfig["yamlls"].setup(server_opts)
		end,
	}
end

local ensure_installed_servers = {
	"rust_analyzer",
	"tsserver",
	"lua_ls",
	"yamlls",
	"jdtls",
	"gopls",
	"yamlls",
	"bashls",
	"clangd",
	"dockerls",
	"terraformls",
	"hls",
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
		automatic_installation = true,
		ensure_installed = ensure_installed_servers,
	})

	-- setup lsp servers - must be called AFTER mason and mason-lspconfig setup
	lsp_installer.setup_handlers(setup_handlers(options))

	require("config.lsp.conform").setup()
end

return M
