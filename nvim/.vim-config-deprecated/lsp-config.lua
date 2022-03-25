local vim = vim
local nvim_lsp = require("lspconfig")

local format_async = function(err, _, result, _, bufnr)
    if err ~= nil or result == nil then return end
    if not vim.api.nvim_buf_get_option(bufnr, "modified") then
        local view = vim.fn.winsaveview()
        vim.lsp.util.apply_text_edits(result, bufnr)
        vim.fn.winrestview(view)
        if bufnr == vim.api.nvim_get_current_buf() then
            vim.api.nvim_command("noautocmd :update")
        end
    end
end

vim.lsp.handlers["textDocument/formatting"] = format_async

_G.lsp_organize_imports = function()
    local params = {
        command = "_typescript.organizeImports",
        arguments = {vim.api.nvim_buf_get_name(0)},
        title = ""
    }
    vim.lsp.buf.execute_command(params)
end

local on_attach = function(client, bufnr)
    local buf_map = vim.api.nvim_buf_set_keymap
    vim.cmd("command! LspDef lua vim.lsp.buf.definition()")
    vim.cmd("command! LspFormatting lua vim.lsp.buf.formatting_seq_sync()")
    vim.cmd("command! LspCodeAction lua vim.lsp.buf.code_action()")
    vim.cmd("command! LspHover lua vim.lsp.buf.hover()")
    vim.cmd("command! LspRename lua vim.lsp.buf.rename()")
    vim.cmd("command! LspOrganize lua lsp_organize_imports()")
    vim.cmd("command! LspRefs lua vim.lsp.buf.references()")
    vim.cmd("command! LspTypeDef lua vim.lsp.buf.type_definition()")
    vim.cmd("command! LspImplementation lua vim.lsp.buf.implementation()")
    vim.cmd("command! LspDiagPrev lua vim.lsp.diagnostic.goto_prev()")
    vim.cmd("command! LspDiagNext lua vim.lsp.diagnostic.goto_next()")
    vim.cmd(
        "command! LspDiagLine lua vim.lsp.diagnostic.show_line_diagnostics()")
    vim.cmd("command! LspSignatureHelp lua vim.lsp.buf.signature_help()")buf_map(bufnr, "n", "gd", ":LspDef<CR>", {silent = true})
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


local filetypes = {
    typescript = "eslint",
    typescriptreact = "eslint",
}

local linters = {
    eslint = {
        sourceName = "eslint",
        command = "eslint_d",
        rootPatterns = {".eslintrc.js", "package.json"},
        debounce = 100,
        args = {"--stdin", "--stdin-filename", "%filepath", "--format", "json"},
        parseJson = {
            errorsRoot = "[0].messages",
            line = "line",
            column = "column",
            endLine = "endLine",
            endColumn = "endColumn",
            message = "${message} [${ruleId}]",
            security = "severity"
        }, 
        indent = {"error", 4},
        securities = {[2] = "error", [1] = "warning"}
    }
}

local formatters = {
    prettier = {command = "prettier", args = {"--stdin-filepath", "%filepath"}}
}

local formatFiletypes = {
    typescript = "prettier",
    typescriptreact = "prettier"
}

-- typescript server setup
nvim_lsp.tsserver.setup{
    on_attach = function(client)
        client.resolved_capabilities.document_formatting = false
        on_attach(client)
    end
}

-- diagnostic language server setup
nvim_lsp.diagnosticls.setup {
    on_attach = on_attach,
    filetypes = vim.tbl_keys(filetypes),
    init_options = {
        filetypes = filetypes,
        linters = linters,
        formatters = formatters,
        formatFiletypes = formatFiletypes
    }
}

-- Setup LspInstall language servers
local function setup_servers()
    require('lspinstall').setup()
    local servers = require('lspinstall').installed_servers()
    for _, server in pairs(servers) do
        if server == 'sumneko_lua' then
            require('lspconfig')[server].setup({
                settings = {
                  Lua = {
                    runtime = {
                      version = 'Lua 5.3',
                      path = {
                        '?.lua',
                        '?/init.lua',
                        vim.fn.expand'~/.luarocks/share/lua/5.3/?.lua',
                        vim.fn.expand'~/.luarocks/share/lua/5.3/?/init.lua',
                        '/usr/share/5.3/?.lua',
                        '/usr/share/lua/5.3/?/init.lua'
                      }
                    },
                    workspace = {
                      library = {
                        [vim.fn.expand'~/.luarocks/share/lua/5.3'] = true,
                        ['/usr/share/lua/5.3'] = true
                      }
                    }
                  }
                }
            })
        end
        require('lspconfig')[server].setup{}
    end
end

setup_servers()
require('lspinstall').post_install_hook = function()
    setup_servers()
    vim.cmd('bufdo e')
end

-- Java DT language server
local function start_jdtls()
    local cmd = {'java-lsp.sh'}
    local init_options = {
        bundles = {
            "/home/patroclus/.java-debug/java-debug/com.microsoft.java.debug.plugin/target/com.microsoft.java.debug.plugin-0.32.0.jar"
        }
    }
--    local params = {
--        ["command"] = "vscode.java.startDebugSession";
--    };
--    local on_attach = function(client, bufnr)
--        local result, err = client.request_sync("workspace/executeCommand", params, nil, bufnr)
--        if result then _G.test_result = result end
--        vim.api.nvim_exec("[[ call vimspector#LaunchWithSettings({ 'DAPPort': result })]]", true);
--    end

    require('lspconfig').jdtls.setup{ cmd = cmd, init_options = init_options }
end

start_jdtls()


-- miscellaneous ui customization
-- show box when cursor is over diagnostic
vim.o.updatetime = 250
vim.cmd [[autocmd CursorHold,CursorHoldI * lua vim.lsp.diagnostic.show_line_diagnostics({focusable=false})]]

require('nvim-web-devicons').setup{}
