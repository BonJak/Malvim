local opts = { noremap = true, silent = true }
function _G.lsp_definition_split()
  vim.cmd("vsplit")
  vim.lsp.buf.definition()
end

-- Conflicts
lvim.builtin.autopairs.fast_wrap.map = "<C-e>"

lvim.keys.normal_mode["<C-s>"] = ":w<cr>"
lvim.keys.normal_mode["<leader><leader>"] = "i"
lvim.keys.normal_mode["<leader>1"] = "<cmd>NeoTreeRevealToggle<CR>"
lvim.keys.normal_mode["<leader>a"] = "<cmd>AerialToggle!<CR><C-w>w"
lvim.keys.normal_mode["<A-y>"] = ":lua OpenBufferInNextSplit()<CR>"
lvim.keys.normal_mode["<A-t>"] = "<CMD>BufferLineCycleNext<CR>"
lvim.keys.normal_mode["<A-u>"] = "<CMD>BufferLineCyclePrev<CR>"
lvim.keys.normal_mode["<A-l>"] = '<cmd>lua require("smart-splits").resize_right()<CR>'
lvim.keys.normal_mode["<A-h>"] = '<cmd>lua require("smart-splits").resize_left()<CR>'
lvim.keys.normal_mode["<A-.>"] = '<cmd>lua require("smart-splits").resize_up()<CR>'
lvim.keys.normal_mode["<A-,>"] = '<cmd>lua require("smart-splits").resize_down()<CR>'
lvim.keys.normal_mode["<A-0>"] = '<C-w>w'
lvim.keys.normal_mode["<A-9>"] = '<C-w>W'
lvim.keys.normal_mode["gp"] = "<cmd>lua show_floating_declaration()<CR>"

-- lvim.keys.
lvim.keys.insert_mode["<leader><leader>"] = "<Esc>"
lvim.keys.insert_mode["<A-b>"] = "<Left>"
lvim.keys.insert_mode["<A-f>"] = "<Right>"
lvim.keys.insert_mode["<A-a>"] = "<Home>"
lvim.keys.insert_mode["<M-e>"] = "<End>"
lvim.keys.insert_mode["<A-p>"] = "<Up>"
lvim.keys.insert_mode["<A-n>"] = "<Down>"
lvim.keys.insert_mode["<A-q>"] = "<C-Left>"
lvim.keys.insert_mode["<A-w>"] = "<cmd>normal! W<CR>"
lvim.keys.insert_mode["<A-t>"] = "<CMD>BufferLineCycleNext<CR>"
lvim.keys.insert_mode["<A-u>"] = "<CMD>BufferLineCyclePrev<CR>"
lvim.keys.insert_mode["<A-0>"] = "<CMD>wincmd w<CR>"
lvim.keys.insert_mode["<A-9>"] = '<CMD>wincmd W<CR>'

lvim.keys.visual_mode["<leader><leader>"] = "<Esc>"

vim.api.nvim_set_keymap("v", "<leader>ti", "<cmd>ToggleTermSendVisualSelection <CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<A-n>", "<Plug>(VM-Find-Under)", { noremap = false, silent = true })
vim.api.nvim_set_keymap("n", "<A-]>", "<Plug>(VM-Add-Cursor-Down)", { noremap = false, silent = true })
vim.api.nvim_set_keymap("n", "<A-[>", "<Plug>(VM-Add-Cursor-Up)", { noremap = false, silent = true })

-- Map the key combination
vim.api.nvim_set_keymap("n", "gv", "<cmd>lua _G.lsp_definition_split()<CR>", opts)
vim.api.nvim_set_keymap("n", "gjb", "<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>", opts)
vim.api.nvim_set_keymap("n", "gjf", "<cmd>lua vim.lsp.diagnostic.goto_next()<CR>", opts)
vim.api.nvim_set_keymap("n", "gjj", "<C-o>", opts)


-- -- which-key
local terminal_helper = require("user.terminal_helper")

lvim.builtin.which_key.setup.plugins.presets = {
  operators = true,
  motions = true,
  text_objects = true,
  windows = true,
  nav = true,
  z = true,
  g = true,
}

