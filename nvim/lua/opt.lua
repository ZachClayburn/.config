local scopes = { g = vim.o, b = vim.bo, w = vim.wo }

return function(scope, key, value)
  scopes[scope][key] = value
  if scope ~= 'g' then scopes['g'][key] = value end
end
