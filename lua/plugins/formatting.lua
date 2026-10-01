local keymaps = require("config.keymap")

return {
   {
      "stevearc/conform.nvim",
      event = { "BufWritePre" },
      cmd = { "ConformInfo" },
      keys = keymaps.conform,
      opts = {
         notify_on_error = true,
         format_on_save = function(bufnr)
            local disable_filetypes = { c = true, cpp = true }
            if disable_filetypes[vim.bo[bufnr].filetype] then return end
            return {
               timeout_ms = 3000,
               lsp_format = "fallback",
            }
         end,
         formatters = {
            php_cs_fixer = {
               append_args = function(_, ctx)
                  local found = vim.fs.find({
                     ".php-cs-fixer.php",
                     ".php-cs-fixer.dist.php",
                     ".php_cs",
                     ".php_cs.dist",
                  }, {
                     upward = true,
                     path = ctx.dirname,
                     stop = vim.uv.os_homedir(),
                  })
                  if #found > 0 then return {} end
                  return { "--rules=@PSR12" }
               end,
            },
         },
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
