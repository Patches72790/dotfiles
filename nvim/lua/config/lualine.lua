local lualine = require'lualine'

lualine.setup({
    options = {
        theme = "gruvbox"
    },
    tabline = {
        lualine_a = {'tabs'}
    }
})
