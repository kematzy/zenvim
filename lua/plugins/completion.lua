return {
   {
      "saghen/blink.cmp",
      -- V2 (main) requires saghen/blink.lib and is still unstable.
      -- Pin to the v1 release line, which ships prebuilt binaries.
      version = "1.*",
      lazy = false,
      dependencies = { "rafamadriz/friendly-snippets" },
      opts = {
         keymap = { preset = "default" },
         appearance = {
            nerd_font_variant = "mono",
         },
         snippets = { preset = "default" },
         sources = {
            default = { "lsp", "path", "snippets", "buffer" },
         },
         completion = {
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
