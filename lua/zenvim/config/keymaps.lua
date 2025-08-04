-- ZENVIM - MINIMAL - SETUP
-- Started on: 31 July, 2025
-- Requires Neovim v0.11.3 and above
-- Assistance by Claude Sonnet v4 and Grok 3
-- See: https://claude.ai/chat/077e450c-ab8a-4aeb-983b-a91f91b2ef72
--      https://grok.com/chat/cefa8717-0aee-4328-bcb6-7d1e1262d897
--
-- Centralized keybinding configuration
local M = {}

-- Global keymaps (not plugin-specific)
M.global = {
  -- add shortcut to quit NeoVim
  -- { "<leader>qq", "<cmd>qa<CR>", desc = "Quit NeoVim" },
  { "<C-q>", "<cmd>qa<CR>", desc = "Quit (NeoVim)", noremap = true },
  -- { "<C-w>", "<cmd>bd<CR>", desc = "Close Buffer" },
  -- { "<C-/>", "<cmd>gcc<CR>", desc = "Comment Toggle" },

  -- add shortcut to save current buffer.
  -- { "<C-s>", "<cmd>w<CR><ESC>", mode = { "n", "i", "x", "s" },  desc = "Save (file)" },

   -- Clear search highlighting
   { "<Esc>", "<cmd>nohlsearch<CR>", desc = "Clear search highlighting" },

   -- Diagnostics
   { "[d", vim.diagnostic.goto_prev, desc = "Go to previous diagnostic" },
   { "]d", vim.diagnostic.goto_next, desc = "Go to next diagnostic" },
   { "<leader>xq", vim.diagnostic.setloclist, desc = "Open diagnostic quickfix list" },

   -- Better window navigation
   { "<C-h>", "<C-w>h", desc = "Move to left window" },
   { "<C-j>", "<C-w>j", desc = "Move to bottom window" },
   { "<C-k>", "<C-w>k", desc = "Move to top window" },
   { "<C-l>", "<C-w>l", desc = "Move to right window" },

   -- Resize windows
   { "<C-Up>", "<cmd>resize +2<CR>", desc = "Increase window height" },
   { "<C-Down>", "<cmd>resize -2<CR>", desc = "Decrease window height" },
   { "<C-Left>", "<cmd>vertical resize -2<CR>", desc = "Decrease window width" },
   { "<C-Right>", "<cmd>vertical resize +2<CR>", desc = "Increase window width" },

   -- Better indenting
   { "<", "<gv", mode = "v", desc = "Indent left and reselect" },
   { ">", ">gv", mode = "v", desc = "Indent right and reselect" },

   -- Move text up and down
   { "<A-j>", ":m .+1<CR>==", desc = "Move line down" },
   { "<A-k>", ":m .-2<CR>==", desc = "Move line up" },
   { "<A-j>", ":m '>+1<CR>gv=gv", mode = "x", desc = "Move selection down" },
   { "<A-k>", ":m '<-2<CR>gv=gv", mode = "x", desc = "Move selection up" },
}

-- Function to apply global keymaps
function M.setup_global_keymaps()
   -- print("Setting up global keymaps")
   for _, keymap in ipairs(M.global) do
      local key = keymap[1]
      local cmd = keymap[2]
      local mode = keymap.mode or "n"
      local modes = type(mode) == "string" and { mode } or mode
      local opts = {
         desc = keymap.desc,
         noremap = keymap.noremap ~= false,
         silent = keymap.silent ~= false,
      }

      -- print("Setting global keymap: " .. key .. " with mode: " .. vim.inspect(modes) .. " with opts: " .. vim.inspect(opts))
      vim.keymap.set(modes, key, cmd, opts)
   end
end


return M

-- cSpell:words
