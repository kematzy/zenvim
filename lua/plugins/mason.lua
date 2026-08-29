return {
   {
      "mason-org/mason.nvim",
      config = true,
   },
   {
      "mason-org/mason-lspconfig.nvim",
      dependencies = { "mason-org/mason.nvim" },
   },
   {
      "WhoIsSethDaniel/mason-tool-installer.nvim",
      dependencies = { "mason-org/mason.nvim" },
      opts = {
         ensure_installed = {
            "black",
            "gofumpt",
            "luacheck",
            "php-cs-fixer",
            "prettier",
            "rubocop",
            "shellcheck",
            "stylua",
         },
      },
   },
}

