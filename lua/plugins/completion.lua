-- Zenvim - Minimal Neovim configuration
-- Last updated: 01 October, 2026
-- Autocompletion: blink.cmp setup and keymaps.
--

return {
   -- Blink.cmp - Autocompletion with prebuilt binaries
   -- DOCS: https://github.com/saghen/blink.cmp
   {
      "saghen/blink.cmp",
      -- V2 (main) requires saghen/blink.lib and is still unstable.
      -- Pin to the v1 release line, which ships prebuilt binaries.
      version = "1.*",
      lazy = false,
      dependencies = {
         -- Friendly Snippets - Community collection of VSCode-style snippets
         -- DOCS: https://github.com/rafamadriz/friendly-snippets
         {
            "rafamadriz/friendly-snippets",
         },
      },
      opts = {
         -- Tab or Enter accepts the selected word and stays in insert mode,
         -- so the next key keeps typing. Ctrl-e dismisses the menu.
         keymap = {
            preset = "default",
            ["<Tab>"] = { "select_and_accept", "snippet_forward", "fallback" },
            ["<S-Tab>"] = { "snippet_backward", "fallback" },
            ["<CR>"] = { "select_and_accept", "fallback" },
         },
         appearance = {
            nerd_font_variant = "mono",
         },
         snippets = { preset = "default" },
         sources = {
            default = { "lsp", "path", "snippets", "buffer" },
         },
         completion = {
            -- Ghost text previews the word. auto_insert would put it in the
            -- buffer early, so the next character restarts the match.
            list = {
               selection = {
                  preselect = true,
                  auto_insert = false,
               },
            },
            ghost_text = { enabled = true },
            accept = {
               auto_brackets = { enabled = true },
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
   },
}
