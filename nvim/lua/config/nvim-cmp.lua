local cmp = require('cmp')
local lspkind = require('lspkind')

cmp.setup {
    snippet = {
        expand = function(args) require('luasnip').lsp_expand(args.body) end
    },
    mapping = {
        ['<C-p>'] = cmp.mapping.select_prev_item(),
        ['<C-n>'] = cmp.mapping.select_next_item(),
        ['<C-d>'] = cmp.mapping.scroll_docs(-4),
        ['<C-f>'] = cmp.mapping.scroll_docs(4),
        ['<C-Space>'] = cmp.mapping.complete(),
        ['<C-e>'] = cmp.mapping.close(),
        ['<CR>'] = cmp.mapping.confirm {
            behavior = cmp.ConfirmBehavior.Replace,
            select = true
        },
        ['<Tab>'] = cmp.mapping.select_next_item(),
        ['<S-Tab>'] = cmp.mapping.select_prev_item()
    },
    formatting = {
        format = lspkind.cmp_format({
            with_text = false,
            max_width = 50,
            before = function(entry, vim_item)
                vim_item.menu = ({
                    nvim_lsp = "[LSP]",
                    buffer = "[Buffer]",
                    nvim_lua = "[Lua]",
                    path = "[Path]",
                    luasnip = "[LuaSnip]",
                    rg = "[RG]",
                })[entry.source.name]
                return vim_item
            end,
        }),
    },
    sources = {
        {name = 'nvim_lsp'}, {name = 'buffer'}, {name = 'nvim_lua'},
        {name = 'path'}, {name = 'luasnip'}, 
        { name = 'rg', option = { additional_arguments = "--max-depth 4", debounce = 500}},
    }
}
