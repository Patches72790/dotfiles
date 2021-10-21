local lint = require('lint')

lint.linters_by_ft = {
    javascript = {'eslint'},
    typescript = {'eslint'},
    python = {'pylint'},
    lua = {'luacheck'},
    json = {'eslint'}
}
