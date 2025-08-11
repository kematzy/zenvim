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
               snacks = {
                  enabled = true,
                  indent_scope_color = "gray",
               },
               telescope = {
                  enabled = true,
               },
               treesitter = true,
               which_key = true,
            },
            custom_highlights = function(colors)
               return {
                  -- Noice.nvim changes
                  NoiceCmdlinePopup = { fg = colors.text },
                  NoiceCmdlinePopupBorder = { fg = colors.peach },

                  -- FloatBorder = { fg = colors.surface1 },
                  -- Lualine.nvim changes
                  TabLine = { bg = colors.purple, fg = colors.blue },
                  -- TabLineFill = { bg = colors.blue },
                  --
                  --
                  -- SNACKS.nvim
                  SnacksDashboardHeader = { fg = "#566886" },
                  SnacksDashboardStartup = { fg = colors.green },
                  SnacksDashboardFooter = { fg = "#566886" },
                  SnacksDashboardSpecial = { fg = "#5F7AA8" },
                  SnacksDashboardTitle = { fg = "#566886" },
                  SnacksDashboardDesc = { fg = "#4B6BA3" },
                  SnacksDashboardIcon = { fg = colors.overlay1 },

                  SnacksPicker = { fg = colors.text, bg = colors.base },
                  SnacksPickerTitle = { fg = colors.blue, bg = colors.base },
                  SnacksPickerInput = { fg = colors.text, bg = colors.base },
                  SnacksPickerBorder = { fg = colors.base, bg = colors.base },

                  ToggleTerm1Border = { fg = colors.text, bg = colors.peach },
                  -- mikavilpas/yazi.nvim
                  YaziFloatBorder = { fg = colors.peach, bg = colors.base },
                  -- kdheepak/lazygit.nvim
                  LazyGitBorder = { fg = colors.peach, bg = colors.base },

                  -- Comment = { fg = colors.flamingo },
                  -- TabLineSel = { bg = colors.pink },
                  -- CmpBorder = { fg = colors.surface2 },
                  -- Pmenu = { bg = colors.none },
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

-- cSpell:words gitsigns tokyonight Noice Cmdline kdheepak mikavilpas
