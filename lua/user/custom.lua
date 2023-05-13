function OpenBufferInNextSplit()
  local initial_win = vim.api.nvim_get_current_win()
  local initial_buf = vim.api.nvim_get_current_buf()

  -- Get list of all buffers
  local all_bufs = vim.api.nvim_list_bufs()
  -- Filter out buffers that are not loaded, listed, or associated with a file
  local valid_bufs = {}
  for _, buf in ipairs(all_bufs) do
    if vim.api.nvim_buf_is_loaded(buf) and vim.api.nvim_buf_is_valid(buf) and vim.api.nvim_buf_get_name(buf) ~= "" then
      local buftype = vim.api.nvim_buf_get_option(buf, "buftype")
      local filetype = vim.api.nvim_buf_get_option(buf, "filetype")
      if buftype == "" and filetype ~= "qf" and filetype ~= "help" and filetype ~= "packer" then
        table.insert(valid_bufs, buf)
      end
    end
  end

  -- Move to next window
  vim.cmd('wincmd w')
  if initial_win == vim.api.nvim_get_current_win() then
    -- There was no other window, so return
    return
  end

  -- If we are here, there is a next window
  local next_win = vim.api.nvim_get_current_win()
  local next_buf = vim.api.nvim_get_current_buf()

  -- Move initial buffer to next window
  vim.api.nvim_win_set_buf(next_win, initial_buf)

  -- Go back to initial window
  vim.api.nvim_set_current_win(initial_win)

  -- Find a buffer that is not the initial buffer and not the next buffer
  -- Prefer a buffer that is not displayed in another window
  local all_windows = vim.api.nvim_list_wins()
  -- if number of windows is equal to number of buffers, then set the inital window to the next buffer
  if #all_windows == #valid_bufs then
    -- print("here Number of windows is equal to number of buffers")
    vim.api.nvim_win_set_buf(initial_win, next_buf)
    return
  end

  local buf_to_display = nil
  for _, buf in ipairs(valid_bufs) do
    if buf ~= initial_buf and buf ~= next_buf then
      -- Check if this buffer is displayed in another window
      local is_displayed = false
      for _, win in ipairs(vim.api.nvim_list_wins()) do
        if vim.api.nvim_win_get_buf(win) == buf then
          is_displayed = true
          break
        end
      end
      if not is_displayed then
        buf_to_display = buf
        break
      end
    end
  end

  -- If no such buffer was found, pick the next buffer
  if not buf_to_display then
    buf_to_display = next_buf
  end

  -- Display the chosen buffer in the initial window
  vim.api.nvim_win_set_buf(initial_win, buf_to_display)
end
