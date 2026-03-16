-- ZENVIM - MINIMAL - SETUP
-- Started on: 31 July, 2025
-- Requires Neovim v0.11.3 and above
-- Assistance by Claude Sonnet v4 and Grok 3
-- See: https://claude.ai/chat/077e450c-ab8a-4aeb-983b-a91f91b2ef72
--      https://grok.com/chat/cefa8717-0aee-4328-bcb6-7d1e1262d897
--

-- load the keymaps configurations
local keymaps = require("config.keymap")
-- load Zen colors and styles
local Zen = require("config.zen")

return {
   -- Manage your Docker environment within Neovim.
   -- DOCS: https://github.com/mgierada/lazydocker.nvim
   {
      "mgierada/lazydocker.nvim",
      dependencies = {
         -- Persist and toggle multiple terminals during an editing session
         -- DOCS: https://github.com/akinsho/toggleterm.nvim
         {
            "akinsho/toggleterm.nvim",
            version = "*",
            opts = {
               highlights = {
                  FloatBorder = {
                     guifg = Zen.palette.terminal_border,
                     guibg = Zen.palette.terminal_bg, -- border background
                  },
               },
               float_opts = {
                  -- width = 180, -- counted in terminal columns
                  -- height = 34, -- counted in terminal columns
               },
            },
         },
      },
      config = function()
         require("lazydocker").setup({
            -- valid options are "single" | "double" | "shadow" | "curved"
            border = "curved",
         })
      end,
      event = "BufRead",
      keys = keymaps.lazydocker,
   },
}

-- cSpell:words mgierada akinsho toggleterm guifg guibg lazydocker
