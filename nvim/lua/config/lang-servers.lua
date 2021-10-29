local autocmd = require('config.util').autocmd

local M = {}

local on_attach = function(client, bufnr)
    local buf_map = vim.api.nvim_buf_set_keymap
    vim.cmd("command! LspDef lua vim.lsp.buf.definition()")
    vim.cmd("command! LspFormatting lua vim.lsp.buf.formatting_seq_sync()")
    vim.cmd("command! LspCodeAction lua vim.lsp.buf.code_action()")
    vim.cmd("command! LspHover lua vim.lsp.buf.hover()")
    vim.cmd("command! LspRename lua vim.lsp.buf.rename()")
    vim.cmd("command! LspRefs lua vim.lsp.buf.references()")
    vim.cmd("command! LspTypeDef lua vim.lsp.buf.type_definition()")
    vim.cmd("command! LspImplementation lua vim.lsp.buf.implementation()")
    vim.cmd("command! LspDiagPrev lua vim.lsp.diagnostic.goto_prev()")
    vim.cmd("command! LspDiagNext lua vim.lsp.diagnostic.goto_next()")
    vim.cmd(
        "command! LspDiagLine lua vim.lsp.diagnostic.show_line_diagnostics()")
    vim.cmd("command! LspSignatureHelp lua vim.lsp.buf.signature_help()")

    buf_map(bufnr, "n", "gd", ":LspDef<CR>", {silent = true})
    buf_map(bufnr, "n", "gr", ":LspRename<CR>", {silent = true})
    buf_map(bufnr, "n", "gR", ":LspRefs<CR>", {silent = true})
    buf_map(bufnr, "n", "gy", ":LspTypeDef<CR>", {silent = true})
    buf_map(bufnr, "n", "K", ":LspHover<CR>", {silent = true})
    buf_map(bufnr, "n", "gs", ":LspOrganize<CR>", {silent = true})
    buf_map(bufnr, "n", "[a", ":LspDiagPrev<CR>", {silent = true})
    buf_map(bufnr, "n", "]a", ":LspDiagNext<CR>", {silent = true})
    buf_map(bufnr, "n", "ga", ":LspCodeAction<CR>", {silent = true})
    buf_map(bufnr, "n", "<Leader>a", ":LspDiagLine<CR>", {silent = true})
    buf_map(bufnr, "i", "<C-x><C-x>", "<cmd> LspSignatureHelp<CR>",
            {silent = true})

    if client.resolved_capabilities.document_formatting then
        vim.api.nvim_exec([[
         augroup LspAutocommands
             autocmd! * <buffer>
             autocmd BufWritePost <buffer> LspFormatting
         augroup END
         ]], true)
    end
end

-- config that activates keymaps and enables snippet support
function M.make_config()
    local capabilities = vim.lsp.protocol.make_client_capabilities()
    capabilities.textDocument.completion.completionItem.snippetSupport = true
    return {
        -- enable snippet support
        capabilities = capabilities,
        -- map buffer local keybindings when the language server attaches
        on_attach = on_attach
    }
end

-- server options to be used in setup function for lsp_installer
M.server_opts = {
    ['sumneko_lua'] = function()
        local default_opts = M.make_config()
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
        local default_opts = M.make_config()
        default_opts.on_attach = function(client, bufnr)
            autocmd('EsLintCmd', [[ BufWritePost <buffer> EslintFixAll ]])
            on_attach(client, bufnr)
        end
        return default_opts
    end,
    ['tsserver'] = function()
        local default_opts = M.make_config()
        default_opts.on_attach = function(client, bufnr)
            client.resolved_capabilities.document_formatting = false
            on_attach(client, bufnr)
        end
        return default_opts
    end,
    ['diagnosticls'] = function()
        local default_opts = M.make_config()
        local diagls_opts = require('config.diagnosticls')
        default_opts.filetypes = vim.tbl_keys(diagls_opts.filetypes)
        default_opts.init_options = {
            filetypes = diagls_opts.filetypes,
            linters = diagls_opts.linters,
            formatters = diagls_opts.formatters,
            formatFiletypes = diagls_opts.formatFiletypes
        }
        default_opts.on_attach = function(client, bufnr)
            client.resolved_capabilities.document_formatting = false
            on_attach(client, bufnr)
        end
        return default_opts
    end,
}

return M
