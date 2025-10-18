-- ZENVIM Health Check Configuration
-- Health checks for ZENVIM configuration

local M = {}

-- Check if required executables are available
local function check_executable(name, required)
   if vim.fn.executable(name) == 1 then
      return string.format("✅ %s: found", name)
   else
      local msg = string.format("❌ %s: not found", name)
      if required then
         msg = msg .. " (required)"
      else
         msg = msg .. " (optional)"
      end
      return msg
   end
end

-- Check if a plugin is loaded
local function check_plugin_loaded(name)
   local ok, plugin = pcall(require, name)
   if ok then
      return string.format("✅ Plugin %s: loaded", name)
   else
      return string.format("❌ Plugin %s: not loaded", name)
   end
end

-- Check configuration values
local function check_config()
   local checks = {}

   -- Check leader key
   local leader = vim.g.mapleader
   if leader then
      table.insert(checks, string.format("✅ Leader key: '%s'", leader))
   else
      table.insert(checks, "❌ Leader key: not set")
   end

   -- Check Nerd Font
   if vim.g.have_nerd_font then
      table.insert(checks, "✅ Nerd Font: enabled")
   else
      table.insert(checks, "⚠️  Nerd Font: disabled (optional)")
   end

   -- Check Netrw disabled
   if vim.g.loaded_netrw == 1 then
      table.insert(checks, "✅ Netrw: disabled (replaced by yazi)")
   else
      table.insert(checks, "⚠️  Netrw: not disabled")
   end

   return checks
end

-- Health check function
function M.check()
   local health = vim.health or require("health")

   health.start("ZENVIM Configuration Health Check")

   -- Check external dependencies
   health.start("External Dependencies")
   local deps = {
      { "git", true },
      { "node", false }, -- Optional for some LSP servers
      { "npm", false }, -- Optional for some LSP servers
      { "yazi", false }, -- Optional file manager
      { "lazygit", false }, -- Optional git UI
      { "rg", false }, -- Optional for better search
      { "fd", false }, -- Optional for better file finding
   }

   for _, dep in ipairs(deps) do
      health.ok(check_executable(dep[1], dep[2]))
   end

   -- Check core configuration
   health.start("Core Configuration")
   local config_checks = check_config()
   for _, check in ipairs(config_checks) do
      if string.find(check, "✅") then
         health.ok(check)
      elseif string.find(check, "⚠️") then
         health.warn(check)
      else
         health.error(check)
      end
   end

   -- Check key plugins
   health.start("Core Plugins")
   local plugins = {
      "lazy",
      "snacks",
      "blink.cmp",
      "mason",
      "nvim-treesitter",
      "nvim-lspconfig",
   }

   for _, plugin in ipairs(plugins) do
      local check = check_plugin_loaded(plugin)
      if string.find(check, "✅") then
         health.ok(check)
      else
         health.error(check)
      end
   end

   -- Check LSP servers
   health.start("LSP Servers")
   local lsp_servers = {
      "lua_ls",
      "bashls",
      "jsonls",
      "yamlls",
      "html",
      "cssls",
      "ts_ls",
      "pyright",
      "gopls",
      "dockerls",
   }

   local mason_registry = require("mason-registry")
   for _, server in ipairs(lsp_servers) do
      if mason_registry.is_installed(server) then
         health.ok(string.format("✅ LSP Server %s: installed", server))
      else
         health.warn(string.format("⚠️  LSP Server %s: not installed", server))
      end
   end

   -- Check Treesitter parsers
   health.start("Treesitter Parsers")
   local parsers = {
      "lua",
      "vim",
      "vimdoc",
      "bash",
      "markdown",
      "markdown_inline",
      "json",
      "yaml",
      "python",
      "javascript",
      "typescript",
      "html",
      "css",
      "go",
   }

   local installed_parsers = require("nvim-treesitter.parsers").get_parser_configs()
   for _, parser in ipairs(parsers) do
      if installed_parsers[parser] then
         health.ok(string.format("✅ Treesitter Parser %s: installed", parser))
      else
         health.warn(string.format("⚠️  Treesitter Parser %s: not installed", parser))
      end
   end

   -- Performance checks
   health.start("Performance")

   -- Check startup time (rough estimate)
   local startup_time = os.clock() - vim.v.startuptime
   if startup_time < 0.1 then
      health.ok(string.format("✅ Startup time: %.0fms (excellent)", startup_time * 1000))
   elseif startup_time < 0.2 then
      health.ok(string.format("✅ Startup time: %.0fms (good)", startup_time * 1000))
   elseif startup_time < 0.5 then
      health.warn(
         string.format("⚠️  Startup time: %.0fms (could be optimized)", startup_time * 1000)
      )
   else
      health.warn(string.format("❌ Startup time: %.0fms (slow)", startup_time * 1000))
   end

   -- Check memory usage
   local memory_kb = collectgarbage("count")
   if memory_kb < 5000 then
      health.ok(string.format("✅ Memory usage: %.0fKB (good)", memory_kb))
   elseif memory_kb < 10000 then
      health.ok(string.format("✅ Memory usage: %.0fKB (acceptable)", memory_kb))
   else
      health.warn(string.format("⚠️  Memory usage: %.0fKB (high)", memory_kb))
   end

   -- File type checks
   health.start("File Type Detection")

   -- Check if .slim files are recognized
   local ft_result = vim.filetype.match({ filename = "test.slim" })
   if ft_result == "slim" then
      health.ok("✅ Slim template detection: working")
   else
      health.error("❌ Slim template detection: not working")
   end

   -- Check other common file types
   local file_checks = {
      { "test.py", "python" },
      { "test.js", "javascript" },
      { "test.ts", "typescript" },
      { "test.go", "go" },
      { "test.rb", "ruby" },
      { "test.php", "php" },
      { "test.sh", "bash" },
      { "Dockerfile", "dockerfile" },
      { "test.yaml", "yaml" },
      { "test.json", "json" },
   }

   for _, check in ipairs(file_checks) do
      local ft = vim.filetype.match({ filename = check[1] })
      if ft == check[2] then
         health.ok(string.format("✅ %s: detected as %s", check[1], ft))
      else
         health.warn(
            string.format(
               "⚠️  %s: detected as %s (expected %s)",
               check[1],
               ft or "nil",
               check[2]
            )
         )
      end
   end

   -- Key mapping checks
   health.start("Key Mappings")

   local key_checks = {
      { "<leader>", "leader key" },
      { "<C-s>", "save" },
      { "<C-q>", "quit" },
      { "<leader>ff", "find files" },
      { "<leader>fg", "grep" },
      { "gd", "go to definition" },
      { "gr", "go to references" },
   }

   for _, check in ipairs(key_checks) do
      local has_map = vim.fn.maparg(check[1], "n") ~= ""
      if has_map then
         health.ok(string.format("✅ Key mapping %s: configured", check[1]))
      else
         health.warn(string.format("⚠️  Key mapping %s: not found", check[1]))
      end
   end

   health.start("Configuration Summary")
   health.ok("ZENVIM configuration check completed")
   health.info("Run ':checkhealth' for system health checks")
   health.info("Run ':Lazy' to manage plugins")
   health.info("Run ':Mason' to manage LSP servers")

   return true
end

-- Auto-run health check when requested
vim.api.nvim_create_user_command("ZENVIMHealth", M.check, {
   desc = "Run ZENVIM configuration health check",
})

return M
