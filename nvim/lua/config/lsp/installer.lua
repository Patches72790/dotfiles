local M = {}

-- server options to be used in setup function for lsp_installer
local server_handlers = {
    lua_ls = function()
        require('neodev').setup()
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
    end,
    yamlls = function()
        return {
            settings = {
                yaml = {
                    schemas = {
                        ["https://gitlab.com/gitlab-org/gitlab/-/raw/master/app/assets/javascripts/editor/schema/ci.json"] =
                        "/gitlab-ci.yml",
                    },
                    format = {
                        enable = true,
                    },
                    hover = true,
                },
            },
        }
    end,
    rust_analyzer = function(options)
        return {
            -- add the custom on_attach and resolved_capabilities from lsp/init.lua
            server = vim.tbl_deep_extend("force", options, {
                default_settings = {
                    ["rust-analyzer"] = {
                        check = {
                            command = "clippy",
                        },
                    },
                },
            }),
        }
    end,
    nvim_jdtls = function()
        local home = os.getenv("HOME")
        local mason_path = vim.fn.stdpath("data") .. "/mason/packages"
        local root_dir = vim.fs.dirname(vim.fs.find({ "gradlew", ".git", "mvnw", "pom.xml" }, { upward = true })[1])

        local project_name = vim.fn.fnamemodify(root_dir, ":p:h:t")
        local workspace_dir = home .. "/.cache/jdtls/workspace" .. project_name

        local jdtls_path = mason_path .. "/jdtls"
        local lombok_path = jdtls_path .. "/lombok.jar"
        local config_path = jdtls_path .. "/config_mac"
        local path_to_jar = jdtls_path
            .. "/plugins/org.eclipse.equinox.launcher.cocoa.macosx.aarch64_1.2.900.v20240129-1338.jar"

        return {
            cmd = {
                "java",

                "-Declipse.application=org.eclipse.jdt.ls.core.id1",
                "-Dosgi.bundles.defaultStartLevel=4",
                "-Declipse.product=org.eclipse.jdt.ls.core.product",
                "-Dlog.protocol=true",
                "-Dlog.level=ALL",
                "-Xmx1g",
                "-javaagent:" .. lombok_path,
                "--add-modules=ALL-SYSTEM",
                "--add-opens",
                "java.base/java.util=ALL-UNNAMED",
                "--add-opens",
                "java.base/java.lang=ALL-UNNAMED",

                -- 💀
                "-jar",
                path_to_jar,
                -- 💀
                "-configuration",
                config_path,
                "-data",
                workspace_dir,
            },
            init_options = {
                extendedClientCapabilities = require("jdtls").extendedClientCapabilities,
            },
            root_dir = root_dir,
            settings = {
                java = {
                    format = {
                        enabled = true,
                        settings = {
                            url = os.getenv("HOME") .. "/dotfiles/formatting/java/google-style.xml",
                            profile = "GoogleStyle",
                        },
                    },
                    saveActions = {
                        organizeImports = true,
                    },
                    import = {
                        maven = {
                            enabled = true,
                        },
                    },
                    eclipse = {
                        downloadSources = true,
                    },
                    maven = {
                        downloadSources = true,
                    },
                },
            },
        }
    end,
    jdtls = function()
        return {
            settings = {
                java = {
                    format = {
                        enabled = false,
                        settings = {
                            url = os.getenv("HOME") .. "/dotfiles/formatting/java/google-style.xml",
                            profile = "GoogleStyle",
                        },
                    },
                    saveActions = {
                        organizeImports = false,
                    },
                    completion = {
                        favoriteStaticMembers = {
                            "lombok.*",
                            "org.junit.Assert.*",
                            "org.junit.Assume.*",
                            "org.junit.jupiter.api.Assertions.*",
                            "org.junit.jupiter.api.Assumptions.*",
                            "org.junit.jupiter.api.DynamicContainer.*",
                            "org.junit.jupiter.api.DynamicTest.*",
                        },
                    },
                    import = {
                        maven = {
                            enabled = true,
                            downloadSources = true,
                        },
                        exclusions = {
                            "**/node_modules/**",
                            "**/.metadata/**",
                            "**/archetype-resources/**",
                            "**/META-INF/maven/**",
                            "/**/test/**",
                        },
                    },
                },
            },
        }
    end,
    terraformls = function()
        return {
            init_options = {
                terraform = {
                    path = os.getenv("HOME") .. "/.nix-profile/bin/terraform",
                },
            },
        }
    end,
}

-- Fetches the appropriate server handler options and merges with default options
-- If server name doesn't exist in table, then return base options
local get_server_opts = function(server_name, options)
    local server_handler = server_handlers[server_name]
    if server_handler ~= nil then
        local more_opts = vim.tbl_deep_extend("force", {}, options, server_handler(options))
        return more_opts
    end

    return options
end

local ensure_installed_servers = {
    "rnix",
    "pyright",
    "rust_analyzer",
    "ts_ls",
    "lua_ls",
    "yamlls",
    "gopls",
    "yamlls",
    "bashls",
    "clangd",
    "dockerls",
    "terraformls",
    "eslint",
    --"hls",
    "jdtls",
}

function M.setup(options)
    local lsp_installer = require("mason-lspconfig")
    local mason = require("mason")

    mason.setup({
        ui = {
            icons = {
                server_installed = "✓",
                server_pending = "➜",
                server_uninstalled = "✗",
            },
        },
    })

    lsp_installer.setup({
        automatic_enable = false,
        ensure_installed = ensure_installed_servers,
    })

    for _, server in pairs(ensure_installed_servers) do
        vim.lsp.enable(server)
        vim.lsp.config(server, options)
    end

    require("config.lsp.conform").setup()
end

return M
