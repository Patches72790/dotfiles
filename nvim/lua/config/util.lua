local M = {}

local cmd = vim.cmd
local o_s = vim.o
local map_key = vim.api.nvim_set_keymap

-- Set options for the given scopes
-- of by default to vim.o scope
function M.opt(o, v, scopes)
	scopes = scopes or { o_s }
	for _, s in ipairs(scopes) do
		s[o] = v
	end
end

function M.autocmd(group, cmds, clear)
	clear = clear == nil and false or clear
	if type(cmds) == "string" then
		cmds = { cmds }
	end
	cmd("augroup " .. group)
	if clear then
		cmd([[au!]])
	end
	for _, c in ipairs(cmds) do
		cmd("autocmd " .. c)
	end
	cmd([[augroup END]])
end

function M.map(modes, lhs, rhs, opts)
	opts = opts or {}
	opts.noremap = opts.noremap == nil and true or opts.noremap
	if type(modes) == "string" then
		modes = { modes }
	end
	for _, mode in ipairs(modes) do
		map_key(mode, lhs, rhs, opts)
	end
end

function M.warn(msg, name)
	vim.notify(msg, vim.log.levels.WARN, { title = name })
end

function M.error(msg, name)
	vim.notify(msg, vim.log.levels.ERROR, { title = name })
end

function M.info(msg, name)
	vim.notify(msg, vim.log.levels.INFO, { title = name })
end


return M
