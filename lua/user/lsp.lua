-- Python
local pycfg = require("lsp_servers.pyright").pyright
vim.list_extend(lvim.lsp.automatic_configuration.skipped_servers, { "pyright" })
require("lvim.lsp.manager").setup("pyright", pycfg.default_config)

-- Protocol Buffers
local bufls_cfg = require("lsp_servers.bufls").bufls
vim.list_extend(lvim.lsp.automatic_configuration.skipped_servers, { "bufls" })
require("lvim.lsp.manager").setup("bufls", bufls_cfg.default_config)

local tss_cfg = require("lsp_servers.tsserver").tsserver
vim.list_extend(lvim.lsp.automatic_configuration.skipped_servers, { "tsserver" })
require("lvim.lsp.manager").setup("tsserver", tss_cfg.default_config)
