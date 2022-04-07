local M = {}
local map = require("config.util").map

function M.setup()
	-- Key mappings for nvim-dap debugging
	map("n", "<F5>", ":lua require('dap').continue()<CR>")
	map("n", "<F9>", ":lua require('dap').toggle_breakpoint()<CR>")
	map("n", "<F10>", ":lua require'dap'.step_over()<CR>")
	map("n", "<F11>", ":lua require'dap'.step_into()<CR>")
	map("n", "<F12>", ":lua require'dap'.step_out()<CR>")
	map("n", "<leader>B", ":lua require'dap'.set_breakpoint(vim.fn.input('Breakpoint condition: '))<CR>")
	map("n", "<leader>lp", ":lua require'dap'.set_breakpoint(nil, nil, vim.fn.input('Log point message: '))<CR>")
	map("n", "<leader>dr", ":lua require'dap'.repl.open()<CR>")
	map("n", "<leader>dl", ":lua require'dap'.run_last()<CR>")

	-- dap-python keys
	map("n", "<leader>dn", ":lua require'dap-python'.test_method()<CR>")
	map("n", "<leader>df", ":lua require'dap-python'.test_class()<CR>")
	map("n", "<leader>ds", "<ESC>:lua require'dap-python'.debug_selection()<CR>")

	-- mapping for nvim-dap-ui
	map("n", "<F24>", ":lua require('dapui').toggle()<CR>")
end

return M
