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
  local ok, _ = pcall(require, name)
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

-- Get LSP server list (static for now to avoid complexity)
local function get_lsp_servers()
  return {
    "bashls",
    "cssls",
    "css_variables",
    "cspell_ls",
    "dockerls",
    "gopls",
    "html",
    "intelephense",
    "jsonls",
    "lemminx",
    "lua_ls",
    "marksman",
    "pyright",
    "solargraph",
    "sqlls",
    "tailwindcss",
    "ts_ls",
    "taplo",
    "yamlls",
  }
end

-- Check if LSP server is installed
local function check_lsp_server(server)
  local installed = false
  local mason_available = false

  -- Method 1: Check Mason registry
  local ok, mason_registry = pcall(require, "mason-registry")
  if ok then
    mason_available = true
    local ok2, pkg = pcall(mason_registry.get_package, server)
    if ok2 and pkg:is_installed() then installed = true end
  end

  -- Method 2: Check if executable exists
  if not installed then
    local executables = {
      lua_ls = "lua-language-server",
      bashls = "bash-language-server",
      jsonls = "vscode-json-language-server",
      yamlls = "yaml-language-server",
      html = "vscode-html-language-server",
      cssls = "vscode-css-language-server",
      ts_ls = "typescript-language-server",
      dockerls = "docker-langserver",
      pyright = { "pyright", "pyright-langserver" },
      gopls = "gopls",
      intelephense = "intelephense",
      solargraph = "solargraph",
      tailwindcss = "tailwindcss-language-server",
    }

    local exe_names = executables[server]
    if exe_names then
      if type(exe_names) == "string" then exe_names = { exe_names } end
      for _, exe in ipairs(exe_names) do
        if vim.fn.executable(exe) == 1 then
          installed = true
          break
        end
      end
    end
  end

  return installed
end

