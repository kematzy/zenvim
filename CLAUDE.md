# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Common Development Commands

### Neovim Configuration Management
- **Start Neovim**: `nvim` - Opens the ZENVIM configuration
- **Health Check**: `nvim --headless -c "lua require('config.health').check()" -c "q"` or run `:ZENVIMHealth` inside Neovim
- **Validate Configuration**: Run `:ZENVIMValidate` inside Neovim to validate core configuration files
- **Plugin Management**: Run `:Lazy` inside Neovim to manage plugins
- **LSP Management**: Run `:Mason` inside Neovim to manage LSP servers
- **System Health**: Run `:checkhealth` inside Neovim for comprehensive system diagnostics

### Configuration Reload
- **Reload Config**: `:source %` - Reload current configuration file
- **Restart Neovim**: Completely restart to load all configuration changes

## Architecture Overview

### Core Configuration Structure
This is a Neovim configuration using the **Lazy.nvim** plugin manager with a modular architecture:

- **Entry Point**: `init.lua` - Main configuration loader with performance monitoring
- **Core Settings**: `lua/config/` - Contains fundamental configuration modules:
  - `globals.lua` - Global variables and basic settings
  - `options.lua` - Neovim options and settings
  - `keymap.lua` - Keymapping definitions and leader key setup
  - `autocmd.lua` - Autocommands for automatic behaviors
  - `lazy.lua` - Lazy.nvim bootstrap and configuration
  - `lsp.lua` - Core LSP configuration and setup
  - `health.lua` - Health check utilities and diagnostics
  - `validation.lua` - Configuration validation utilities

### Plugin Architecture
Plugins are organized in `lua/plugins/` by functionality:
- `lsp.lua` - Language Server Protocol configuration with Mason
- `completion.lua` - Blink.cmp completion engine setup
- `treesitter.lua` - Syntax highlighting and code understanding
- `colorscheme.lua` - Theme configuration
- `snacks.lua` - Snacks.nvim modern plugin collection
- Formatting, UI, Git integration, file management, etc.

### Key Features
- **Performance Optimized**: Monitors startup time, disables unused built-in plugins
- **LSP Powered**: Full language server support with automatic installation via Mason
- **Modern Completion**: Blink.cmp for fast intelligent completion
- **File Management**: Yazi integration replacing netrw
- **Git Integration**: Lazygit, gitsigns for comprehensive git workflow
- **Health Monitoring**: Built-in validation and health checks

### Language Support
Pre-configured LSP servers for: Web development (HTML/CSS/JS/TS), Backend (Lua/Python/Go/PHP/Ruby/Bash), DevOps (Docker/SQL), Markup (Markdown), Templates (Slim/ERB/Handlebars).

## Configuration Patterns

### Adding New Plugins
Create files in `lua/plugins/` or add to existing plugin specs using the Lazy.nvim format:
```lua
return {
   "username/plugin-name",
   config = function()
      -- Plugin configuration
   end,
}
```

### LSP Server Management
Edit `lua/plugins/lsp.lua` and add to the `servers` table to enable new language servers.

### Keymapping System
Keymaps are centrally managed in `lua/config/keymap.lua` with a structured table format for global and mode-specific mappings.

## Custom Commands

### ZENVIM Specific Commands
- `:ZENVIMHealth` - Run comprehensive configuration health check
- `:ZENVIMValidate` - Validate configuration file integrity
- Performance monitoring with automatic startup time warnings

## Development Notes

### Configuration Validation
The configuration includes built-in validation that checks:
- Core configuration file presence
- Plugin directory structure integrity
- LSP and Treesitter configuration validity
- Startup performance monitoring

### Health System
Comprehensive health checks monitor:
- External dependencies (git, node, npm, yazi, lazygit, rg, fd)
- Core configuration settings (leader keys, Nerd Font, netrw status)
- Plugin loading status
- LSP server installation status
- Treesitter parser availability
- Memory usage and startup performance
- File type detection accuracy
- Key mapping configuration

This configuration is designed for Neovim v0.11.3+ and emphasizes clean organization, modern features, and excellent performance.