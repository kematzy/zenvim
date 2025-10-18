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
   {
      -- Persist and toggle multiple terminals during an editing session
      -- DOCS: https://github.com/akinsho/toggleterm.nvim
      "akinsho/toggleterm.nvim",
      version = "*",
      config = true,
      keys = keymaps.toggleterm,
   },
}

-- cSpell:words akinsho toggleterm guifg guibg mgierada
