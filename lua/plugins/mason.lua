-- Zenvim - Minimal Neovim configuration
-- Last updated: 01 October, 2026
-- Mason: package manager, LSP bridging and external tool installer.
--

return {
   -- Mason.nvim - Portable package manager for LSP/DAP/linters/formatters
   -- DOCS: https://github.com/mason-org/mason.nvim
   {
      "mason-org/mason.nvim",
      config = true,
   },
   -- Mason-lspconfig.nvim - Bridge between Mason and nvim-lspconfig
   -- DOCS: https://github.com/mason-org/mason-lspconfig.nvim
   {
      "mason-org/mason-lspconfig.nvim",
      dependencies = {
         --
         -- DOCS: https://github.com/mason-org/mason.nvim
         {
            "mason-org/mason.nvim",
         },
      },
   },
   -- Mason-tool-installer.nvim - Installs non-LSP tools declared by plugins
   -- DOCS: https://github.com/WhoIsSethDaniel/mason-tool-installer.nvim
   {
      "WhoIsSethDaniel/mason-tool-installer.nvim",
      dependencies = {
         --
         -- DOCS: https://github.com/mason-org/mason.nvim
         {
            "mason-org/mason.nvim",
         },
      },
      opts = {
         ensure_installed = {
            "black",
            "gofumpt",
            "luacheck",
            "php-cs-fixer",
            "prettier",
            "rubocop",
            "stylua",
         },
      },
   },
}
