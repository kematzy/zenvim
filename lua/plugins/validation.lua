-- Configuration Validation Plugin
-- Validates and monitors ZENVIM configuration integrity

local M = {}

-- Validate core configuration files
local function validate_core_files()
  local core_files = {
    "lua/config/globals.lua",
    "lua/config/options.lua", 
    "lua/config/keymap.lua",
    "lua/config/autocmd.lua",
    "lua/config/lazy.lua",
    "lua/config/lsp.lua",
    "init.lua",
  }
  
  local missing_files = {}
  for _, file in ipairs(core_files) do
    local full_path = vim.fn.stdpath("config") .. "/" .. file
    if vim.fn.filereadable(full_path) == 0 then
      table.insert(missing_files, file)
    end
  end
  
  return #missing_files == 0, missing_files
end

-- Validate plugin directory structure
local function validate_plugin_structure()
  local plugin_files = vim.fn.glob(vim.fn.stdpath("config") .. "/lua/plugins/*.lua", false, true)
  
  local required_plugins = {
    "lsp.lua",
    "completion.lua", 
    "treesitter.lua",
    "colorscheme.lua",
  }
  
  local missing_plugins = {}
  for _, plugin in ipairs(required_plugins) do
    local found = false
    for _, file in ipairs(plugin_files) do
      if vim.fn.fnamemodify(file, ":t") == plugin then
        found = true
        break
      end
    end
    if not found then
      table.insert(missing_plugins, plugin)
    end
  end
  
  return #missing_plugins == 0, missing_plugins
end

-- Validate LSP configuration
local function validate_lsp_config()
  local lsp_config_file = vim.fn.stdpath("config") .. "/lua/plugins/lsp.lua"
  
  if vim.fn.filereadable(lsp_config_file) == 0 then
    return false, {"LSP configuration file not found"}
  end
  
  -- Check if LSP configuration has servers defined
  local ok, lsp_config = pcall(dofile, lsp_config_file)
  if not ok then
    return false, {"LSP configuration has syntax errors"}
  end
  
  -- Validate LSP servers list
  if not lsp_config or not lsp_config[1] or not lsp_config[1].spec then
    return false, {"LSP configuration structure is invalid"}
  end
  
  return true, {}
end

-- Validate Treesitter configuration
local function validate_treesitter_config()
  local treesitter_file = vim.fn.stdpath("config") .. "/lua/plugins/treesitter.lua"
  
  if vim.fn.filereadable(treesitter_file) == 0 then
    return false, {"Treesitter configuration file not found"}
  end
  
  local ok, treesitter_config = pcall(dofile, treesitter_file)
  if not ok then
    return false, {"Treesitter configuration has syntax errors"}
  end
  
  return true, {}
end

-- Run all validations
function M.validate()
  local results = {}
  
  -- Validate core files
  local core_ok, core_missing = validate_core_files()
  results.core_files = {
    status = core_ok,
    issues = core_missing,
    message = core_ok and "All core files present" or "Missing core files: " .. table.concat(core_missing, ", ")
  }
  
  -- Validate plugin structure
  local plugins_ok, plugins_missing = validate_plugin_structure()
  results.plugin_structure = {
    status = plugins_ok,
    issues = plugins_missing,
    message = plugins_ok and "Plugin structure valid" or "Missing plugins: " .. table.concat(plugins_missing, ", ")
  }
  
  -- Validate LSP configuration
  local lsp_ok, lsp_issues = validate_lsp_config()
  results.lsp_config = {
    status = lsp_ok,
    issues = lsp_issues,
    message = lsp_ok and "LSP configuration valid" or "LSP issues: " .. table.concat(lsp_issues, ", ")
  }
  
  -- Validate Treesitter configuration
  local treesitter_ok, treesitter_issues = validate_treesitter_config()
  results.treesitter_config = {
    status = treesitter_ok,
    issues = treesitter_issues,
    message = treesitter_ok and "Treesitter configuration valid" or "Treesitter issues: " .. table.concat(treesitter_issues, ", ")
  }
  
  -- Overall status
  local all_ok = core_ok and plugins_ok and lsp_ok and treesitter_ok
  results.overall = {
    status = all_ok,
    message = all_ok and "All validations passed!" or "Some validations failed"
  }
  
  return results
