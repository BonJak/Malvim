vim.cmd [[luafile ~/.config/lvim/lua/user/floating_preview.lua]]

vim.api.nvim_exec([[
  autocmd VimEnter * luafile ~/.config/lvim/lua/user/chatgptcfg.lua
]], false)

vim.cmd [[luafile ~/.config/lvim/lua/user/options.lua]]

vim.api.nvim_exec([[
  autocmd VimEnter * UpdateRemotePlugins
]], false)
