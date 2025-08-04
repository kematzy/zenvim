-- ZENVIM - MINIMAL - SETUP
-- Started on: 31 July, 2025
-- Requires Neovim v0.11.3 and above
-- Assistance by Claude Sonnet v4 and Grok 3
-- See: https://claude.ai/chat/077e450c-ab8a-4aeb-983b-a91f91b2ef72
--      https://grok.com/chat/cefa8717-0aee-4328-bcb6-7d1e1262d897
--

return {
   -- Catppuccin theme
   {
      "catppuccin/nvim",
      name = "catppuccin",
      priority = 1000,
      config = function()
         require("catppuccin").setup({
            flavour = "mocha",
            transparent_background = false,
            integrations = {
               cmp = true,
               gitsigns = true,
               treesitter = true,
               which_key = true,
            },
         })
         vim.cmd.colorscheme("catppuccin")
      end,
   },

   -- A clean, dark Neovim theme with support for LSP, Treesitter and lots of plugins.
   -- DOCS: https://github.com/folke/tokyonight.nvim
   {
      "folke/tokyonight.nvim",
      priority = 1000,
      config = function()
         require("tokyonight").setup({
            style = "night",
            transparent = false,
            terminal_colors = true,
         })
         -- Uncomment to use tokyonight instead
         -- vim.cmd.colorscheme "tokyonight"
      end,
   },
}

-- cSpell:words gitsigns tokyonight