-- Health check function - compatible with :checkhealth
function M.check()
  vim.health.start("ZENVIM Configuration Health Check")

  -- Check external dependencies
  vim.health.start("External Dependencies")
  local deps = {
    { "git",     true },
    { "node",    false },
    { "npm",     false },
    { "yazi",    false },
    { "lazygit", false },
    { "rg",      false },
    { "fd",      false },
  }

  for _, dep in ipairs(deps) do
    local result = check_executable(dep[1], dep[2])
    if string.find(result, "✅") then
      vim.health.ok(result)
    elseif dep[2] then
      vim.health.error(result)
    else
      vim.health.warn(result)
    end
  end

  -- Check core configuration
  vim.health.start("Core Configuration")
  local config_checks = check_config()
  for _, check in ipairs(config_checks) do
    if string.find(check, "✅") then
      vim.health.ok(check)
    elseif string.find(check, "⚠️") then
      vim.health.warn(check)
    else
      vim.health.error(check)
    end
  end

  -- Check key plugins
  vim.health.start("Core Plugins")
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
      vim.health.ok(check)
    else
      vim.health.error(check)
    end
  end

  -- Check LSP servers
  vim.health.start("LSP Servers")
  local lsp_servers = get_lsp_servers()

  for _, server in ipairs(lsp_servers) do
    local installed = check_lsp_server(server)
    if installed then
      vim.health.ok(string.format("✅ LSP Server %s: installed", server))
    else
      vim.health.warn(string.format("⚠️  LSP Server %s: not installed", server))
    end
  end

  -- Check Treesitter parsers
  vim.health.start("Treesitter Parsers")
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

  local parsers_ok, parsers_module = pcall(require, "nvim-treesitter.parsers")
  if parsers_ok then
    local installed_parsers = parsers_module.get_parser_configs()
    for _, parser in ipairs(parsers) do
      if installed_parsers[parser] then
        vim.health.ok(string.format("✅ Treesitter Parser %s: installed", parser))
      else
        vim.health.warn(string.format("⚠️  Treesitter Parser %s: not installed", parser))
      end
    end
  else
    vim.health.warn("⚠️  Could not check Treesitter parsers (module not available)")
  end

  -- Performance checks
  vim.health.start("Performance")

  -- Check startup time
  local startup_time = _G.ZENVIM_STARTUP_TIME or 0
  if startup_time > 0 then
    if startup_time < 100 then
      vim.health.ok(string.format("✅ Startup time: %.0fms (excellent)", startup_time))
    elseif startup_time < 200 then
      vim.health.ok(string.format("✅ Startup time: %.0fms (good)", startup_time))
    elseif startup_time < 500 then
      vim.health.warn(
        string.format("⚠️  Startup time: %.0fms (could be optimized)", startup_time)
      )
    else
      vim.health.error(string.format("❌ Startup time: %.0fms (slow)", startup_time))
    end
  else
    vim.health.info("ℹ️  Startup time: not measured yet (restart Neovim)")
  end

  -- Check memory usage
  local memory_kb = collectgarbage("count")
  if memory_kb < 5000 then
    vim.health.ok(string.format("✅ Memory usage: %.0fKB (good)", memory_kb))
  elseif memory_kb < 10000 then
    vim.health.ok(string.format("✅ Memory usage: %.0fKB (acceptable)", memory_kb))
  else
    vim.health.warn(string.format("⚠️  Memory usage: %.0fKB (high)", memory_kb))
  end

  -- File type checks
  vim.health.start("File Type Detection")

  -- Check if .slim files are recognized
  local ft_result = vim.filetype.match({ filename = "test.slim" })
  if ft_result == "slim" then
    vim.health.ok("✅ Slim template detection: working")
  else
    vim.health.error("❌ Slim template detection: not working")
  end

  -- Check other common file types
  local file_checks = {
    { "test.py",    "python" },
    { "test.js",    "javascript" },
    { "test.ts",    "typescript" },
    { "test.go",    "go" },
    { "test.rb",    "ruby" },
    { "test.php",   "php" },
    { "test.sh",    "bash" },
    { "Dockerfile", "dockerfile" },
    { "test.yaml",  "yaml" },
    { "test.json",  "json" },
  }

  for _, check in ipairs(file_checks) do
    local ft = vim.filetype.match({ filename = check[1] })
    if ft == check[2] then
      vim.health.ok(string.format("✅ %s: detected as %s", check[1], ft))
    else
      vim.health.warn(
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
  vim.health.start("Key Mappings")

  local key_checks = {
    { "<leader>",   "leader key" },
    { "<C-s>",      "save" },
    { "<C-q>",      "quit" },
    { "<leader>ff", "find files" },
    { "<leader>fg", "grep" },
    { "gd",         "go to definition" },
    { "gr",         "go to references" },
  }

  for _, check in ipairs(key_checks) do
    local has_map = vim.fn.maparg(check[1], "n") ~= ""
    if has_map then
      vim.health.ok(string.format("✅ Key mapping %s: configured", check[1]))
    else
      vim.health.warn(string.format("⚠️  Key mapping %s: not found", check[1]))
    end
  end

  vim.health.start("Configuration Summary")
  vim.health.ok("ZENVIM configuration check completed")
  vim.health.info("Run ':checkhealth' for full system health checks")
  vim.health.info("Run ':Lazy' to manage plugins")
  vim.health.info("Run ':Mason' to manage LSP servers")
end

-- Create user command with error handling
vim.api.nvim_create_user_command("ZENVIMHealth", function()
  local ok, err = pcall(M.check)
  if not ok then
    vim.notify("ZENVIM Health Check Error: " .. tostring(err), vim.log.levels.ERROR)
  end
end, {
  desc = "Run ZENVIM configuration health check",
})

return M

-- cSpell:words lazygit lspconfig intelephense lemminx sqlls taplo lua_ls bashls jsonls
-- cSpell:words solargraph yamlls cssls dockerls langserver pyright gopls vimdoc maparg
-- cSpell:words checkhealth startuptime
