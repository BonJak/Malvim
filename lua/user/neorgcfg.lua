require("neorg").setup({
  load = {
    ["core.defaults"] = {},  -- Loads default behaviour
    ["core.concealer"] = {}, -- Adds pretty icons to your documents
    ["core.dirman"] = {      -- Manages Neorg workspaces
      config = {
        workspaces = {
          home = "~/notes/home",
        },
        index = "index.norg", -- The name of the main (root) .norg file
        autochdir = true,     -- Whether to automatically change the working directory
        use_popup = true,     -- Enables a floating window, can also be used with `autocmd`
      },
    },
  },
})
