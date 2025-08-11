-- ZENVIM - MINIMAL - SETUP
-- Started on: 31 July, 2025
-- Requires Neovim v0.11.3 and above
-- Assistance by Claude Sonnet v4 and Grok 3
-- See: https://claude.ai/chat/077e450c-ab8a-4aeb-983b-a91f91b2ef72
--      https://grok.com/chat/cefa8717-0aee-4328-bcb6-7d1e1262d897
--

return {
   --
   -- DOCS: https://github.com/numToStr/Comment.nvim
   -- {
   "numToStr/Comment.nvim",
   event = { "BufReadPre", "BufNewFile" },
   config = function()
      require("Comment").setup({
         -- Add a space b/w comment and the line
         padding = true,
         -- Whether the cursor should stay at its position
         sticky = true,
         -- Lines to be ignored while (un)comment
         ignore = nil,
         -- LHS of toggle mappings in NORMAL mode
         toggler = {
            line = "gcc", -- Line-comment toggle keymap
            block = "gbc", -- Block-comment toggle keymap
         },
         -- LHS of operator-pending mappings in NORMAL and VISUAL mode
         opleader = {
            line = "gc", -- Line-comment keymap
            block = "gb", -- Block-comment keymap
         },
         -- LHS of extra mappings
         extra = {
            above = "gcO", -- Add comment on the line above
            below = "gco", -- Add comment on the line below
            eol = "gcA", -- Add comment at the end of line
         },
         -- Enable keybindings
         mappings = {
            basic = true, -- Operator-pending mapping; `gcc` `gbc` `gc[count]{motion}` `gb[count]{motion}`
            extra = true, -- Extra mapping; `gco`, `gcO`, `gcA`
         },
         -- Function to call before (un)comment
         pre_hook = nil,
         -- Function to call after (un)comment
         post_hook = nil,
      })
   end,
   keys = {
      -- Ctrl + / for line comment toggle in normal mode
      {
         "<C-/>",
         "gcc",
         mode = "n",
         remap = true,
         desc = "Toggle Comment Line",
      },
      {
         "<C-_>",
         "gcc",
         mode = "n",
         remap = true,
         desc = "which_key_ignore",
      },
      -- Ctrl + / for visual selection comment toggle
      {
         "<C-/>",
         "gc",
         mode = "v",
         remap = true,
         desc = "Toggle Comment Selection",
      },
      {
         "<C-_>",
         "gc",
         mode = "v",
         remap = true,
         desc = "which_key_ignore",
      },
   },
}

-- cSpell:words  opleader termcodes feedkeys linewise visualmode
