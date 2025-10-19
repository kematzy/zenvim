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
            float = {
               transparent = false, -- enable transparent floating windows
               solid = false, -- use solid styling for floating windows, see |winborder|
            },
            integrations = {
               cmp = true,
               gitsigns = true,
               snacks = {
                  enabled = true,
                  indent_scope_color = "blue",
               },
               telescope = {
                  enabled = true,
               },
               treesitter = true,
               which_key = true,
            },
            custom_highlights = function(colors)
               return {
                  -- folke/noice.nvim
                  NoiceCmdlinePopup = { fg = colors.text },
                  NoiceCmdlinePopupBorder = { fg = colors.peach },

                  -- nvim-lualine/lualine.nvim
                  TabLine = { bg = colors.lavender, fg = colors.blue },
                  -- TabLineFill = { bg = colors.blue },

                  -- folke/snacks.nvim
                  SnacksDashboardHeader = { fg = "#566886" },
                  SnacksDashboardStartup = { fg = colors.green },
                  SnacksDashboardFooter = { fg = "#566886" },
                  SnacksDashboardSpecial = { fg = "#5F7AA8" },
                  SnacksDashboardTitle = { fg = "#566886" },
                  SnacksDashboardDesc = { fg = "#4B6BA3" },
                  SnacksDashboardIcon = { fg = colors.overlay1 },
                  SnacksDashboardTerminal = { fg = colors.overlay1, bg = colors.base },
                  -- SnacksDashboardTerminalBorder = { fg = colors.green, bg = colors.base },
                  SnacksDashboardBorderTerminal = { fg = colors.green, bg = colors.base },
                  -- SnacksDashboardItemBorder = { fg = colors.green, bg = colors.base },
                  SnacksDashboardBorder = { fg = colors.green, bg = colors.base },
                  --
                  SnacksPicker = { fg = colors.text, bg = colors.base },
                  SnacksPickerTitle = { fg = colors.blue, bg = colors.base },
                  SnacksPickerInput = { fg = colors.text, bg = colors.base },
                  SnacksPickerBorder = { fg = colors.base, bg = colors.base },

                  -- akinsho/toggleterm.nvim
                  ToggleTerm1Border = { fg = colors.text, bg = colors.peach },
                  -- mikavilpas/yazi.nvim
                  YaziFloatBorder = { fg = colors.peach, bg = colors.base },
                  -- kdheepak/lazygit.nvim
                  LazyGitBorder = { fg = colors.peach, bg = colors.base },
               }
            end,
         })
         vim.cmd.colorscheme("catppuccin")
      end,
   },

   -- A clean, dark Neovim theme with support for LSP, Treesitter and lots of plugins.
   -- DOCS: https://github.com/folke/tokyonight.nvim
   {
      "folke/tokyonight.nvim",
      lazy = false,
      priority = 1000,
      opts = {},
      config = function()
         -- Uncomment to use tokyonight instead
         -- vim.cmd.colorscheme "tokyonight"
      end,
   },
}

-- cSpell:words winborder gitsigns tokyonight Noice Cmdline kdheepak mikavilpas akinsho toggleterm
