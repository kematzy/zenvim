-- Performance Optimization Plugin
-- Optimizes Neovim startup and runtime performance

return {
  -- Startup time profiler
  {
    "dstein64/vim-startuptime",
    cmd = "StartupTime",
    config = function()
      -- Configure startup time display
      vim.g.startuptime_tries = 10
    end,
  },
}
