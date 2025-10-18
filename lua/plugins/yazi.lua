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
   -- A Neovim Plugin for the `yazi` terminal file manage
   -- DOCS: https://github.com/mikavilpas/yazi.nvim
   ---@type LazySpec
   {
      "mikavilpas/yazi.nvim",
      event = "VeryLazy",
      dependencies = {
         { "nvim-lua/plenary.nvim", lazy = true },
      },

      keys = keymaps.yazi,

      ---@type YaziConfig | {}
      opts = {
         keymaps = {
            show_help = "<f1>",
         },
         -- if you want to open yazi instead of netrw, see below for more info
         open_for_directories = false,
         -- the floating window scaling factor. 1 means 100%, 0.9 means 90%, etc.
         floating_window_scaling_factor = 0.85,
      },
      -- if you use `open_for_directories=true`, this is recommended
      init = function()
         -- mark netrw as loaded so it's not loaded at all.
         -- Details: https://github.com/mikavilpas/yazi.nvim/issues/802
         vim.g.loaded_netrwPlugin = 1
      end,
   },
}

-- cSpell:words mikavilpas keymappings
