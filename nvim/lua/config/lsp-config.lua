local vim = vim
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
vim.lsp.handlers["textDocument/references"] =
    require('telescope.builtin').lsp_references;
vim.lsp.handlers["textDocument/definition"] =
    require('telescope.builtin').lsp_definitions;

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

-- automatically install servers in this list
local servers = {
    "bashls", "pylsp", "jdtls", "sumneko_lua", "tsserver", "rust_analyzer",
    "vimls", "clangd", "eslint"
}

for _, name in pairs(servers) do
    local ok, server = lsp_installer.get_server(name)
    -- Check that the server is supported in nvim-lsp-installer
    if ok then
        if not server:is_installed() then
            print("Installing " .. name)
            server:install()
        end
    end
end

--  setup relies on configuration in lang-servers
local function setup_servers(server)
    local lang_server_cfg = require('config.lang-servers')
    local server_opts = lang_server_cfg.server_opts
    local default_opts = lang_server_cfg.make_config()
    server:setup(server_opts[server.name] and server_opts[server.name]() or
                     default_opts)
    vim.cmd [[ do User LspAttachBuffers ]]
end

lsp_installer.on_server_ready(setup_servers)

-- miscellaneous ui customization
-- show box when cursor is over diagnostic
vim.o.updatetime = 250
-- vim.cmd [[autocmd CursorHold,CursorHoldI * lua vim.lsp.diagnostic.show_line_diagnostics({focusable=false})]]
