-- ZENVIM - MINIMAL - SETUP
-- Started on: 31 July, 2025
-- Requires Neovim v0.11.3 and above
-- Assistance by Claude Sonnet v4 and Grok 3
-- See: https://claude.ai/chat/077e450c-ab8a-4aeb-983b-a91f91b2ef72
--      https://grok.com/chat/cefa8717-0aee-4328-bcb6-7d1e1262d897
--

return {
   -- Completion
   {
      "saghen/blink.cmp",
      lazy = false, -- lazy loading handled internally
      dependencies = {
         "rafamadriz/friendly-snippets",
      },
      version = "v0.*",
      opts = {
         keymap = { preset = "default" },
         appearance = {
            use_nvim_cmp_as_default = true,
            nerd_font_variant = "mono",
         },
         sources = {
            default = { "lsp", "path", "snippets", "buffer" },
            providers = {
               snippets = {
                  name = "snippets",
                  module = "blink.cmp.sources.snippets",
                  score_offset = -3,
                  -- Add friendly-snippets and custom snippets
                  opts = {
                     show_autosnippets = true,
                  },
               },
            },
         },
         completion = {
            accept = {
               auto_brackets = {
                  enabled = true,
               },
            },
            menu = {
               draw = {
                  treesitter = { "lsp" },
               },
            },
            documentation = {
               auto_show = true,
               auto_show_delay_ms = 200,
            },
         },
         signature = { enabled = true },
      },
      opts_extend = { "sources.default" },
      config = function(_, opts)
         -- Ensure friendly-snippets are loaded
         require("luasnip.loaders.from_vscode").lazy_load()
         -- Load custom snippets
         require("luasnip.loaders.from_vscode").lazy_load({ paths = { vim.fn.stdpath("config") .. "/snippets" } })
         require("blink.cmp").setup(opts)
      end,
   },
   -- Add luasnip for better snippet support
   {
      "L3MON4D3/LuaSnip",
      dependencies = {
         "rafamadriz/friendly-snippets",
      },
      build = "make install_jsregexp",
      opts = {
         history = true,
         delete_check_events = "TextChanged",
      },
   },
}

-- cSpell:words saghen rafamadriz
