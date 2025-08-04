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
   -- Replaces the UI for messages, cmdline and the popupmenu.
   -- DOCS: https://github.com/folke/noice.nvim
   {
      "folke/noice.nvim",
      event = "VeryLazy",
      dependencies = {
         "MunifTanjim/nui.nvim",
      },
      opts = {
         cmdline = {
            enabled = true,
            view = "cmdline_popup",
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
         "nvim-lua/plenary.nvim",
         {
            "nvim-telescope/telescope-fzf-native.nvim",
            build = "make",
            cond = function()
               return vim.fn.executable("make") == 1
            end,
         },
         { "nvim-telescope/telescope-ui-select.nvim" },

         -- DOCS: https://github.com/nvim-tree/nvim-web-devicons
         {
           "nvim-tree/nvim-web-devicons",
           enabled = vim.g.have_nerd_font
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
   -- A Neovim plugin to persist and toggle multiple terminals during an editing session
   -- DOCS: https://github.com/akinsho/toggleterm.nvim
   {
      "akinsho/toggleterm.nvim",
      version = "*",
      config = function()
         require("toggleterm").setup({
            size = 20,
            open_mapping = [[<c-\>]],
            hide_numbers = true,
            shade_terminals = true,
            start_in_insert = true,
            insert_mappings = true,
            persist_size = true,
            direction = "float",
            close_on_exit = true,
            shell = vim.o.shell,
            float_opts = {
               border = "curved",
               winblend = 0,
               highlights = {
                  border = "Normal",
                  background = "Normal",
               },
            },
         })
      end,
   },
   -- lazydocker.nvim is a plugin that allows you to manage your Docker
   -- environment without leaving Neovim.
   -- DOCS: https://github.com/mgierada/lazydocker.nvim
   {
      "mgierada/lazydocker.nvim",
      dependencies = { "akinsho/toggleterm.nvim" },
      config = function()
         require("lazydocker").setup({})
      end,
      event = "BufRead",
      -- add keymaps
      keys = keymaps.lazydocker,
   },
}

-- cSpell:words folke noice cmdline MunifTanjim timeoutlen devicons akinsho toggleterm winblend mgierada
