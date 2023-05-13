require("copilot").setup({
  suggestion = {
    enabled = true,
    auto_trigger = true,
    debounce = 50,
    keymap = {
      accept = "<M-m>",
      accept_word = "<C-f>",
      accept_line = "<C-j>",
      next = "<A-]>",
      prev = "<A-[>",
    },
  },
  panel = { enabled = false },
})
