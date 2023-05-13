lvim.builtin.nvimtree.active = false
lvim.builtin.nvimtree.setup.view.side = "left"
lvim.builtin.nvimtree.setup.renderer.icons.show.git = false
require("neo-tree").setup({
  close_if_last_window = true,
  window = {
    width = 50,
  },
  buffers = {
    follow_current_file = true,
  },
  filesystem = {
    follow_current_file = true,
    filtered_items = {
      hide_dotfiles = false,
      hide_gitignored = false,
      hide_by_name = {
        "node_modules",
      },
      never_show = {
        ".DS_Store",
        "thumbs.db",
      },
    },
  },
  event_handlers = {
    {
      event = "neo_tree_buffer_enter",
      handler = function()
        vim.cmd([[setlocal relativenumber]])
      end,
    }
  },
})
