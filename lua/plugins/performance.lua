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
  
  -- Deferred loading for performance
  {
    "folke/lazy.nvim",
    opts = {
      performance = {
        rtp = {
          -- Disable some built-in plugins for performance
          disabled_plugins = {
            "gzip",
            "matchit",
            "matchparen",
            "netrwPlugin",
            "tarPlugin",
            "tohtml",
            "tutor",
            "zipPlugin",
          },
        },
      },
    },
  },
}
