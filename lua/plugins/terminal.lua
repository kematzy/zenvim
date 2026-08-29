local Zen = require("config.zen")
local keymaps = require("config.keymap")

return {
   {
      "akinsho/toggleterm.nvim",
      version = "*",
      opts = {
         highlights = {
            FloatBorder = {
               guifg = Zen.palette.terminal_border,
               guibg = Zen.palette.terminal_bg,
            },
         },
      },
      keys = keymaps.toggleterm,
   },
}
