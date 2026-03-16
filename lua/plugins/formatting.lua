-- ZENVIM - MINIMAL - SETUP
-- Started on: 31 July, 2025
-- Requires Neovim v0.11.3 and above
-- Assistance by Claude Sonnet v4 and Grok 3
-- See: https://claude.ai/chat/077e450c-ab8a-4aeb-983b-a91f91b2ef72
--      https://grok.com/chat/cefa8717-0aee-4328-bcb6-7d1e1262d897
--

-- load the keymaps configurations
local keymaps = require("config.keymap")

return {
   -- Lightweight yet powerful formatter plugin for Neovim
   -- DOCS: https://github.com/stevearc/conform.nvim
   {
      "stevearc/conform.nvim",
      lazy = false,
      keys = keymaps.conform,
      opts = {
         notify_on_error = false,
         format_on_save = function(bufnr)
            local disable_filetypes = { c = true, cpp = true }
            return {
               timeout_ms = 500,
               lsp_fallback = not disable_filetypes[vim.bo[bufnr].filetype],
            }
         end,
         formatters_by_ft = {
            lua = { "stylua" },
            python = { "black" },
            javascript = { "prettier" },
            typescript = { "prettier" },
            javascriptreact = { "prettier" },
            typescriptreact = { "prettier" },
            css = { "prettier" },
            html = { "prettier" },
            json = { "prettier" },
            yaml = { "prettier" },
            markdown = { "prettier" },
            php = { "php_cs_fixer" },
            ruby = { "rubocop" },
            go = { "gofumpt" },
         },
      },
   },
}

-- cSpell:words stevearc gofumpt rubocop
