-- Configuration Validation Plugin
-- Validates and monitors ZENVIM configuration integrity

-- Load validation utilities directly without creating a plugin
local validation = require("config.validation")

-- Auto-validation on startup
vim.api.nvim_create_autocmd("VimEnter", {
   callback = function()
      local results = validation.validate()
      if not results.overall.status then
         vim.defer_fn(
            function()
               vim.notify(
                  "ZENVIM configuration validation failed. Run ':ZENVIMValidate' for details.",
                  vim.log.levels.WARN,
                  { title = "Configuration Validation" }
               )
            end,
            1000
         )
      end
   end,
   desc = "Auto-validate configuration on startup",
})

-- Create user commands
vim.api.nvim_create_user_command("ZENVIMValidate", validation.show_validation_results, {
   desc = "Validate ZENVIM configuration",
})

-- Return empty table since this is just a utilities file
return {}
