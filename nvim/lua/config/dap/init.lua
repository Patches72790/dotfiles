local M = {}

---Configures general utilities for the debugging tool
local function configure()
	-- sign definitions
	vim.fn.sign_define("DapBreakpoint", { text = "🟥", texthl = "", linehl = "", numhl = "" })
	vim.fn.sign_define("DapBreakpointRejected", { text = "🟦", texthl = "", linehl = "", numhl = "" })
	vim.fn.sign_define("DapStopped", { text = "⭐️", texthl = "", linehl = "", numhl = "" })
end

local function configure_debuggers()
	--require("config.debugging.python").setup()
	--require("config.dap.rust").setup()
	require("config.dap.go").setup()
end

local function configure_keymaps()
	local dap = require("dap")
	local dapui = require("dapui")
	vim.keymap.set("n", "<leader>dbr", dap.toggle_breakpoint, { desc = "DAP Toggle Breakpoint" })
	vim.keymap.set("n", "<leader>ddc", dap.continue, { desc = "DAP Continue" })
	vim.keymap.set("n", "<leader>ddt", dap.terminate, { desc = "DAP Terminate" })
	vim.keymap.set("n", "<leader>ddv", dap.step_over, { desc = "DAP Step Over" })
	vim.keymap.set("n", "<leader>ddi", dap.step_into, { desc = "DAP Step Into" })
	vim.keymap.set("n", "<leader>ddo", dap.step_out, { desc = "DAP Step Out" })
	vim.keymap.set("n", "<leader>ddb", dap.step_back, { desc = "DAP Step Back" })

	-- configure dapui event handlers
	dap.listeners.before.attach.dapui_config = function()
		dapui.open()
	end
	dap.listeners.before.launch.dapui_config = function()
		dapui.open()
	end
	dap.listeners.before.event_terminated.dapui_config = function()
		dapui.close()
	end
	dap.listeners.before.event_exited.dapui_config = function()
		dapui.close()
	end
end

function M.setup()
	configure()
	configure_debuggers()
	require("dapui").setup() -- initialize nvim-dap-ui
	configure_keymaps()
end

return M
