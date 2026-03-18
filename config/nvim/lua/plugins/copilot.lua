return {
    "github/copilot.vim",
    config = function()
        -- require("copilot").setup()
        vim.keymap.set('i', '<C-y>', '<Plug>(copilot-accept-word)')
        vim.keymap.set('i', '<C-l>', '<Plug>(copilot-accept-word)')
    end,
      -- "zbirenbaum/copilot.lua",
      -- cmd = "Copilot",
      -- event = "InsertEnter",
  }
