local vim = vim
local nvim_lsp = require("lspconfig")
local lsp_installer = require('nvim-lsp-installer')

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

-- let telescope use this LSP stuff
vim.lsp.handlers["textDocument/formatting"] = format_async
vim.lsp.handlers["textDocument/references"] = require('telescope.builtin').lsp_references;
vim.lsp.handlers["textDocument/definition"] = require('telescope.builtin').lsp_definitions;

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
    vim.cmd("command! LspDiagLine lua vim.lsp.diagnostic.show_line_diagnostics()")
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
    buf_map(bufnr, "i", "<C-x><C-x>", "<cmd> LspSignatureHelp<CR>", {silent = true})

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
    javascript = "eslint",
    javascriptreact = "eslint",
    python = "pylint",
}

local linters = {
    eslint = {
        sourceName = "eslint",
        command = "./node_modules/.bin/eslint",
        rootPatterns = {".eslintrc.js", ".eslintrc.json", "package.json"},
        debounce = 100,
        args = {"--stdin", "--stdin-filename", "%filepath"},
        parseJson = {
            errorsRoot = "[0].messages",
            line = "line",
            column = "column",
            endLine = "endLine",
            endColumn = "endColumn",
            message = "${message} [${ruleId}]",
            security = "severity"
        },
        indent = {"error", 2},
        securities = {[2] = "error", [1] = "warning"}
    },
    pylint = {
        sourceName = "pylint",
        command = "pylint",
        debounce = 500,
        args = { "--output-format", "text", "--score", "no", "--msg-template", "'{line}:{column}:{category}:{msg} ({msg_id}:{symbol})'", "%file" },
        formatPattern = {
            "^(\\d+?):(\\d+?):([a-z]+?):(.*)$",
            {
                line = 1,
                column = 2,
                security = 3,
                message = 4
            }
        },
        rootPatterns = { ".git", "pyproject.toml", "setup.py" },
        securities = {
            informational = "hint",
            refactor = "info",
            convention = "info",
            warning = "warning",
            error = "error",
            fatal = "error"
        },
        offsetColumn = 1,
        formatLines = 1
    },
}

local formatters = {
    prettier = {
        command = "prettier",
        args = {"--stdin-filepath", "%filepath"},
        rootPatterns = {
            ".prettierrc",
            ".prettierrc.json",
            ".prettierrc.toml",
            ".prettierrc.json",
            ".prettierrc.yml",
            ".prettierrc.yaml",
            ".prettierrc.json5",
            ".prettierrc.js",
            ".prettierrc.cjs",
            "prettier.config.js",
            "prettier.config.cjs"
        },
    },
    black = {command = "black", args = {"--quiet", "-"}},
}

local formatFiletypes = {
    typescript = "prettier",
    typescriptreact =  "prettier",
    javascript = "prettier",
    javascriptreact = "prettier",
    python = "black",
}

local lua_settings = {
       Lua = {
         runtime = {
           version = 'LuaJIT',
           path = {
             '?.lua',
             '?/init.lua',
             vim.fn.expand'~/.luarocks/share/lua/5.3/?.lua',
             vim.fn.expand'~/.luarocks/share/lua/5.3/?/init.lua',
             '/usr/share/5.3/?.lua',
             '/usr/share/lua/5.3/?/init.lua'
           }
         },
         diagnostics = {
             globals = {'vim'},
         },
         workspace = {
           library = {
             [vim.fn.expand'~/.luarocks/share/lua/5.3'] = true,
             ['/usr/share/lua/5.3'] = true
           },
           checkThirdParty = false,
         }
       }
}

-- config that activates keymaps and enables snippet support
local function make_config()
  local capabilities = vim.lsp.protocol.make_client_capabilities()
  capabilities.textDocument.completion.completionItem.snippetSupport = true
  return {
    -- enable snippet support
    capabilities = capabilities,
    -- map buffer local keybindings when the language server attaches
    on_attach = on_attach,
  }
end


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

local function setup_servers(server)
    local config = make_config()
    local opts = {
        on_attach = on_attach,
        capabilities = config.capabilities,
    }

    if server.name == 'sumneko_lua' then
        opts.settings = lua_settings
    end

    if server.name == 'tsserver' then
        opts.on_attach = function(client, bufnr)
            print("attaching to js file..." .. client.name)
            client.resolved_capabilities.document_formatting = false
            on_attach(client, bufnr)
        end
    end

    if server.name == 'diagnosticls' then
        opts.filetypes = vim.tbl_keys(filetypes)
        opts.init_options = {
            filetypes = filetypes,
            linters = linters,
            formatters = formatters,
            formatFiletypes = formatFiletypes
        }
    end

    server:setup(opts)
    vim.cmd [[ do User LspAttachBuffers ]]
end


lsp_installer.on_server_ready(setup_servers)

-- Java DT language server
local function start_jdtls()
    local cmd = {'java-lsp.sh'}
    local init_options = {
        bundles = {
            "/home/patroclus/.java-debug/java-debug/com.microsoft.java.debug.plugin/target/com.microsoft.java.debug.plugin-0.32.0.jar"
        }
    }
    require('lspconfig').jdtls.setup{ cmd = cmd, init_options = init_options }
end

start_jdtls()


-- miscellaneous ui customization
-- show box when cursor is over diagnostic
vim.o.updatetime = 250
vim.cmd [[autocmd CursorHold,CursorHoldI * lua vim.lsp.diagnostic.show_line_diagnostics({focusable=false})]]
