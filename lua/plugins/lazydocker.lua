-- Zenvim - Minimal Neovim configuration
-- Last updated: 29 August, 2026
-- Lazydocker integration for managing Docker from Neovim.
--

local keymaps = require("config.keymap")

return {
   -- Lazydocker.nvim - Lazydocker TUI inside Neovim
   -- DOCS: https://github.com/mgierada/lazydocker.nvim
   {
      "mgierada/lazydocker.nvim",
      dependencies = {
         -- Toggleterm.nvim - Terminal management for Neovim
         -- DOCS: https://github.com/akinsho/toggleterm.nvim
         {
            "akinsho/toggleterm.nvim",
         },
      },
      event = "VeryLazy",
      keys = keymaps.lazydocker,
      opts = {
         border = "curved",
      },
   },
}
