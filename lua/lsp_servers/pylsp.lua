local M={}
local util = require('lspconfig').util

local pyLSP = {
  default_config = {
    cmd = { "pylsp" },
    filetypes = { "python" },
    root_dir = function(fname)
      local root_files = {
        "pyproject.toml",
        "setup.py",
        "setup.cfg",
        "requirements.txt",
        "Pipfile",
      }
      return util.root_pattern(unpack(root_files))(fname) or util.find_git_ancestor(fname)
    end,
    settings = {
      pylsp = {
        plugins = {
          pycodestyle = {
            enabled = true,
            ignore = { "W391" },
            maxLineLength = 120,
          },
          jedi_completion = {
            enabled = true,
            include_params = true,
            include_class_objects = true,
            include_function_object = true,
            fuzzy = true,
          },
        },
      },
    },
  },
}

require("lvim.lsp.manager").setup("pylsp", pyLSP)
