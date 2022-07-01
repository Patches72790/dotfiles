local M = {}

local function configure_keymaps(ls)
	-- expansion key
	-- expand current item or jump to next in snippet
	vim.keymap.set({ "i", "s" }, "<c-k>", function()
		if ls.expand_or_jumpable() then
			ls.expand_or_jump()
		end
	end, { silent = true })

	-- jump backwards key
	-- move to previous item within snippet
	vim.keymap.set({ "i", "s" }, "<c-j>", function()
		if ls.jumpable(-1) then
			ls.jump(-1)
		end
	end, { silent = true })

	-- select list of options
	vim.keymap.set("i", "<c-l>", function()
		if ls.choice_active() then
			ls.change_choice(1)
		end
	end)
end

local function configure_snippets(ls)
	local fmt = require("luasnip.extras.fmt").fmt
	local rep = require("luasnip.extras").rep
	local s = ls.snippet
	local t = ls.text_node
	local i = ls.insert_node

	ls.add_snippets("all", {
		s("fn", {
			t("fun function"),
		}),
	})

	ls.add_snippets("lua", {
		s("req", fmt("local {} = require('{}')", { i(1, "default"), rep(1) })),
	})

	ls.add_snippets("html", {
		s("div", {
			t("<div>"),
			i(1),
			t("</div>"),
		}),
	})
end

local function configure_luasnip()
	local ls = require("luasnip")
	local types = require("luasnip.util.types")

	ls.config.set_config({
		history = true,
		update_events = "TextChanged,TextChangedI",
		enable_autosnippets = true,
		exit_opts = {
			[types.choiceNode] = {
				active = {
					virt_text = { { "←", "Error" } },
				},
			},
		},
	})

	configure_keymaps(ls)
	configure_snippets(ls)
end

M.setup = function()
	configure_luasnip()
end

return M
