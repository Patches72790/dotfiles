-- Prints the table given t with vim.inspect
-- returns the table after printing
P = function(t)
	print(vim.inspect(t))
	return t
end

RELOAD = function(...)
	return require("plenary.reload").reload_module(...)
end

R = function(name)
	RELOAD(name)
	return require(name)
end
