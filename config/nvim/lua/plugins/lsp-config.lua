return {
  {
    "williamboman/mason.nvim",
    lazy = false,
    config = function()
      require("mason").setup()
    end,
  },
  {
    "williamboman/mason-lspconfig.nvim",
    lazy = false,
    opts = {
      auto_install = true,
    },
    config = function()
      require("mason-lspconfig").setup({
        ensure_installed = {"bash-language-server", "beautysh", "black", "clangd", "cpplint", "cspell-lsp", "css-lsp", "docker-compose-language-service", "docker-language-server", "eslint", "eslint-lsp", "fixjson", "flake8", "html-lsp", "isort", "lua_ls", "lua-language-server", "mdformat", "prettier", "prettierd", "pyright", "python-lsp-server", "stylua", "svelte-language-server", "typescript-language-server"},
      })
    end,
  },
  {
    "neovim/nvim-lspconfig",
    lazy = false,
    config = function()
      local capabilities = require('cmp_nvim_lsp').default_capabilities()

      local lspconfig = require("lspconfig")
       lspconfig.tsserver.setup({
         capabilities = capabilities
       })
       lspconfig.pyright.setup({
        capabilities = capabilities
      })
       lspconfig.html.setup({
         capabilities = capabilities
       })
       lspconfig.lua_ls.setup({
         capabilities = capabilities
       })

      vim.keymap.set("n", "K", vim.lsp.buf.hover, {})
      vim.keymap.set("n", "<leader>gd", vim.lsp.buf.definition, {})
      vim.keymap.set("n", "<leader>gr", vim.lsp.buf.references, {})
      vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, {})
    end,
  },
}