lvim.builtin.which_key.mappings["t"] = {
  ["h"] = {
    function()
      terminal_helper.create_new_terminal("horizontal")
    end,
    "Toggle Term horizontal",
  },
  ["v"] = {
    function()
      terminal_helper.create_new_terminal("vertical")
    end,
    "ToggleTerm vertical",
  },
  ["a"] = { "<cmd>ToggleTermToggleAll<cr>", "Toggle all terminals" },
  ["e"] = { "<cmd>TermExec<cr>", "Execute command in terminal" },
  ["s"] = { "<cmd>ToggleTermSendCurrentLine<cr>", "Send current line to terminal" },
  ["u"] = { "<cmd>ToggleTermSendVisualLines<CR>", "send visual lines to terminal" },
  ["x"] = { "<cmd>ToggleTermSendVisualSelection<cr>", "Send visual selection to terminal" },
}

lvim.builtin.which_key.mappings["W"] = { "<cmd>noautocmd w<cr>", "Save without formatting" }
lvim.builtin.which_key.mappings["P"] = { "<cmd>Telescope projects<CR>", "Projects" }
lvim.builtin.which_key.mappings["j"] = { "<cmd>Telescope neoclip<CR>", "Clipboard" }
lvim.builtin.which_key.mappings["1"] = { "<cmd>NeoTreeRevealToggle<CR>", "NeoTree Toggle" }
lvim.builtin.which_key.mappings["v"] = {
  ["h"] = { "<C-w>s", "Horizontal Split" },
  ["v"] = { "<C-w>v", "Vertical Split" },
  ["c"] = { "<C-w>c", "Close current window" },
}

lvim.builtin.which_key.mappings["m"] = {
  -- move to window left
  ["h"] = { "<C-w>h", "Move to window left" },
  -- move to window right
  ["l"] = { "<C-w>l", "Move to window right" },
  -- move to window up
  ["k"] = { "<C-w>k", "Move to window up" },
  -- move to window bottom
  ["j"] = { "<C-w>j", "Move to window bottom" },
}


lvim.builtin.which_key.mappings["S"] = {
  name = "Session",
  c = { "<cmd>lua require('persistence').load()<CR>", "Restore last session for current dir" },
  l = { "<cmd>lua require('persistence').load({last=true})<CR>", "Restore last session" },
  Q = { "<cmd>lua require('persistence').stop()<CR>", "Quit without saving session" },
}

lvim.builtin.which_key.vmappings["i"] = {
  name = "Chat GPT",
  ["c"] = { "<cmd>ChatGPT<CR>", "Chat" },
  ["a"] = { "<cmd>ChatGPTActAs<CR>", "ChatGPT Actor" },
  ["e"] = {
    function()
      local chatgpt = require("chatgpt")
      chatgpt.edit_with_instructions()
    end,
    "Edit with instructions $$",
  },
  ["r"] = {
    -- Actions RUN
    name = "RUN action",
    ["t"] = { "<cmd>ChatGPTRun translate<CR>", "Translate" },
    ["s"] = { "<cmd>ChatGPTRun summarize<CR>", "Summarize" },
    ["o"] = { "<cmd>ChatGPTRun optimize_code<CR>", "Optimize code" },
    ["f"] = { "<cmd>ChatGPTRun fix_bugs<CR>", "Fix bugs" },
    ["e"] = { "<cmd>ChatGPTRun explain_code<CR>", "Explain_code" },
  },
}

lvim.builtin.which_key.mappings["i"] = {
  name = "Chat GPT",
  ["c"] = { "<cmd>ChatGPT<CR>", "Chat" },
  ["a"] = { "<cmd>ChatGPTActAs<CR>", "ChatGPT Actor" },
  ["e"] = {
    function()
      local chatgpt = require("chatgpt")
      chatgpt.edit_with_instructions()
    end,
    "Edit with instructions $$",
  },
  ["r"] = {
    -- Actions RUN
    name = "RUN action",
    ["t"] = { "<cmd>ChatGPTRun translate<CR>", "Translate" },
    ["s"] = { "<cmd>ChatGPTRun summarize<CR>", "Summarize" },
    ["o"] = { "<cmd>ChatGPTRun optimize_code<CR>", "Optimize code" },
    ["f"] = { "<cmd>ChatGPTRun fix_bugs<CR>", "Fix bugs" },
    ["e"] = { "<cmd>ChatGPTRun explain_code<CR>", "Explain_code" },
  },
}

lvim.builtin.which_key.mappings['H'] = { ":LocalHistoryToggle<CR>", "Toggle local history" }

lvim.builtin.which_key.mappings["k"] = {
  ["i"] = { "?^import<CR>o", "Go to last line containing import" }
}
