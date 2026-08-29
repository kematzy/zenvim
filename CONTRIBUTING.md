# Contributing to ZENVIM

Thank you for your interest in contributing to this Neovim configuration! This guide will help you get started.

## 📋 Overview

ZENVIM is a minimal yet powerful Neovim configuration targeting Neovim v0.11.3+. It uses lazy.nvim for plugin management and focuses on a clean, organized structure.

## 🏗️ Project Structure

```
.
├── init.lua                    # Entry point
├── lazy-lock.json             # Plugin lockfile (ignored by git)
├── .editorconfig              # Editor configuration
├── .gitignore                 # Git ignore rules
├── README.md                  # Project documentation
├── CONTRIBUTING.md            # This file
├── lua/
│   ├── config/               # Core configuration
│   │   ├── globals.lua       # Global variables
│   │   ├── options.lua       # Editor options
│   │   ├── keymap.lua        # Keymapping definitions
│   │   ├── autocmd.lua       # Autocommands
│   │   └── lazy.lua          # Lazy.nvim bootstrap
│   └── plugins/              # Plugin specifications
├── snippets/                 # VSCode-format snippets
└── stylua.toml               # Lua formatter settings
```

## 🚀 Getting Started

### Prerequisites

- Neovim v0.11.3 or higher
- Git
- Nerd Font (optional but recommended)

### Installation

1. Clone the configuration:
   ```bash
   git clone <repository-url> ~/.config/nvim
   ```

2. Start ZENVIM (`NVIM_APPNAME=zenvim`):
   ```bash
   zenvim
   ```

3. Lazy.nvim will automatically install all required plugins.

## 🛠️ Development Guidelines

### Code Style

- Follow `stylua.toml` (3-space indent, 100 columns)
- Ensure files end with a newline
- Trim trailing whitespace (except in Markdown files)
- Follow Lua style conventions

### Plugin Management

- All plugins are managed through lazy.nvim
- Plugin specifications go in `lua/plugins/`
- Use lazy loading where appropriate
- Document plugin dependencies clearly

### Keymap Organization

- Global and plugin keys go in `lua/config/keymap.lua` and are consumed via Lazy `keys =`
- LSP buffer maps belong in `lua/plugins/lsp.lua` on `LspAttach`
- Use descriptive keymap descriptions
- Follow consistent naming conventions

### LSP Configuration

- LSP servers are listed in `lua/plugins/lsp.lua` (`ensure_installed` + `vim.lsp.config`)
- Use Mason for automatic server installation
- Do not add a second Mason setup or an LSP format-on-save autocmd

## 📝 Making Changes

1. **Create a feature branch**:
   ```bash
   git checkout -b feature/your-feature-name
   ```

2. **Make your changes**:
   - Follow the existing code style
   - Add comments for complex logic
   - Update documentation as needed

3. **Test your changes**:
   - Run `make check` (StyLua, luacheck, cspell, JSON, headless load)
   - Start ZENVIM and ensure no errors
   - Test the specific functionality you've added
   - Check for plugin conflicts

4. **Commit your changes**:
   ```bash
   git add .
   git commit -m "feat: add your feature description"
   ```

## 🎯 Common Tasks

### Adding a New Plugin

1. Create a new file in `lua/plugins/` or add to an existing one
2. Follow the lazy.nvim specification format
3. Add any required keymaps to `lua/config/keymap.lua`
4. Test the plugin installation and functionality

### Adding a New LSP Server

1. Add the server to the `servers` table in `lua/plugins/lsp.lua`
2. Configure any server-specific settings
3. Test with a file that uses the language server

### Adding Keymaps

1. Add global keymaps to `M.global` in `lua/config/keymap.lua`
2. Add plugin-specific keymaps to the appropriate plugin file
3. Ensure keymaps don't conflict with existing ones

## 🐛 Troubleshooting

### Common Issues

1. **Plugin Installation Errors**:
   - Check `:Lazy` for plugin status
   - Ensure internet connectivity
   - Try clearing the `lazy/` directory and restarting

2. **LSP Server Issues**:
   - Run `:Mason` to check server installation
   - Check `:LspInfo` for server status
   - Ensure the language is recognized (check `:set filetype?`)

3. **Keymap Conflicts**:
   - Use `:verbose map <key>` to check keymap assignments
   - Ensure no duplicate keymap definitions

### Getting Help

- Check Neovim documentation with `:help`
- Review plugin documentation
- Use `:checkhealth` for system health checks

## 📋 Submitting Changes

1. Ensure all tests pass
2. Update relevant documentation
3. Follow the commit message convention
4. Create a pull request with a clear description

## 🏆 Goals

This configuration aims to:

- ✅ Provide a minimal, clean setup
- ✅ Support modern Neovim features
- ✅ Maintain excellent performance
- ✅ Be easily extensible
- ✅ Follow best practices

## 📚 Resources

- [Neovim Documentation](https://neovim.io/doc/)
- [Lazy.nvim Documentation](https://github.com/folke/lazy.nvim)
- [Lua Style Guide](https://github.com/luarocks/lua-style-guide)
- [EditorConfig](https://editorconfig.org/)

---

Thank you for contributing to ZENVIM! 🎉
