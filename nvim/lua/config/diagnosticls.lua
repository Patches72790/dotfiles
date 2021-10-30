M = {}

M.filetypes = {
    --    typescript = "eslint",
    --    typescriptreact = "eslint",
    --    javascript = "eslint",
    --    javascriptreact = "eslint",
    python = "pylint"
}

M.linters = {
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
        semi = {"error", 2},
        securities = {[2] = "error", [1] = "warning"}
    },
    pylint = {
        sourceName = "pylint",
        command = "pylint",
        debounce = 500,
        args = {
            "--output-format", "text", "--score", "no", "--msg-template",
            "'{line}:{column}:{category}:{msg} ({msg_id}:{symbol})'", "%file"
        },
        formatPattern = {
            "^(\\d+?):(\\d+?):([a-z]+?):(.*)$",
            {line = 1, column = 2, security = 3, message = 4}
        },
        rootPatterns = {".git", "pyproject.toml", "setup.py"},
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
    }
}

M.formatters = {
    prettier = {
        command = "prettier",
        args = {"--stdin-filepath", "%filepath"},
        rootPatterns = {
            ".prettierrc", ".prettierrc.json", ".prettierrc.toml",
            ".prettierrc.json", ".prettierrc.yml", ".prettierrc.yaml",
            ".prettierrc.json5", ".prettierrc.js", ".prettierrc.cjs",
            "prettier.config.js", "prettier.config.cjs"
        }
    },
    black = {command = "black", args = {"--quiet", "-"}}
}

M.formatFiletypes = {
    --    typescript = "prettier",
    --    typescriptreact = "prettier",
    --    javascript = "prettier",
    --    javascriptreact = "prettier",
    python = "black"
}

return M
