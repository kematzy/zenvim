-- Zenvim - Minimal Neovim configuration
-- Last updated: 01 October, 2026
-- Entry point: bootstraps core modules, keymaps, autocmds and startup timing.
--

-- Performance monitoring - Start timing
local start_time = vim.uv.hrtime()

require("config.globals")
require("config.options")
-- load the keymaps configurations
local keymaps = require("config.keymap")
-- Setup global keymaps
keymaps.setup_global_keymaps()

require("config.autocmd")
require("config.lazy")

-- Load health check utilities
require("config.health")

-- Measure through VeryLazy so deferred plugins are included.
vim.api.nvim_create_autocmd("User", {
   pattern = "VeryLazy",
   once = true,
   callback = function()
      vim.defer_fn(function()
         local end_time = vim.uv.hrtime()
         local startup_time = (end_time - start_time) / 1e6 -- milliseconds
         _G.ZENVIM_STARTUP_TIME = startup_time

         if startup_time > 500 then
            vim.notify(
               string.format("ZENVIM startup took %.0fms", startup_time),
               vim.log.levels.WARN,
               { title = "Performance" }
            )
         end
      end, 0)
   end,
})
