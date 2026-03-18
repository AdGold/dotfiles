return {
  "nvim-lualine/lualine.nvim",
  config = function()
    require("lualine").setup({
      options = {
        theme = "dracula-nvim",
        sections = {
          lualine_a = {
            file = 1,
          },
          lualine_b = {
            "branch",
          },
        },
      },
    })
  end,
}
