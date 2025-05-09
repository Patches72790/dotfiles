local M = {}

local function configure_keymaps(ls)
	-- vim.ui.select for choice nodes
	vim.keymap.set({ "i", "s" }, "<c-u>", "<cmd>lua require('luasnip.extras.select_choice')()<CR>", { silent = true })

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
	local FILETYPE_COMMENTS = require("config.luasnip.util").FILETYPE_TO_COMMENTS
	local fmt = require("luasnip.extras.fmt").fmt
	local rep = require("luasnip.extras").rep
	local s = ls.snippet
	local t = ls.text_node
	local i = ls.insert_node
	local c = ls.choice_node
	local d = ls.dynamic_node
	local f = ls.function_node

	ls.add_snippets("all", {
		s(
			"todo",
			fmt("{comment} TODO => {note}", {
				comment = f(function()
					return FILETYPE_COMMENTS[vim.bo.filetype]
				end),
				note = i(3),
			})
		),
	})

	ls.add_snippets("lua", {
		s("req", fmt("local {} = require('{}')", { i(1, "default"), rep(1) })),
	})

	require("config.luasnip.js").configure_snippets(ls)
	require("config.luasnip.html").configure_snippets(ls)
	require("config.luasnip.rust").configure_snippets(ls)
	require("config.luasnip.terraform").configure_snippets(ls)
	require("config.luasnip.go").configure_snippets(ls)
end

local function configure_luasnip()
	local ls = require("luasnip")
	local types = require("luasnip.util.types")

	ls.config.set_config({
		history = true,
		update_events = "TextChanged,TextChangedI",
		enable_autosnippets = true,
		ext_opts = {
			[types.choiceNode] = {
				active = {
					virt_text = { { "← Current Choice", "Info" } },
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
