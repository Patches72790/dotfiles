local M = {}

local add_snippets_for_filetypes = require("config.luasnip.util").add_snippets_for_filetypes

local test_snip_string = '\
    tags = {{\
      Origin = "Terraform"\
      Name = "${{var.project_name}}-{}"\
      Project = "${{var.project_name}}"\
    }}\
'

local variable_snip = '\
variable "{}" {{\
  type = {}\
  default = {}\
}}'

M.configure_snippets = function(ls)
	local s = ls.snippet
	local i = ls.insert_node
	local d = ls.dynamic_node
	local sn = ls.snippet_node
	local fmt = require("luasnip.extras.fmt").fmt

	add_snippets_for_filetypes(ls, { "terraform" }, {
		s(
			"tf-tags",
			fmt(test_snip_string, {
				i(1),
			})
		),
		s("tf-var", fmt(variable_snip, { i(1), i(2), i(3) })),
	})
end

return M
