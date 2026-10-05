-- Zenvim - Minimal Neovim configuration
-- Last updated: 01 October, 2026
-- Terminal: toggleterm floating terminal integration.
--

local Zen = require("config.zen")
local keymaps = require("config.keymap")

return {
   -- Toggleterm.nvim - Terminal management for Neovim
   -- DOCS: https://github.com/akinsho/toggleterm.nvim
   {
      "akinsho/toggleterm.nvim",
      version = "*",
      opts = {
         highlights = {
            FloatBorder = {
               guifg = Zen.palette.terminal_border,
               guibg = Zen.palette.terminal_bg,
            },
         },
      },
      config = function(_, opts)
         require("toggleterm").setup(opts)
         -- Buffer-local so Space is not delayed in every terminal.
         vim.api.nvim_create_autocmd("TermOpen", {
            group = vim.api.nvim_create_augroup("zenvim-toggleterm", { clear = true }),
            pattern = "term://*#toggleterm#*",
            callback = function(event)
               vim.keymap.set("t", "<leader>tt", "<cmd>ToggleTerm<cr>", {
                  buffer = event.buf,
                  silent = true,
                  desc = "Terminal",
               })
            end,
         })
      end,
      keys = keymaps.toggleterm,
   },
}
