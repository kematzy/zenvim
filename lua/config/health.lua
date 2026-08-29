local M = {}

local function check_executable(name, required)
   if vim.fn.executable(name) == 1 then
      vim.health.ok(name .. " found")
   elseif required then
      vim.health.error(name .. " not found (required)")
   else
      vim.health.warn(name .. " not found (optional)")
   end
end

function M.check()
   vim.health.start("ZENVIM")

   vim.health.start("External dependencies")
   check_executable("git", true)
   check_executable("rg", false)
   check_executable("fd", false)
   check_executable("node", false)
   check_executable("yazi", false)
   check_executable("lazygit", false)

   vim.health.start("Core")
   if vim.g.mapleader then
      vim.health.ok("leader is '" .. vim.g.mapleader .. "'")
   else
      vim.health.error("leader is not set")
   end
   if vim.g.have_nerd_font then
      vim.health.ok("Nerd Font enabled")
   else
      vim.health.warn("Nerd Font disabled")
   end
   if vim.g.loaded_netrw == 1 then
      vim.health.ok("netrw disabled")
   else
      vim.health.warn("netrw is still loaded")
   end

   vim.health.start("Plugins")
   for _, mod in ipairs({ "lazy", "snacks", "blink.cmp", "mason", "lspconfig", "conform" }) do
      local ok = pcall(require, mod)
      if ok then
         vim.health.ok(mod .. " loaded")
      else
         vim.health.error(mod .. " failed to load")
      end
   end

   vim.health.start("LSP")
   local ok_mason, mason_lspconfig = pcall(require, "mason-lspconfig")
   if ok_mason and mason_lspconfig.get_installed_servers then
      local installed = mason_lspconfig.get_installed_servers()
      if #installed == 0 then
         vim.health.warn("no Mason LSP servers installed")
      else
         vim.health.ok("installed: " .. table.concat(installed, ", "))
      end
   else
      vim.health.info("mason-lspconfig is not loaded yet")
   end

   vim.health.start("Performance")
   local startup_time = _G.ZENVIM_STARTUP_TIME or 0
   if startup_time > 0 then
      local msg = string.format("startup %.0fms", startup_time)
      if startup_time < 500 then
         vim.health.ok(msg)
      else
         vim.health.warn(msg)
      end
   else
      vim.health.info("startup time not measured yet (restart Neovim)")
   end
end

vim.api.nvim_create_user_command("ZENVIMHealth", function()
   local ok, err = pcall(M.check)
   if not ok then
      vim.notify("ZENVIM Health Check Error: " .. tostring(err), vim.log.levels.ERROR)
   end
end, {
   desc = "Run ZENVIM configuration health check",
})

return M

