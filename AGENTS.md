# AGENTS.md

Guidance for coding agents working in this Neovim configuration.

## Commands

- **Start ZENVIM**: `zenvim` (alias for `NVIM_APPNAME=zenvim nvim`). Plain `nvim` loads `~/.config/nvim`, not this config.
- **Health check**: `zenvim --headless -c "lua require('config.health').check()" -c "q"` or `:ZENVIMHealth`
- **Plugins**: `:Lazy`
- **LSP servers / tools**: `:Mason`
- **System diagnostics**: `:checkhealth`
- **Quality checks** (from this repo root): `make check` or `./scripts/check.sh`
- **Format Lua**: `make format` or `stylua .`

Reload a sourced Lua file with `:source %`. Restart ZENVIM to load config changes that run at startup.

## Architecture

Lazy.nvim plugin manager, modular Lua config.

**Entry:** `init.lua` (loads core modules, tracks startup time).

**Core** (`lua/config/`):

- `globals.lua` — leader keys, netrw disable, nerd font flag
- `options.lua` — `vim.opt` only
- `keymap.lua` — global and plugin keymaps (LSP maps live in `lua/plugins/lsp.lua`)
- `autocmd.lua` — yank highlight, filetype rules
- `lazy.lua` — Lazy.nvim bootstrap
- `health.lua` — `:ZENVIMHealth`
- `cspell.lua` — buffer-local cSpell (`cspell_ls`) toggle
- `dashboard.lua` — dashboard recent files, projects, git status
- `zen.lua` — palette for lualine / terminal chrome

**Plugins** (`lua/plugins/`):

- `mason.lua` — Mason + mason-tool-installer (formatters/linters)
- `lsp.lua` — nvim-lspconfig, LspAttach, diagnostics, `vim.lsp.config` overrides, mason-lspconfig `ensure_installed`
- `completion.lua` — Blink.cmp (v1 line; built-in snippets + friendly-snippets)
- `formatting.lua` — Conform.nvim (the only format-on-save path)
- `treesitter.lua` — nvim-treesitter on `main` (Neovim 0.12 highlighter API)
- `colorscheme.lua` — Catppuccin
- `snacks.lua` — picker, explorer (`replace_netrw = false`), lazygit, notifier

## LSP and formatting

One stack:

1. Mason installs packages.
2. `lua/plugins/lsp.lua` owns attach, diagnostics, capabilities, and `ensure_installed`.
3. Per-server settings go through `vim.lsp.config()` in that file. nvim-lspconfig ships defaults.

Do not add a second Mason setup or an LSP `BufWritePre` format autocmd. Conform owns formatting.

## Keymaps

- Global and plugin keys: `lua/config/keymap.lua`, consumed via Lazy `keys = keymaps.<name>`
- LSP buffer keys: `lua/plugins/lsp.lua` on `LspAttach`

## Constraints

- Launch with `zenvim` (`NVIM_APPNAME=zenvim`). This config targets Neovim 0.12+.
- Spell dictionary lives in `cspell.json`, not inline `cSpell:words` comments.
  Toggle cSpell for the current buffer with `<leader>uS`.
- Snippets are VSCode-format under `snippets/` with `snippets/package.json`.
