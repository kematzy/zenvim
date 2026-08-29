-- ZENVIM - MINIMAL - SETUP
-- Started on: 31 July, 2025
-- Requires Neovim v0.11.3 and above
-- Assistance by Claude Sonnet v4 and Grok 3
-- See: https://claude.ai/chat/077e450c-ab8a-4aeb-983b-a91f91b2ef72
--      https://grok.com/chat/cefa8717-0aee-4328-bcb6-7d1e1262d897

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

-- Performance monitoring - End timing and log if slow
vim.defer_fn(function()
   local end_time = vim.uv.hrtime()
   local startup_time = (end_time - start_time) / 1e6 -- Convert to milliseconds

   if startup_time > 500 then
      vim.notify(
         string.format("ZENVIM startup took %.0fms", startup_time),
         vim.log.levels.WARN,
         { title = "Performance" }
      )
   end

   -- Set global variable for health checks
   _G.ZENVIM_STARTUP_TIME = startup_time
end, 0)
