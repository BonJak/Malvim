local M = {}
local util = require('lspconfig').util
local bin_name = "pyright-langserver"
local cmd = { bin_name, "--stdio" }

if vim.fn.has("win32") == 1 then
  cmd = { "cmd.exe", "/C", bin_name, "--stdio" }
end

local root_files = {
  "pyproject.toml",
  "setup.py",
  "setup.cfg",
  "requirements.txt",
  "Pipfile",
  "pyrightconfig.json",
}

local function organize_imports()
  local params = {
    command = "pyright.organizeimports",
    arguments = { vim.uri_from_bufnr(0) },
  }
  vim.lsp.buf.execute_command(params)
end

local function set_python_path(path)
  local clients = vim.lsp.get_active_clients({
    bufnr = vim.api.nvim_get_current_buf(),
    name = "pyright",
  })
  for _, client in ipairs(clients) do
    client.config.settings =
        vim.tbl_deep_extend("force", client.config.settings, { python = { pythonPath = path } })
    client.notify("workspace/didChangeConfiguration", { settings = nil })
  end
end
local function get_pipenv_python_path()
  local handle = io.popen("pipenv --venv")
  local result = handle:read("*a")
  handle:close()
  return result:gsub("\n", "") .. "/bin/python"
end
local pyright = {
  default_config = {
    cmd = cmd,
    filetypes = { "python" },
    root_dir = util.root_pattern(unpack(root_files)),
    single_file_support = true,
    settings = {
      python = {
        analysis = {
          autoSearchPaths = true,
          useLibraryCodeForTypes = true,
          diagnosticMode = "workspace",
          configPath = os.getenv("HOME") .. "/.pyrightconfig/pyrightconfig.json",
          autoImportCompletions = true,
          typeCheckingMode = "off",
        },
        pythonPath = get_pipenv_python_path(),
      },
    },
  },
  commands = {
    PyrightOrganizeImports = {
      organize_imports,
      description = "Organize Imports",
    },
    PyrightSetPythonPath = {
      set_python_path,
      description = "Reconfigure pyright with the provided python path",
      nargs = 1,
      complete = "file",
    },
  },
  docs = {
    description = [[
https://github.com/microsoft/pyright

`pyright`, a static type checker and language server for python
]],
  },
}

M.pyright = pyright

return M
