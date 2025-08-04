-- ZENVIM - MINIMAL - SETUP
-- Started on: 31 July, 2025
-- Requires Neovim v0.11.3 and above
-- Assistance by Claude Sonnet v4 and Grok 3
-- See: https://claude.ai/chat/077e450c-ab8a-4aeb-983b-a91f91b2ef72
--      https://grok.com/chat/cefa8717-0aee-4328-bcb6-7d1e1262d897
--

return {
   -- Mason (must load first)
   {
      "williamboman/mason.nvim",
      config = true,
   },

   -- Mason LSP Config
   {
      "williamboman/mason-lspconfig.nvim",
      dependencies = { "williamboman/mason.nvim" },
      config = function()
         require("mason-lspconfig").setup({
            ensure_installed = {
               "bashls",
               "cssls",
               "gopls",
               "html",
               "intelephense",
               "jsonls",
               "lua_ls",
               "marksman",
               "pyright",
               "solargraph",
               "taplo",
               "yamlls",
            },
         })
      end,
   },

   -- Mason Tool Installer
   -- DOCS: https://github.com/WhoIsSethDaniel/mason-tool-installer.nvim
   {
      "WhoIsSethDaniel/mason-tool-installer.nvim",
      dependencies = { "williamboman/mason.nvim" },
      config = function()
         require("mason-tool-installer").setup({
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
         })
      end,
   },
}


-- cSpell:words williamboman lspconfig cssls jsonls yamlls taplo bashls pyright gopls gofumpt
