-- ZENVIM - MINIMAL - SETUP
-- Started on: 31 July, 2025
-- Requires Neovim v0.11.3 and above
-- Assistance by Claude Sonnet v4 and Grok 3
-- See: https://claude.ai/chat/077e450c-ab8a-4aeb-983b-a91f91b2ef72
--      https://grok.com/chat/cefa8717-0aee-4328-bcb6-7d1e1262d897
--

return {
   -- Nvim Treesitter configurations and abstraction layer
   -- DOCS: https://github.com/nvim-treesitter/nvim-treesitter
   {
      "nvim-treesitter/nvim-treesitter",
      build = ":TSUpdate",

      config = function()
         require("nvim-treesitter.configs").setup({
            ensure_installed = {
               "bash",
               "comment", -- grammar for TODO, FIXME comments
               "css",
               "csv",
               "desktop", -- parser for .desktop and .directory files
               "diff",
               "dockerfile",
               "editorconfig",
               "go",
               "gitignore",
               "html",
               "ini",
               "javascript",
               "json",
               "jsonc",
               "lua",
               "luadoc",
               "markdown",
               "php",
               "phpdoc",
               "python",
               "regex",
               "ruby",
               "scss",
               "slim",
               "sql",
               "svelte",
               "vim",
               "vimdoc",
               "tmux",
               "toml",
               "tsv",
               "xml",
               "yaml",
            },
            sync_install = false,
            auto_install = true,
            highlight = {
               enable = true,
               additional_vim_regex_highlighting = false,
            },
            indent = {
               enable = true,
            },
         })
      end,
   },
}

-- cSpell:words vimdoc
