-- ZENVIM - MINIMAL - SETUP
-- Started on: 31 July, 2025
-- Requires Neovim v0.11.3 and above
-- Assistance by Claude Sonnet v4 and Grok 3
-- See: https://claude.ai/chat/077e450c-ab8a-4aeb-983b-a91f91b2ef72
--      https://grok.com/chat/cefa8717-0aee-4328-bcb6-7d1e1262d897
--

-- load the keymaps configurations
local keymaps = require("zenvim.config.keymaps")

return {
   -- Calling `lazygit` from within Neovim.
   -- DOCS: https://github.com/kdheepak/lazygit.nvim
   {
      "kdheepak/lazygit.nvim",
      lazy = true,
      cmd = {
         "LazyGit",
         "LazyGitConfig",
         "LazyGitCurrentFile",
         "LazyGitFilter",
         "LazyGitFilterCurrentFile",
      },
      -- optional for floating window border decoration
      dependencies = {
         -- A collection of Lua functions
         -- DOCS: https://github.com/nvim-lua/plenary.nvim
         { "nvim-lua/plenary.nvim" },
      },

      config = function()
         -- scaling factor for floating window
         vim.g.lazygit_floating_window_scaling_factor = 0.85
      end,

      keys = keymaps.lazygit,
   },
}

-- cSpell:words kdheepak
