-- Zenvim - Minimal Neovim configuration
-- Last updated: 29 August, 2026
-- Performance: startup time profiler.
--

return {
   -- vim-startuptime - Startup time profiler
   -- DOCS: https://github.com/dstein64/vim-startuptime
   {
      "dstein64/vim-startuptime",
      cmd = "StartupTime",
      config = function()
         -- Configure startup time display
         vim.g.startuptime_tries = 10
      end,
   },
}
