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
