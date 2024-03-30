-- vim options
vim.opt.shiftwidth = 2
vim.opt.tabstop = 2
vim.opt.relativenumber = true
vim.opt.clipboard:append("unnamedplus")
vim.opt.wildmode = { "longest:full", "full", "list" }
vim.opt.wildmenu = true
vim.opt.wildignorecase = true
vim.opt.wildcharm = 26
vim.opt.wildignore = ""

-- general
lvim.log.level = "info"

lvim.builtin.alpha.active = true
lvim.builtin.alpha.mode = "dashboard"
lvim.builtin.terminal.active = true

-- Automatically install missing parsers when entering buffer
lvim.builtin.treesitter.auto_install = true
-- -- always installed on startup, useful for parsers without a strict filetype
lvim.builtin.treesitter.ensure_installed = { "comment", "markdown_inline", "regex",
  "bash",
  "c", "javascript", "lua", "json", "typescript", "css", "html", "yaml", "toml", "python", "cpp", "rust",
}
-- lvim.builtin.treesitter.rainbow.enable = true

lvim.format_on_save = {
  enabled = true,
  pattern = { "*.lua", "*.js", "*.jsx", "*.ts", "*.tsx", "*.go", "*.html", "*.css", "*.json", "*.md", "*.py", "*.proto" },
  timeout = 1000,
}


lvim.builtin.telescope.defaults.layout_config = {
  prompt_position = "top",
  horizontal = {
    width_padding = 0.1,
    height_padding = 0.1,
    preview_width = 0.6,
  },
  vertical = {
    width_padding = 0.05,
    height_padding = 1,
    preview_height = 0.5,
  },
  width = 0.6,
  height = 0.6,
  preview_cutoff = 120,
}
lvim.builtin.telescope.defaults.preview=true
lvim.builtin.telescope.defaults.file_ignore_patterns = { "node_modules", ".git" }
lvim.builtin.telescope.defaults.layout_strategy = "horizontal"




lvim.builtin.telescope.on_config_done = function(telescope)
  pcall(telescope.load_extension, "frecency")
  pcall(telescope.load_extension, "neoclip")
  pcall(telescope.load_extension, "fzy_native")
  pcall(telescope.load_extension, "aerial")
  pcall(telescope.load_extension, "material")
end

lvim.plugins = {
  -- COLOR Schemes --
  {
    'marko-cerovac/material.nvim'
  },
  {
  "peterhoeg/vim-qml",
  event = "BufRead",
  ft = { "qml" },
},
  {
    "tokyonight.nvim",
    lazy = false,
    priority = 1000,
    opts = {},
  },
  {
    "folke/trouble.nvim",
    cmd = "TroubleToggle",
  },
  {
    "norcalli/nvim-colorizer.lua",
    config = function()
      require("colorizer").setup()
    end,

  },
  {
    "romgrk/fzy-lua-native",
  },
{
    's1n7ax/nvim-window-picker',
    name = 'window-picker',
    event = 'VeryLazy',
    version = '2.*',
    config = function()
        require'window-picker'.setup()
    end,
},
  {
    "kylechui/nvim-surround",
    version = "*", -- Use for stability; omit to use `main` branch for the latest features
    event = "VeryLazy",
    config = function()
      require("nvim-surround").setup({
        -- Configuration here, or leave empty to use defaults
      })
    end
  },
  { "echasnovski/mini.bufremove", version = "*" },
  {
    "mrjones2014/smart-splits.nvim",
  },
  {
    "AckslD/nvim-neoclip.lua",
    dependencies = { "kkharji/sqlite.lua" },
  },
  {
    "folke/persistence.nvim",
    event = "BufReadPre", -- this will only start session saving when an actual file was opened
    config = function()
      require("persistence").setup({
        dir = vim.fn.expand(vim.fn.stdpath("config") .. "/session/"),
        options = { "buffers", "curdir", "tabpages", "winsize" },
      })
    end,
  },
  {
    "mg979/vim-visual-multi",
    branch = "master",
  },
  {
    "dinhhuy258/vim-local-history",
    branch = "master",
    build = ":UpdateRemotePlugins",
  },
  {
    "zbirenbaum/copilot-cmp",
    event = "InsertEnter",
    dependencies = { "zbirenbaum/copilot.lua" },
    config = function()
      vim.defer_fn(function()
        require("copilot").setup()     -- https://github.com/zbirenbaum/copilot.lua/blob/master/README.md#setup-and-configuration
        require("copilot_cmp").setup() -- https://github.com/zbirenbaum/copilot-cmp/blob/master/README.md#configuration
      end, 100)
    end,
  },
  {
    "nvim-neorg/neorg",
    build = ":Neorg sync-parsers",
    dependencies = "nvim-lua/plenary.nvim",
  },
  {
    "windwp/nvim-ts-autotag",
    config = function()
      require("nvim-ts-autotag").setup()
    end,
  },
  {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v2.x",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons",
      "MunifTanjim/nui.nvim",
    },
    config = function()
    end,
  },
  {
    "gelguy/wilder.nvim",
  },
  -- {
  --   "jackMort/ChatGPT.nvim",
  --   config = function()
  --     require("chatgpt").setup()
  --   end,
  --   dependencies = {
  --     "nvim-lua/plenary.nvim",
  --     "nvim-telescope/telescope.nvim",
  --     "nvim-telescope/telescope-fzy-native.nvim",
  --   },
  -- },
  {
    'stevearc/aerial.nvim',
  }
}
