local api = vim.api

local function create_floating_window(contents, filetype)
  local existing_buf = vim.fn.bufnr("float_prevw")
  local buf

  if existing_buf ~= -1 then
    buf = existing_buf
  else
    buf = api.nvim_create_buf(false, true)
    vim.api.nvim_buf_set_name(buf, "float_prevw")
  end

  api.nvim_buf_set_lines(buf, 0, -1, false, contents)
  api.nvim_buf_set_option(buf, 'filetype', filetype)

  local width = api.nvim_get_option('columns')
  local height = api.nvim_get_option('lines')

  local max_width = math.floor(width * 0.6)
  local max_height = math.floor(height * 0.8)

  local win_height = math.max(#contents, max_height) -- Changed
  local win_width = math.min(max_width, math.max(unpack(vim.tbl_map(function(line)
    return vim.fn.strdisplaywidth(line) + 28
  end, contents)))) + 8 -- padding

  local row = math.ceil((height - win_height) / 2)
  local col = math.ceil((width - win_width) / 2)

  -- local border_opts = {
  --   style = 'minimal',
  --   relative = 'cursor',
  --   width = win_width + 2,
  --   height = win_height + 2,
  --   row = row - 1,
  --   col = col - 1
  -- }

  -- local border_buf = api.nvim_create_buf(false, true)
  -- local border_lines = { '╭' .. string.rep('─', win_width) .. '╮' }
  -- for _ = 1, win_height do
  --   table.insert(border_lines, '│' .. string.rep(' ', win_width) .. '│')
  -- end
  -- table.insert(border_lines, '╰' .. string.rep('─', win_width) .. '╯')
  -- api.nvim_buf_set_lines(border_buf, 0, -1, false, border_lines)
  -- local border_win = api.nvim_open_win(border_buf, true, border_opts)

  local opts = {
    style = 'minimal',
    relative = 'cursor',
    width = win_width,
    height = win_height,
    row = row,
    col = col
  }

  local win = api.nvim_open_win(buf, true, opts)


  return buf, win
  -- , border_buf, border_win
end

function _G.show_floating_declaration()
  local params = vim.lsp.util.make_position_params()
  local results_lsp, err = vim.lsp.buf_request_sync(0, 'textDocument/definition', params, 500)
  local filetype = vim.api.nvim_buf_get_option(0, 'filetype')

  if not results_lsp or err then
    print("Error fetching declaration")
    return
  end

  local result = nil

  for _, lsp_result in pairs(results_lsp) do
    if lsp_result.result and lsp_result.result[1] then
      result = lsp_result.result[1]
      break
    end
  end

  if not result then
    print("No declaration found")
    return
  end

  local uri = result.uri
  local range = result.range
  local start_line = range.start.line
  local end_line = start_line + 10
  _G.original_end_line = end_line -- Add this line to store the end line globally
  local bufnr = vim.uri_to_bufnr(uri)
  _G.original_bufnr = bufnr       -- Add this line to store the buffer number globally

  -- Force-load the buffer into memory
  vim.fn.bufload(bufnr)

  local content = vim.api.nvim_buf_get_lines(bufnr, start_line, end_line + 1, false)
  local floating_bufnr, winnr = create_floating_window(content, filetype)

  local float_name = vim.api.nvim_buf_get_name(bufnr)
  print("Float name: ", float_name)

  api.nvim_win_set_option(winnr, "wrap", false)
  api.nvim_win_set_option(winnr, "cursorline", true)

  function _G.close_preview()
    vim.api.nvim_win_close(winnr, true)
    -- vim.api.nvim_win_close(border_win, true)
    vim.api.nvim_buf_delete(bufnr, { force = true })
    -- vim.api.nvim_buf_delete(border_bufnr, { force = true })
  end

  local function on_buf_leave()
    vim.api.nvim_exec([[autocmd! BufLeave <buffer> ++once lua close_preview()]], false)
  end

  api.nvim_buf_attach(floating_bufnr, false, {
    on_detach = function()
      api.nvim_exec([[autocmd! BufLeave <buffer> ++once lua close_preview()]], false)
    end,
  })

  on_buf_leave()
end

function _G.extend_floating_window()
  local winnr = -1
  for _, win in pairs(vim.api.nvim_list_wins()) do
    local bufnr = vim.api.nvim_win_get_buf(win)
    local bufname = vim.api.nvim_buf_get_name(bufnr)
    if string.find(bufname, "float_prevw") then
      winnr = win
      break
    end
  end


  if winnr == -1 then
    print("No floating window found")
    return
  end

  local bufnr = vim.api.nvim_win_get_buf(winnr)
  local end_line = vim.api.nvim_buf_line_count(bufnr)


  local original_bufnr = _G.original_bufnr
  local original_end_line = _G.original_end_line


  if end_line >= original_end_line then
    print("Reached end of file")
    return
  end

  local content = vim.api.nvim_buf_get_lines(original_bufnr, end_line, end_line + 10, false)
  vim.api.nvim_buf_set_lines(bufnr, -1, -1, false, content)

  _G.original_end_line = _G.original_end_line + 10

  vim.api.nvim_win_set_cursor(winnr, { end_line + 1, 0 })
end

vim.api.nvim_set_keymap('n', '<Leader>k', '<cmd>lua extend_floating_window()<CR>', { noremap = true, silent = true })
