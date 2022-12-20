local M = {}

M.setup = function()
	if vim.fn.has("macunix") then
		vim.g.vimtex_view_method = "skim"
	else
		vim.g.vimtex_view_method = "zathura"
	end
	vim.g.vimtex_compiler_method = "latexmk"
	vim.g.vimtex_complete_enabled = 1
	vim.g.vimtex_indent_enabled = 0
	vim.g.vimtex_syntax_conceal_disable = 1
end

return M
