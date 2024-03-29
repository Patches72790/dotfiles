local M = {}
local cmp = require("cmp")
local lspkind = require("lspkind")

local cmp_configuration = {
	snippet = {
		expand = function(args)
			require("luasnip").lsp_expand(args.body)
		end,
	},
	--completion = { completeopt = "menu,menuone,noinsert" },
	mapping = cmp.mapping.preset.insert({
		["<C-b>"] = cmp.mapping.scroll_docs(-4),
		["<C-f>"] = cmp.mapping.scroll_docs(4),
		["<C-Space>"] = cmp.mapping.complete(),
		["<C-e>"] = cmp.mapping.close(),
		["<CR>"] = cmp.mapping.confirm({
			behavior = cmp.ConfirmBehavior.Replace,
			select = false,
		}),
		["<Tab>"] = cmp.mapping.select_next_item(),
		["<S-Tab>"] = cmp.mapping.select_prev_item(),
	}),
	formatting = {
		format = lspkind.cmp_format({
			with_text = true,
			max_width = 50,
			before = function(entry, vim_item)
				vim_item.menu = ({
					nvim_lsp = "[LSP]",
					buffer = "[Buffer]",
					nvim_lua = "[Lua]",
					path = "[Path]",
					luasnip = "[LuaSnip]",
					cmdline = "[CmdLine]",
				})[entry.source.name]
				return vim_item
			end,
		}),
	},
	sources = cmp.config.sources({
		{ name = "nvim_lsp" },
		{ name = "buffer", keyword_length = 5 },
		{ name = "nvim_lua" },
		{ name = "path" },
		{ name = "luasnip" },
	}),
	view = {
		entries = "custom",
	},
}

-- used with ':' on cmdline
local cmp_cmdline_config = {
	mapping = cmp.mapping.preset.cmdline(),
	sources = cmp.config.sources({
		{ name = "cmdline" },
		{ name = "path" },
	}),
}

-- used with '/' on cmdline
local cmp_cmdline_search_config = {
	mapping = cmp.mapping.preset.cmdline(),
	sources = cmp.config.sources({
		{ name = "path" },
	}, {
		{
			name = "cmdline",
			option = {
				ignore_cmds = { "Man", "!" },
			},
		},
	}),
}

function M.setup()
	cmp.setup(cmp_configuration)
	cmp.setup.cmdline(":", cmp_cmdline_config)
	cmp.setup.cmdline("/", cmp_cmdline_search_config)
end

return M
