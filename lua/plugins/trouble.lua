local keymaps = require("config.keymap")

return {
   {
      "folke/trouble.nvim",
      opts = {},
      cmd = "Trouble",
      keys = keymaps.trouble,
   },
}
