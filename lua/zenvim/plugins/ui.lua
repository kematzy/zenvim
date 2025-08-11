-- ZENVIM - MINIMAL - SETUP
-- Started on: 31 July, 2025
-- Requires Neovim v0.11.3 and above
-- Assistance by Claude Sonnet v4 and Grok 3
-- See: https://claude.ai/chat/077e450c-ab8a-4aeb-983b-a91f91b2ef72
--      https://grok.com/chat/cefa8717-0aee-4328-bcb6-7d1e1262d897
--

-- load the keymaps configurations
local keymaps = require("zenvim.config.keymaps")
-- load Zen colors and styles
local Zen = require("zenvim.config.zen")

return {
   -- Replaces the UI for messages, cmdline and the popupmenu.
   -- DOCS: https://github.com/folke/noice.nvim
   {
      "folke/noice.nvim",
      event = "VeryLazy",
      dependencies = {
         "MunifTanjim/nui.nvim",
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
      },
   },
   -- WhichKey helps you remember your Neovim keymaps, by showing
   -- available keybindings in a popup as you type.
   -- DOCS: https://github.com/folke/which-key.nvim
   {
      "folke/which-key.nvim",
      event = "VeryLazy",
      init = function()
         vim.o.timeout = true
         vim.o.timeoutlen = 300
      end,
      opts = {
         spec = keymaps.which_key_groups,
      },
   },
   -- Telescope is a highly extendable fuzzy finder over lists, centered around
   -- modularity, allowing for easy customization.
   -- DOCS: https://github.com/nvim-telescope/telescope.nvim
   {
      "nvim-telescope/telescope.nvim",
      dependencies = {
         {
            -- DOCS: https://github.com/nvim-lua/plenary.nvim
            "nvim-lua/plenary.nvim",
         },
         {
            -- DOCS: https://github.com/nvim-telescope/telescope-fzf-native.nvim
            "nvim-telescope/telescope-fzf-native.nvim",
            build = "make",
            cond = function() return vim.fn.executable("make") == 1 end,
         },
         {
            -- DOCS: https://github.com/nvim-telescope/telescope-ui-select.nvim
            "nvim-telescope/telescope-ui-select.nvim",
         },
         {
            -- DOCS: https://github.com/nvim-tree/nvim-web-devicons
            "nvim-tree/nvim-web-devicons",
            enabled = vim.g.have_nerd_font,
         },
      },
      event = "VimEnter",
      branch = "0.1.x",
      config = function()
         require("telescope").setup({
            extensions = {
               ["ui-select"] = {
                  require("telescope.themes").get_dropdown(),
               },
            },
         })

         pcall(require("telescope").load_extension, "fzf")
         pcall(require("telescope").load_extension, "ui-select")
      end,
      -- add keymaps
      keys = keymaps.telescope,
   },
}

-- cSpell:words folke noice cmdline MunifTanjim timeoutlen devicons akinsho toggleterm winblend mgierada globalstatus fileformat
