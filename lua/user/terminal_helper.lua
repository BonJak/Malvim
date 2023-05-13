-- terminal_helper.lua
local M = {}

M.terminal_count = 1

function M.create_new_terminal(direction)
  if M.terminal_count == 1 then
    vim.cmd(string.format("ToggleTerm direction='%s'<CR>", direction))
  else
    vim.cmd(string.format("%dToggleTerm direction='%s'<CR>", M.terminal_count, direction))
  end
  M.terminal_count = M.terminal_count + 1
end

return M
