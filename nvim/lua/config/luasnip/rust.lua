local M = {}

local add_snippets_for_filetypes = require("config.luasnip.util").add_snippets_for_filetypes

local test_snip_string = "\
#[cfg(test)] \
mod tests {{\
    use super::*; \
\
    #[test]\
    fn test_{}() {{}}\
}}\
"

M.configure_snippets = function(ls)
	local s = ls.snippet
	local t = ls.text_node
	local i = ls.insert_node
	local fmt = require("luasnip.extras.fmt").fmt

	add_snippets_for_filetypes(ls, { "rust" }, {
		s(
			"test",
			fmt(test_snip_string, {
				i(1),
			})
		),
	})
end

return M
