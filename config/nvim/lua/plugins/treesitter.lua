return {
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    event = {"BufReadPre", "BufNewFile"},
    config = function()
      local config = require("nvim-treesitter.configs")
      config.setup({
        ensure_installed = {"lua", "javascript", "python", "typescript", "tsx", "json", "vim", "bash", "markdown", "gitignore"},
        auto_install = true,
        highlight = { enable = true },
        indent = { enable = true },
        incremental_selection = { enable = true,
            keymaps = {
                init_selection = "<leader>v",
                node_incremental = "<leader>v",
                scope_incremental = false,
                node_decremental = "<bs>",
            },
            },
      })
    end
  }
}
