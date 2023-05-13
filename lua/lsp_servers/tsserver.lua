local M = {}

local util = require("lspconfig.util")


local bin_name = "typescript-language-server"
local cmd = { bin_name, "--stdio" }

if vim.fn.has("win32") == 1 then
  cmd = { "cmd.exe", "/C", bin_name, "--stdio" }
end

local tsserver = {
  default_config = {
    init_options = { hostInfo = "neovim" },
    cmd = cmd,
    filetypes = {
      "javascript",
      "javascriptreact",
      "javascript.jsx",
      "typescript",
      "typescriptreact",
      "typescript.tsx",
    },
    root_dir = function(fname)
      return util.root_pattern("tsconfig.json")(fname)
          or util.root_pattern("package.json", "jsconfig.json", ".git")(fname)
    end,
    single_file_support = true,
  },
}

M.tsserver = tsserver
return M
