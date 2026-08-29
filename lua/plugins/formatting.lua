local keymaps = require("config.keymap")

return {
   {
      "stevearc/conform.nvim",
      event = { "BufWritePre" },
      cmd = { "ConformInfo" },
      keys = keymaps.conform,
      opts = {
         notify_on_error = false,
         format_on_save = function(bufnr)
            local disable_filetypes = { c = true, cpp = true }
            if disable_filetypes[vim.bo[bufnr].filetype] then return end
            return {
               timeout_ms = 500,
               lsp_format = "fallback",
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

