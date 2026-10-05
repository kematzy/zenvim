-- Zenvim - Minimal Neovim configuration
-- Last updated: 01 October, 2026
-- UI: noice cmdline/messages and which-key keybinding hints.
--

-- load the keymaps configurations
local keymaps = require("config.keymap")

return {
   -- Replaces the UI for messages, cmdline and the popupmenu.
   -- DOCS: https://github.com/folke/noice.nvim
   {
      "folke/noice.nvim",
      event = "VeryLazy",
      dependencies = {
         -- nui.nvim - UI component library
         -- DOCS: https://github.com/MunifTanjim/nui.nvim
         {
            "MunifTanjim/nui.nvim",
         },
      },
      ---@class NoiceConfig
      opts = {
         cmdline = {
            enabled = true,
            view = "cmdline_popup",
            format = {
               cmdline = { pattern = "^:", icon = "❯", lang = "vim", title = " Command " },
            },
         },
         ---@type NoiceConfigViews
         views = {
            cmdline_popup = {
               border = {
                  style = "rounded",
                  padding = { 0, 1 }, -- { vertical, horizontal }
               },
            },
         },
         -- Fidget draws LSP progress. Blink draws signature help.
         lsp = {
            progress = { enabled = false },
            signature = { enabled = false },
         },
      },
   },
   -- WhichKey helps you remember your Neovim keymaps, by showing
   -- available keybindings in a popup as you type.
   -- DOCS: https://github.com/folke/which-key.nvim
   {
      "folke/which-key.nvim",
      event = "VeryLazy",
      opts = {
         spec = keymaps.which_key_groups,
      },
   },
}
