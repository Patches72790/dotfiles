local M = {}

local whichkey = require('which-key')
local keymap = vim.api.nvim_set_keymap
local buf_keymap = vim.api.nvim_buf_set_keymap

local function keymappings(client, bufnr)
    local opts = { noremap = true, silent = true }

    -- lsp hover
    buf_keymap(bufnr, "n", "K", "<cmd>lua vim.lsp.buf.hover()<CR>", opts)

    -- lsp diagnostics gotos
    vim.cmd("command! LspDiagPrev lua vim.diagnostic.goto_prev()")
    vim.cmd("command! LspDiagNext lua vim.diagnostic.goto_next()")
    keymap(bufnr, "n", "[a", ":LspDiagPrev<CR>", opts)
    keymap(bufnr, "n", "]a", ":LspDiagNext<CR>", opts)

    -- <leader> + l + [key]
    local keymap_l = {
        l = {
            name = "Code",
            R = { "<cmd>Telescope lsp_references<CR>", "References" },
            a = { "<cmd>Telescope lsp_code_actions<CR>", "Code Action" },
            n = { "<cmd>lua vim.lsp.buf.rename()", "Rename" },
            i = { "<cmd>LspInfo <CR>", "Lsp Info" },
            d = { "<cmd>Telescope diagnostics<CR>", "Diagnostics" },
            s = { "<cmd>Telescope lsp_document_symbols<CR>", "Document Symbols" },
            t = { "<cmd>TroubleToggle<CR>", "Trouble" },
        }
    }

    -- g + [key]
    local keymap_g = {
        name = "Goto",
        d = {"<cmd>Telescope lsp_definitions<CR>", "Definition"},
        D = {"<cmd>lua vim.lsp.buf.declaration()<CR>", "Declaration"},
        s = {"<cmd>lua vim.lsp.buf.signature_help()<CR>", "Signature Help"},
        I = {"<cmd>Telescope lsp_implementations<CR>", "Goto Implementation" },
        t = {"<cmd>Telescope lsp_type_definitions<CR>", "Goto Type Definition" },
    }

    -- enable document formatting if enabled for client
    if client.resolved_capabilities.document_formatting then
        keymap_l.l.F = { "<cmd>lua vim.lsp.buf.formatting_seq_sync(nil, 2000)<CR>", "Format Document" }
    end

    -- register which key keymaps
    whichkey.register(keymap_l, {buffer = bufnr, prefix = "<leader>"})
    whichkey.register(keymap_g, {buffer = bufnr, prefix = "g"})
end

-- Setup the keymappings for client and bufnr
function M.setup(client, bufnr)
    keymappings(client, bufnr)
end

return M
