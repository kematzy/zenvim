-- Zenvim - Minimal Neovim configuration
-- Last updated: 01 October, 2026
-- lazy.nvim bootstrap and plugin manager configuration.
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
   checker = {
      enabled = true,
      frequency = 60 * 60 * 24, -- at most once a day
   },

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
