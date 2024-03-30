local formatters = require("lvim.lsp.null-ls.formatters")
formatters.setup({
  {
    exe = "prettier",
    args = { "--print-width=120" },
    filetypes = {
      "javascriptreact",
      "javascript",
      "typescriptreact",
      "typescript",
      "json",
      "markdown",
      "html",
      "css",
      "yaml",
      "qml"
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
