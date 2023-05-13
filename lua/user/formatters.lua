local formatters = require("lvim.lsp.null-ls.formatters")
formatters.setup({
  {
    exe = "prettier",
    filetypes = {
      "javascriptreact",
      "javascript",
      "typescriptreact",
      "typescript",
      "json",
      "markdown",
    },
  },
  {
    exe = "black",
    filetypes = { "python" },
  },
  {
    exe = "buf",
    filetypes = { "proto" },
  }
})
