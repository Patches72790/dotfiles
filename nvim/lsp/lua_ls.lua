return {
    settings = {
        Lua = {
            runtime = {
                version = "LuaJIT",
                path = {
                    "?.lua",
                    "?/init.lua",
                    vim.fn.expand("~/.luarocks/share/lua/5.3/?.lua"),
                    vim.fn.expand("~/.luarocks/share/lua/5.3/?/init.lua"),
                    "/usr/share/5.3/?.lua",
                    "/usr/share/lua/5.3/?/init.lua",
                },
            },
            diagnostics = { globals = { "vim", "require" } },
            workspace = {
                library = {
                    [vim.fn.expand("~/.luarocks/share/lua/5.3")] = true,
                    ["/usr/share/lua/5.3"] = true,
                },
                checkThirdParty = false,
            },
            telemetry = {
                enable = false,
            },
        },
    },
}
