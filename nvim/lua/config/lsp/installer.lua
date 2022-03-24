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
        local server_is_found, server = lsp_installer.get_server(server_name)
        if server_is_found and not server:is_installed() then
            print("Installing " .. name)
            server:install()
        else
            local msg = "Server " .. server.name .. " not available"
            vim.notify(msg, vim.log.levels.ERROR, { title = "Server" })
        end
    end

    lsp_installer.on_server_ready(function(server)
        -- extend options with any language specific options
        local enhanced_server_opts = servers[server.name] 
                                     and servers[server.name](options) or {}
        local opts = vim.tbl_deep_extend("force", options, enhanced_server_opts)
        -- setup server
        server:setup(opts)
    end)
end

return M
