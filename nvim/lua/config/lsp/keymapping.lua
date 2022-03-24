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
    buf_keymap(bufnr, "n", "[a", ":LspDiagPrev<CR>", opts)
    buf_keymap(bufnr, "n", "]a", ":LspDiagNext<CR>", opts)



    vim.cmd("command! LspDef lua vim.lsp.buf.definition()")
    vim.cmd("command! LspFormatting lua vim.lsp.buf.formatting_seq_sync(nil, 2000)")
    vim.cmd("command! LspCodeAction lua vim.lsp.buf.code_action()")
    vim.cmd("command! LspRename lua vim.lsp.buf.rename()")
    vim.cmd("command! LspRefs lua vim.lsp.buf.references()")
    vim.cmd("command! LspTypeDef lua vim.lsp.buf.type_definition()")
    vim.cmd("command! LspImplementation lua vim.lsp.buf.implementation()")
    vim.cmd(
        "command! LspDiagLine lua vim.diagnostic.open_float()")
    vim.cmd("command! LspSignatureHelp lua vim.lsp.buf.signature_help()")

    buf_keymap(bufnr, "n", "gd", ":LspDef<CR>", opts)
    buf_keymap(bufnr, "n", "gr", ":LspRename<CR>", opts)
    buf_keymap(bufnr, "n", "gR", ":LspRefs<CR>", opts)
    buf_keymap(bufnr, "n", "gy", ":LspTypeDef<CR>", opts)
    buf_keymap(bufnr, "n", "gs", ":LspOrganize<CR>", opts)
        buf_keymap(bufnr, "n", "ga", ":LspCodeAction<CR>", opts)
    buf_keymap(bufnr, "n", "<Leader>a", ":LspDiagLine<CR>", opts)
    buf_keymap(bufnr, "i", "<C-x><C-x>", "<cmd> LspSignatureHelp<CR>", opts)

    if client.resolved_capabilities.document_formatting then
        vim.api.nvim_exec([[
         augroup LspAutocommands
             autocmd! * <buffer>
             autocmd BufWritePost <buffer> LspFormatting
         augroup END
         ]], true)
    end
end


function M.setup(client, bufnr)
    keymappings(client, bufnr)
end


return M