end

-- Display validation results
function M.show_validation_results()
  local results = M.validate()
  
  -- Create buffer for results
  local buf = vim.api.nvim_create_buf(false, true)
  local lines = {}
  
  -- Header
  table.insert(lines, "ZENVIM Configuration Validation Results")
  table.insert(lines, string.rep("=", 50))
  table.insert(lines, "")
  
  -- Overall status
  local overall_icon = results.overall.status and "✅" or "❌"
  table.insert(lines, overall_icon .. " Overall Status: " .. results.overall.message)
  table.insert(lines, "")
  
  -- Core files
  local core_icon = results.core_files.status and "✅" or "❌"
  table.insert(lines, core_icon .. " Core Files: " .. results.core_files.message)
  if #results.core_files.issues > 0 then
    for _, issue in ipairs(results.core_files.issues) do
      table.insert(lines, "  - " .. issue)
    end
  end
  table.insert(lines, "")
  
  -- Plugin structure
  local plugins_icon = results.plugin_structure.status and "✅" or "❌"
  table.insert(lines, plugins_icon .. " Plugin Structure: " .. results.plugin_structure.message)
  if #results.plugin_structure.issues > 0 then
    for _, issue in ipairs(results.plugin_structure.issues) do
      table.insert(lines, "  - " .. issue)
    end
  end
  table.insert(lines, "")
  
  -- LSP configuration
  local lsp_icon = results.lsp_config.status and "✅" or "❌"
  table.insert(lines, lsp_icon .. " LSP Configuration: " .. results.lsp_config.message)
  if #results.lsp_config.issues > 0 then
    for _, issue in ipairs(results.lsp_config.issues) do
      table.insert(lines, "  - " .. issue)
    end
  end
  table.insert(lines, "")
  
  -- Treesitter configuration
  local treesitter_icon = results.treesitter_config.status and "✅" or "❌"
  table.insert(lines, treesitter_icon .. " Treesitter Configuration: " .. results.treesitter_config.message)
  if #results.treesitter_config.issues > 0 then
    for _, issue in ipairs(results.treesitter_config.issues) do
      table.insert(lines, "  - " .. issue)
    end
  end
  table.insert(lines, "")
  
  -- Footer
  table.insert(lines, "Generated at: " .. os.date("%Y-%m-%d %H:%M:%S"))
  
  -- Set buffer content
  vim.api.nvim_buf_set_lines(buf, 0, -1, false, lines)
  vim.api.nvim_buf_set_option(buf, "modifiable", false)
  vim.api.nvim_buf_set_option(buf, "filetype", "text")
  
  -- Display in floating window
  local width = math.min(80, vim.o.columns - 4)
  local height = math.min(#lines + 2, vim.o.lines - 4)
  local win = vim.api.nvim_open_win(buf, true, {
    relative = "editor",
    width = width,
    height = height,
    col = math.floor((vim.o.columns - width) / 2),
    row = math.floor((vim.o.lines - height) / 2),
    border = "rounded",
    title = " Configuration Validation ",
    style = "minimal",
  })
  
  -- Set up keymaps
  vim.api.nvim_buf_set_keymap(buf, "n", "q", "<cmd>close<cr>", { noremap = true, silent = true })
  vim.api.nvim_buf_set_keymap(buf, "n", "<Esc>", "<cmd>close<cr>", { noremap = true, silent = true })
  
  -- Highlight status icons
  vim.api.nvim_create_autocmd("BufWinEnter", {
    buffer = buf,
    callback = function()
      vim.fn.matchadd("Special", "✅")
      vim.fn.matchadd("Error", "❌")
    end,
  })
end

-- Auto-validation on startup
vim.api.nvim_create_autocmd("VeryLazy", {
  callback = function()
    local results = M.validate()
    if not results.overall.status then
      vim.defer_fn(function()
        vim.notify(
          "ZENVIM configuration validation failed. Run ':ZENVIMValidate' for details.",
          vim.log.levels.WARN,
          { title = "Configuration Validation" }
        )
      end, 1000)
    end
  end,
  desc = "Auto-validate configuration on startup",
})

-- Create user commands
vim.api.nvim_create_user_command("ZENVIMValidate", M.show_validation_results, {
  desc = "Validate ZENVIM configuration"
})

return M
