# ZENVIM - Minimal Neovim Configuration

[![Neovim](https://img.shields.io/badge/Neovim-0.11.3+-blue.svg)](https://neovim.io)
[![License](https://img.shields.io/badge/License-MIT-green.svg)](LICENSE)

A minimal yet powerful Neovim configuration targeting **Neovim v0.11.3+**. This configuration focuses on clean organization, modern features, and excellent performance.

## ✨ Features

- 🚀 **Modern Neovim** - Built for Neovim v0.11.3+ with latest features
- 📦 **Lazy.nvim** - Fast, modern plugin manager
- 🔍 **LSP Support** - Full Language Server Protocol with Mason
- 🌳 **Treesitter** - Advanced syntax highlighting and code understanding
- 💡 **Intelligent Completion** - Blink.cmp with LSP integration
- 🎨 **Beautiful UI** - Custom themes, status line, and visual enhancements
- 🗂️ **File Management** - Yazi file manager and integrated explorer
- 🔄 **Git Integration** - Lazygit, gitsigns, and comprehensive git workflow
- ⚡ **Performance** - Optimized for speed and responsiveness
- 🧘 **Zen Mode** - Distraction-free writing environment
- 🔧 **Highly Configurable** - Easy to extend and customize

## 🚀 Quick Start

### Prerequisites

- **Neovim v0.11.3+** - [Installation Guide](https://github.com/neovim/neovim/wiki/Installing-Neovim)
- **Git** - For plugin management and version control
- **Nerd Font** (Optional but recommended) - For better UI icons

### Installation

1. **Backup your existing configuration** (if you have one):

   ```bash
   mv ~/.config/nvim ~/.config/nvim.backup
   mv ~/.local/share/nvim ~/.local/share/nvim.backup
   ```

2. **Clone the configuration**:

   ```bash
   git clone <repository-url> ~/.config/nvim
   ```

3. **Start ZENVIM** (`NVIM_APPNAME=zenvim`; a `zenvim` alias is typical):

   ```bash
   zenvim
   ```

4. **Wait for plugins to install** - Lazy.nvim will automatically install all required plugins on first launch.

### First Launch

The first time you start Neovim, Lazy.nvim will:

- Install all configured plugins
- Set up LSP servers automatically
- Install Treesitter parsers
- Create necessary configuration files

## 📁 Project Structure

```
.
├── init.lua                    # Main entry point
├── README.md                   # This file
├── CONTRIBUTING.md             # Contribution guidelines
├── CHANGELOG.md                # Version history
├── .editorconfig               # Editor configuration
├── .gitignore                  # Git ignore rules
├── lua/
│   ├── config/                 # Core configuration
│   │   ├── globals.lua         # Global variables and settings
│   │   ├── options.lua         # Editor options
│   │   ├── keymap.lua          # Keymapping definitions
│   │   ├── autocmd.lua         # Autocommands
│   │   └── lazy.lua            # Lazy.nvim bootstrap
│   ├── plugins/                # Plugin specifications
│   │   ├── mason.lua           # Mason + formatter/linter tools
│   │   ├── lsp.lua             # LSP attach, diagnostics, ensure_installed
│   │   ├── completion.lua      # Blink.cmp
│   │   ├── snacks.lua          # Snacks.nvim configuration
│   │   ├── colorscheme.lua     # Theme configuration
│   │   ├── treesitter.lua      # Syntax highlighting
│   │   ├── formatting.lua      # Conform (format-on-save)
│   │   └── ...                 # Other plugin configurations
│   └── config/health.lua       # :ZENVIMHealth
└── snippets/                   # VSCode-format snippets (package.json)
```

## ⚡ Key Features

### Language Support

LSP support is configured for:

- **Web**: HTML, CSS, JavaScript/TypeScript, JSON, YAML, TOML
- **Backend**: Lua, Python, Go, PHP, Ruby, Bash
- **DevOps**: Docker, SQL
- **Markup**: Markdown
- **Templates**: Slim, ERB, Handlebars

### Keybindings

This configuration includes comprehensive keybindings:

#### Navigation & Files

- `<leader>ff` - Find files
- `<leader>fg` - Live grep
- `<leader>fb` - Browse buffers
- `<leader>fr` - Recent files

#### LSP

- `gd` - Go to definition
- `gr` - Go to references
- `gI` - Go to implementation
- `<leader>ca` - Code actions
- `<C-k>` - Signature help

#### Git

- `<leader>gg` - Open LazyGit
- `<leader>gb` - Git blame
- `<leader>gs` - Git status

#### Editor

- `<C-s>` - Save file
- `<C-q>` - Quit Neovim
- `<Esc>` - Clear search highlighting

See `lua/config/keymap.lua` for the complete keymap list.

### Plugin Highlights

- **Snacks.nvim** - Modern, feature-rich plugin collection
- **Blink.cmp** - Fast completion engine
- **Mason.nvim** - LSP server management
- **Yazi.nvim** - Modern file manager
- **Gitsigns.nvim** - Git signs and integration
- **LazyGit.nvim** - Git UI inside Neovim
- **Conform.nvim** - Code formatting
- **Lualine.nvim** - Status line
- **Treesitter** - Syntax highlighting and code understanding

## 🛠️ Customization

### Adding New LSP Servers

Edit `lua/plugins/lsp.lua` and add to the `servers` table:

```lua
local servers = {
   -- existing servers...
   rust_analyzer = {},  -- Add Rust support
   clangd = {},         -- Add C/C++ support
}
```

### Adding Plugins

Create new files in `lua/plugins/` or add to existing ones:

```lua
-- lua/plugins/your-plugin.lua
return {
   "username/plugin-name",
   config = function()
      -- Plugin configuration
   end,
}
```

### Custom Keymaps

Add to `lua/config/keymap.lua`:

```lua
M.global = {
   { "<leader>h", "<cmd>echo 'Hello'<cr>", desc = "Say hello" },
   -- Add more keymaps...
}
```

## 🐛 Troubleshooting

### Common Issues

1. **Plugin Installation Errors**:

   ```vim
   :Lazy health
   ```

2. **LSP Server Issues**:

   ```vim
   :Mason
   :LspInfo
   ```

3. **Keymap Conflicts**:

   ```vim
   :verbose map <key>
   ```

4. **Performance Issues**:

   ```vim
   :checkhealth
   ```

5. **ZENVIM Health Check**:

   ```vim
   :ZENVIMHealth
   ```

6. **Startup Performance**:
   ```vim
   :StartupTime
   ```

### Getting Help

- Check `:help` for Neovim documentation
- Review plugin documentation with `:help plugin-name`
- Use `:checkhealth` for system diagnostics

## 📚 Documentation

- [AGENTS.md](AGENTS.md) - Architecture and commands for coding agents
- [Contributing Guide](CONTRIBUTING.md) - How to contribute to this project
- [Changelog](CHANGELOG.md) - Version history and changes
- [Neovim Documentation](https://neovim.io/doc/)
- [Lazy.nvim Documentation](https://github.com/folke/lazy.nvim)

## 🤝 Contributing

Contributions are welcome! Please read the [Contributing Guide](CONTRIBUTING.md) for details on:

- Code style and conventions
- Plugin management
- Testing procedures
- Submitting changes

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## 🙏 Acknowledgments

This configuration was created with assistance from:

- [Claude Sonnet v4](https://claude.ai/chat/077e450c-ab8a-4aeb-983b-a91f91b2ef72)
- [Grok 3](https://grok.com/chat/cefa8717-0aee-4328-bcb6-7d1e1262d897)

And the amazing Neovim community and plugin authors who make this possible.

---

**Happy coding!** 🎉

If you find this configuration helpful, please consider giving it a ⭐ star!
