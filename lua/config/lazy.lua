-- ZENVIM - MINIMAL - SETUP
-- Started on: 31 July, 2025
-- Requires Neovim v0.11.3 and above
-- Assistance by Claude Sonnet v4 and Grok 3
-- See: https://claude.ai/chat/077e450c-ab8a-4aeb-983b-a91f91b2ef72
--      https://grok.com/chat/cefa8717-0aee-4328-bcb6-7d1e1262d897
--

-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
   local lazyrepo = "https://github.com/folke/lazy.nvim.git"
   local out =
      vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
   if vim.v.shell_error ~= 0 then
      vim.api.nvim_echo({
         { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
         { out, "WarningMsg" },
         { "\nPress any key to exit..." },
      }, true, {})
      vim.fn.getchar()
      os.exit(1)
   end
end
vim.opt.rtp:prepend(lazypath)

-- Make sure to setup `mapleader` and `maplocalleader` before
-- loading lazy.nvim so that mappings are correct.
-- This is also a good place to setup other settings (vim.opt)
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Setup lazy.nvim
require("lazy").setup({
   spec = {
      -- import your plugins
      { import = "plugins" },
   },
   -- Configure any other settings here. See the documentation for more details.
   -- colorscheme that will be used when installing plugins.
   install = { colorscheme = { "habamax" } },
   -- automatically check for plugin updates
   checker = { enabled = true },

   -- Performance optimizations
   performance = {
      rtp = {
         -- Disable some built-in plugins for better startup time
         disabled_plugins = {
            "gzip",
            "netrwPlugin",
            "tarPlugin",
            "tohtml",
            "tutor",
            "zipPlugin",
         },
      },
   },

   -- UI configuration
   ui = {
      -- The border to use for the UI window. Accepts same border values as nvim_open_win().
      border = "rounded",
      -- The backdrop opacity. 0 is fully opaque, 100 is fully transparent.
      backdrop = 60,
      icons = {
         cmd = " ",
         config = " ",
         event = " ",
         ft = " ",
         init = " ",
         import = " ",
         keys = " ",
         lazy = " ",
         loaded = "●",
         not_loaded = "○",
         plugin = " ",
         runtime = " ",
         require = " ",
         source = " ",
         start = " ",
         task = " ",
         list = {
            "●",
            "➜",
            "★",
            "‒",
         },
      },
   },

   debug = false,
   defaults = {
      lazy = false,
      version = false,
   },
})

