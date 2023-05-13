local M = {}

function M.find_root_dir()
  local git_dir = vim.fn.finddir('.git', vim.fn.expand('%:p:h') .. ';')
  if git_dir ~= '' then
    return vim.fn.fnamemodify(git_dir, ':h')
  end

  local lock_file = vim.fn.findfile('*.lock', vim.fn.expand('%:p:h') .. ';')
  if lock_file ~= '' then
    return vim.fn.fnamemodify(lock_file, ':h')
  end

  return vim.fn.stdpath('data')
end

return M
