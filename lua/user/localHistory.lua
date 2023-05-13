local utils = require('user.utils')
local find_root_dir = utils.find_root_dir


vim.g.local_history_path = find_root_dir() .. '/.local_history'
vim.g.local_history_max_changes = 1000

vim.g.local_history_exclude = { '.git', '.hg', '.svn', '.DS_Store', '.local_history', 'node_modules', 'cache', '.next',
  'build', 'dist', '.idea', '.vscode', '.cache', '.mason', '.mason-lspconfig' }
