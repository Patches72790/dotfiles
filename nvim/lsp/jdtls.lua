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
