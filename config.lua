-- --- disable automatic installation of servers
lvim.lsp.installer.setup.automatic_installation = false

-- ---configure a server manually. IMPORTANT: Requires `:LvimCacheReset` to take effect
-- ---see the full default list `:lua =lvim.lsp.automatic_configuration.skipped_servers`
-- vim.list_extend(lvim.lsp.automatic_configuration.skipped_servers, { "pyright", "clangd", "tsserver" })
-- local opts = {} -- check the lspconfig documentation for a list of all possible options
-- require("lvim.lsp.manager").setup("pyright", opts)

-- ---remove a server from the skipped list, e.g. eslint, or emmet_ls. IMPORTANT: Requires `:LvimCacheReset` to take effect
-- ---`:LvimInfo` lists which server(s) are skipped for the current filetype
-- lvim.lsp.automatic_configuration.skipped_servers = vim.tbl_filter(function(server)
--   return server ~= "emmet_ls"
-- end, lvim.lsp.automatic_configuration.skipped_servers)

-- -- you can set a custom on_attach function that will be used for all the language servers
-- -- See <https://github.com/neovim/nvim-lspconfig#keybindings-and-completion>
-- lvim.lsp.on_attach_callback = function(client, bufnr)
--   local function buf_set_option(...)
--     vim.api.nvim_buf_set_option(bufnr, ...)
--   end
--   --Enable completion triggered by <c-x><c-o>
--   buf_set_option("omnifunc", "v:lua.vim.lsp.omnifunc")
-- end

-- -- linters, formatters and code actions <https://www.lunarvim.org/docs/languages#lintingformatting>
-- local formatters = require("lvim.lsp.null-ls.formatters")
-- formatters.setup({
-- 	{ command = "stylua" },
-- 	{
-- 		command = "prettier",
-- 		extra_args = { "--print-width", "100" },
-- 		filetypes = { "typescript", "typescriptreact" },
-- 	},
-- })
-- local linters = require("lvim.lsp.null-ls.linters")
-- linters.setup({
-- 	{ command = "flake8", filetypes = { "python" } },
-- 	{
-- 		command = "shellcheck",
-- 		args = { "--severity", "warning" },
-- 	},
-- 	{
-- 		command = "eslint_d",
-- 		filetypes = { "typescript", "typescriptreact" },
-- 	},
-- 	-- eslint
-- 	{
-- 		command = "eslint",
-- 		filetypes = { "typescript", "typescriptreact" },
-- 	},
-- })
-- local code_actions = require("lvim.lsp.null-ls.code_actions")
-- code_actions.setup({
-- 	{
-- 		exe = "eslint",
-- 		filetypes = { "typescript", "typescriptreact" },
-- 	},
-- })

require("user.options")

require("user.wilder")
require("user.neotreecfg")
require("user.window_pick")
require("mini.bufremove").setup()

require("user.neoclipcfg")
require("user.neorgcfg")
require("user.localHistory")

require("user.smart-splits")
require("user.copilotcfg")
require("user.aerialcfg")

require("user.custom")
require("user.keymapping")
require("user.chatgptcfg")

require("user.formatters")
require("user.linters")
require("user.lsp")

require("user.autocmds")
