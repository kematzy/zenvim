local keymaps = require("config.keymap")

return {
   {
      "mgierada/lazydocker.nvim",
      dependencies = { "akinsho/toggleterm.nvim" },
      event = "VeryLazy",
      keys = keymaps.lazydocker,
      opts = {
         border = "curved",
      },
   },
}

