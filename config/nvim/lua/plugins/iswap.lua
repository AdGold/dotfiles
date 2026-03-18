return {
  "mizlan/iswap.nvim",
  event = "VeryLazy",
  config = function()
    require('iswap').setup()
    vim.keymap.set("n", "<leader>j", ":ISwapWithLeft<CR>", {})
    vim.keymap.set("n", "<leader>k", ":ISwapWithRight<CR>", {})
    vim.keymap.set("n", "<leader>s", ":ISwapWithCR>", {})
  end,
}
