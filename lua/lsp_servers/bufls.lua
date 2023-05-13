local M = {}

local util = require('lspconfig').util
local bin_name = "bufls"
local cmd = { bin_name, "serve" }

if vim.fn.has("win32") == 1 then
  cmd = { "cmd.exe", "/C", bin_name, "start" }
end

local bufls = {
  default_config = {
    cmd = cmd,
    filetypes = { "proto" },
    root_dir = function(fname)
      return util.root_pattern("buf.work.yaml", ".git")(fname)
    end,
  },
}

M.bufls = bufls
return M
