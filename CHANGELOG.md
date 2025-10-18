# Changelog

All notable changes to ZENVIM will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

### Added

- SQL language server support (`sqlls`)
- Enhanced diagnostic configuration with Nerd Font icons
- Signature help keymap (`<C-k>`)
- Performance optimizations for diagnostics
- Comprehensive project documentation
- **MIT License** for open source compliance
- **Custom health check system** (`:ZENVIMHealth`)
- **Configuration validation system** (`:ZENVIMValidate`)
- **Startup time monitoring** and performance tracking
- **Automated configuration integrity** checks
- **Large file optimization** for better performance
- **Enhanced lazy.nvim configuration** with disabled plugins

### Fixed

- Docker LSP server configuration errors
- Slim template file type detection
- Duplicate and conflicting LSP server definitions
- Cleaned up commented legacy code
- **Removed redundant LSP configuration** in `config/lsp.lua`

### Improved

- Better error handling and performance
- Enhanced LSP configuration organization
- Improved diagnostic display with severity sorting
- Better file type detection for `.slim` files
- **Optimized startup performance** with plugin lazy loading
- **Enhanced memory management** and usage monitoring
- **Better file handling** for large files (>1MB)
- **Improved plugin loading** strategy

### Documentation

- Added comprehensive `CONTRIBUTING.md` guide
- Enhanced `README.md` with installation instructions
- Improved inline documentation and comments
- **Added troubleshooting section** with new commands
- **Enhanced feature documentation** and usage examples

### Performance

- **Reduced startup time** by disabling unused runtime plugins
- **Optimized memory usage** with better garbage collection
- **Improved file loading** for large files
- **Enhanced key mapping** performance with timeout optimizations

## [1.0.0] - 2025-07-31

### Added

- Initial release of ZENVIM configuration
- Neovim v0.11.3+ support
- Lazy.nvim plugin management
- LSP support with Mason integration
- Treesitter syntax highlighting
- Snacks.nvim integration
- Comprehensive keymap system
- Git integration (gitsigns, lazygit)
- File management (yazi, snacks explorer)
- Terminal support
- Status line (lualine)
- Completion system (blink.cmp)
- Formatting support (conform.nvim)
- Color scheme support
- Zen mode
- Commenting system
- Diagnostic system
- Project management features

### Core Features

- Modern Neovim configuration structure
- Organized plugin specifications
- Centralized keymap management
- Comprehensive LSP setup
- Auto-completion and snippets
- Git workflow integration
- File navigation and management
- Customizable themes and appearance

### Configuration Files

- `init.lua` - Main entry point
- `lua/config/` - Core configuration modules
- `lua/plugins/` - Plugin specifications
- `.editorconfig` - Editor configuration
- `.gitignore` - Git ignore rules

## [0.9.0] - 2025-07-30

### Development

- Initial project setup
- Basic configuration structure
- Core plugin selection
- Keymap system design

---

## Versioning

- **Major**: Breaking changes or major feature additions
- **Minor**: New features in a backward-compatible manner
- **Patch**: Backward-compatible bug fixes

## Support

For questions or support, please refer to the project documentation or create an issue in the repository.
