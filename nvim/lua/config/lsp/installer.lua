local M = {}
local lsp_installer_servers = require('nvim-lsp-installer.servers')
local lsp_installer = require('nvim-lsp-installer')

-- server options to be used in setup function for lsp_installer
local servers = {
    ['sumneko_lua'] = function()
        local default_opts = {}
        default_opts.settings = {
            Lua = {
                runtime = {
                    version = 'LuaJIT',
                    path = {
                        '?.lua', '?/init.lua',
                        vim.fn.expand '~/.luarocks/share/lua/5.3/?.lua',
                        vim.fn.expand '~/.luarocks/share/lua/5.3/?/init.lua',
                        '/usr/share/5.3/?.lua', '/usr/share/lua/5.3/?/init.lua'
                    }
                },
                diagnostics = {globals = {'vim'}},
                workspace = {
                    library = {
                        [vim.fn.expand '~/.luarocks/share/lua/5.3'] = true,
                        ['/usr/share/lua/5.3'] = true
                    },
                    checkThirdParty = false
                }
            }
        }
        return default_opts
    end,
    ['eslint'] = function()
        local default_opts = {}
        --default_opts.on_attach = function(client, bufnr)
        --    autocmd('EsLintCmd', [[ BufWritePost <buffer> EslintFixAll ]])
        --    on_attach(client, bufnr)
        --end
        default_opts.filetypes = {
            'javascriptreact', 'javascript', 'typescript', 'typescriptreact'
        }
        return default_opts
    end,
    ['tsserver'] = function()
        local default_opts = {}
        --default_opts.on_attach = function(client, bufnr)
        --    client.resolved_capabilities.document_formatting = false
        --    on_attach(client, bufnr)
        --end
        return default_opts
    end,
    ['pyright'] = function()
        local default_opts = {}
        --default_opts.on_attach = function(client, bufnr)
        --    client.resolved_capabilities.document_formatting = false
        --    on_attach(client, bufnr)
        --end
        return default_opts
    end,

    -- other language servers
    bashls = function ()
        return {}
    end,
    jdtls = function()
        return {}
    end,
    rust_analyzer = function()
        return {}
    end,
    clangd = function ()
        return {}
    end,
    vimls = function ()
        return {}
    end,
    gopls = function ()
        return {}
    end
}

function M.setup(options)
    -- Provide settings first!
    lsp_installer.settings {
        ui = {
            icons = {
                server_installed = "✓",
                server_pending = "➜",
                server_uninstalled = "✗"
            }
        }
    }

    for server_name, _ in pairs(servers) do
        local server_ok, server = lsp_installer_servers.get_server(name)
        if server_ok then
            lsp_installer.on_server_ready(function()

                -- extend options with any language specific options
                local opts = vim.tbl_deep_extend("force", options,
                    servers[server.name] and server[server.name](options) or {})

                -- setup server
                server:setup(opts)

            end)
            -- install if not installed
           if not server:is_installed() then
               print("Installing " .. name)
               server:install()
           end
        else
            msg = "Server " .. server .. " not available"
            vim.notify(msg, vim.log.levels.ERROR, { title = "Server" })
        end
    end
end

return M
