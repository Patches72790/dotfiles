local M = {}

local function on_attach(client, bufnr)
    -- configure the keymappings
    require('config.lsp.keymapping').setup(client, bufnr)

    -- configure highlighting TODO
    -- Configure Formatting TODO
    require('config.lsp.null-ls.formatter').setup()
end

-- update nvim cmp capabilities
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').update_capabilities(capabilities)

local opts = {
    on_attach = on_attach,
    capabilities = capabilities,
    flags = {
        debounce_text_changes = 150,
    }
}

-- setup LSP handlers
require('config.lsp.handlers').setup()

function M.setup()
    -- null-ls setup TODO
    -- require('config.lsp.null-ls').setup(opts)
    -- Lsp-Installer setup TODO
    require("config.lsp.installer").setup(opts)
end

return M
