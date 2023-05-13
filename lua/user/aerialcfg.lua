require('aerial').setup({
  backends = { "treesitter", "lsp", "markdown", "man" },
  layout = {
    max_width = { 80, 0.2 },
    width = nil,
    min_width = 50,
    win_opts = {
      winblend = 10,
      relativenumber = true,
    },
    -- default_direction = "float",
    default_direction = "prefer_right",
    placement = "window",

    preserve_equality = false,
  },
  attach_mode = "window",
  keymaps = {
    ["?"] = "actions.show_help",
    ["g?"] = "actions.show_help",
    ["<CR>"] = "actions.jump",
    ["<2-LeftMouse>"] = "actions.jump",
    ["<C-v>"] = "actions.jump_vsplit",
    ["<C-s>"] = "actions.jump_split",
    ["p"] = "actions.scroll",
    ["<C-j>"] = "actions.down_and_scroll",
    ["<C-k>"] = "actions.up_and_scroll",
    ["{"] = "actions.prev",
    ["}"] = "actions.next",
    ["[["] = "actions.prev_up",
    ["]]"] = "actions.next_up",
    ["q"] = "actions.close",
    ["o"] = "actions.tree_toggle",
    ["za"] = "actions.tree_toggle",
    ["O"] = "actions.tree_toggle_recursive",
    ["zA"] = "actions.tree_toggle_recursive",
    ["l"] = "actions.tree_open",
    ["zo"] = "actions.tree_open",
    ["L"] = "actions.tree_open_recursive",
    ["zO"] = "actions.tree_open_recursive",
    ["h"] = "actions.tree_close",
    ["zc"] = "actions.tree_close",
    ["H"] = "actions.tree_close_recursive",
    ["zC"] = "actions.tree_close_recursive",
    ["zr"] = "actions.tree_increase_fold_level",
    ["zR"] = "actions.tree_open_all",
    ["zm"] = "actions.tree_decrease_fold_level",
    ["zM"] = "actions.tree_close_all",
    ["zx"] = "actions.tree_sync_folds",
    ["zX"] = "actions.tree_sync_folds",
  },
  lazy_load = true,
  disable_max_lines = 10000,
  disable_max_size = 2000000, -- Default 2MB
  filter_kind = {
    "Class",
    "Constructor",
    "Enum",
    "Function",
    "Interface",
    "Module",
    "Method",
    "Struct",
    -- "Variable",
    "Constant",
    "Parameter",
  },
  icons = {
    ["Class"] = " ",
    ["Constructor"] = " ",
    ["Enum"] = "練",
    ["Function"] = " ",
    ["Interface"] = "ﰮ ",
    ["Module"] = " ",
    ["Method"] = " ",
    ["Struct"] = " ",
    -- ["Variable"] = " ",
    ["Constant"] = "ﲀ ",
    ["Parameter"] = "ﳤ ",
  },
  manage_folds = true,
  link_folds_to_tree = false,
  link_tree_to_folds = true,

  -- Enumerate all headings and calculate the fold level for each one
  -- enumerate = function(bufnr)
  --   local items = {}
  --   local lines = vim.api.nvim_buf_get_lines(bufnr, 0, -1, false)
  --   for lnum, line in ipairs(lines) do
  --     local level = vim.fn.match(line, [[^\#+]])
  --     if level > 0 then
  --       local text = vim.fn.trim(vim.fn.substitute(line, [[^\#+\s*]], '', ''))
  --       table.insert(items, {
  --         level = level,
  --         lnum = lnum,
  --         text = text,
  --       })
  --     end
  --   end
  --   return items
  -- end,
  -- Specify the default symbol for headings
  -- default_symbol = '○',
  -- Specify the default grouping function
  -- Available grouping functions: item, line, enumerated, none
  -- group_by = 'enumerated',
  -- Enable trimming of leading and trailing whitespace from headings
  -- trim_whitespace = false,
  -- -- Enable compact mode
  -- -- When enabled, the cursor will be moved to the first entry in a group
  -- -- whenever that group is collapsed
  -- compact = true,
  -- -- Enable cursorline
  -- cursorline = true,
  -- -- Enable signcolumn
  -- signcolumn = 'yes',
  -- -- Specify a highlight group for the currently focused symbol
  -- focus_highlight = 'AerialFocusedSymbol',
  -- -- Specify a highlight group for the opened folds
  -- opened_tree_hl = 'AerialOpenedTree',
  -- -- Specify a highlight group for the closed folds
  -- closed_tree_hl = 'AerialClosedTree',
  -- -- Enable highlighting of the current symbol
  -- -- If this is set to true, the highlight group defined below will be used
  -- current_symbol = true,
  -- -- Specify a highlight group for the current symbol
  -- current_symbol_hl = 'AerialCurrentSymbol',
  -- -- Enable the 'hidden' option for 'signcolumn'
  -- -- If this is set to false, the signcolumn will be displayed permanently
  -- hide_signcolumn = true,
  -- -- Enable the 'relativenumber' option for 'number'
  -- -- If this is set to false, absolute line numbers will be displayed
  -- relative_number = true,
  -- -- Enable the 'number' option for 'number'
  -- -- If this is set to false, line numbers will be disabled
  -- number = true,
  float = {
    -- Controls border appearance. Passed to nvim_open_win
    border = "rounded",

    -- Determines location of floating window
    --   cursor - Opens float on top of the cursor
    --   editor - Opens float centered in the editor
    --   win    - Opens float centered in the window
    relative = "editor",

    -- These control the height of the floating window.
    -- They can be integers or a float between 0 and 1 (e.g. 0.4 for 40%)
    -- min_height and max_height can be a list of mixed types.
    -- min_height = {8, 0.1} means "the greater of 8 rows or 10% of total"
    max_height = 0.9,
    height = nil,
    min_height = { 8, 0.1 },

    override = function(conf, source_winid)
      -- This is the config that will be passed to nvim_open_win.
      -- Change values here to customize the layout
      return conf
    end,
  },

  -- Options for the floating nav windows
  nav = {
    border = "rounded",
    max_height = 0.9,
    min_height = { 10, 0.1 },
    max_width = 0.5,
    min_width = { 0.2, 20 },
    win_opts = {
      cursorline = true,
      winblend = 10,
    },
    autojump = false,
    -- Show a preview of the code in the right column, when there are no child symbols
    preview = true,
    -- Keymaps in the nav window
    keymaps = {
      ["<CR>"] = "actions.jump",
      ["<2-LeftMouse>"] = "actions.jump",
      ["<C-v>"] = "actions.jump_vsplit",
      ["<C-s>"] = "actions.jump_split",
      ["h"] = "actions.left",
      ["l"] = "actions.right",
      ["<C-c>"] = "actions.close",
    },
  },
  treesitter = {
    -- How long to wait (in ms) after a buffer change before updating
    update_delay = 300,
  },

  markdown = {
    update_delay = 300,
  },

  man = {
    update_delay = 300,
  },
})
