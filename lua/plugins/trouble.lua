-- Zenvim - Minimal Neovim configuration
-- Last updated: 29 August, 2026
-- Trouble: diagnostics and list viewer.
--

local keymaps = require("config.keymap")

return {
   -- Trouble.nvim - Pretty diagnostics and list viewer
   -- DOCS: https://github.com/folke/trouble.nvim
   {
      "folke/trouble.nvim",
      opts = {},
      cmd = "Trouble",
      keys = keymaps.trouble,
   },
}
