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

-- LSP keymaps (applied on LspAttach)
M.lsp = {
   { "gD", vim.lsp.buf.declaration, desc = "Go to declaration" },
   { "gd", vim.lsp.buf.definition, desc = "Go to definition" },
   { "gi", vim.lsp.buf.implementation, desc = "Go to implementation" },
   { "gr", vim.lsp.buf.references, desc = "Go to references" },
   { "K", vim.lsp.buf.hover, desc = "Hover documentation" },
   { "<C-k>", vim.lsp.buf.signature_help, desc = "Signature help" },
   { "<leader>rn", vim.lsp.buf.rename, desc = "Rename symbol" },
   { "<leader>ca", vim.lsp.buf.code_action, desc = "Code action", mode = { "n", "v"} },

   -- { "<leader>ca", vim.lsp.buf.code_action, desc = "Code action", mode = "v" },
   { "<leader>D", vim.lsp.buf.type_definition, desc = "Type definition" },
   { "<leader>wa", vim.lsp.buf.add_workspace_folder, desc = "Add workspace folder" },
   { "<leader>wr", vim.lsp.buf.remove_workspace_folder, desc = "Remove workspace folder" },
   {
      "<leader>wl",
      function()
         print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
      end,
      desc = "List workspace folders",
   },
}

-- Snacks.nvim keymaps
M.snacks = {
   -- Core functionality
   {
      "<leader>e",
      function()
         Snacks.explorer()
      end,
      desc = "Explorer",
   },
   {
      "<leader>z",
      function()
         Snacks.zen()
      end,
      desc = "Toggle Zen Mode",
   },
   {
      "<leader>Z",
      function()
         Snacks.zen.zoom()
      end,
      desc = "Toggle Zoom",
   },

   -- Scratch buffers
   {
      "<leader>.",
      function()
         Snacks.scratch()
      end,
      desc = "Toggle Scratch Buffer",
   },
   {
      "<leader>S",
      function()
         Snacks.scratch.select()
      end,
      desc = "Select Scratch Buffer",
   },

   -- Notifications
   {
      "<leader>n",
      function()
         Snacks.notifier.show_history()
      end,
      desc = "Notification History",
   },
   {
      "<leader>un",
      function()
         Snacks.notifier.hide()
      end,
      desc = "Dismiss All Notifications",
   },

   -- Buffer management
   {
      "<leader>bd",
      function()
         Snacks.bufdelete()
      end,
      desc = "Delete Buffer",
   },

   -- File operations
   {
      "<leader>cR",
      function()
         Snacks.rename.rename_file()
      end,
      desc = "Rename File",
   },

   -- Git integration
   {
      "<leader>gB",
      function()
         Snacks.gitbrowse()
      end,
      desc = "Git Browse",
   },
   {
      "<leader>gb",
      function()
         Snacks.git.blame_line()
      end,
      desc = "Git Blame Line",
   },
   {
      "<leader>gf",
      function()
         Snacks.lazygit.log_file()
      end,
      desc = "Lazygit Current File History",
   },
   {
      "<leader>gg",
      function()
         Snacks.lazygit()
      end,
      desc = "Lazygit",
   },
   {
      "<leader>gl",
      function()
         Snacks.lazygit.log()
      end,
      desc = "Lazygit Log (cwd)",
   },

   -- Terminal
   {
      "<c-/>",
      function()
         Snacks.terminal()
      end,
      desc = "Toggle Terminal",
   },
   {
      "<c-_>",
      function()
         Snacks.terminal()
      end,
      desc = "which_key_ignore",
   },

   -- Word navigation
   {
      "]]",
      function()
         Snacks.words.jump(vim.v.count1)
      end,
      desc = "Next Reference",
      mode = { "n", "t" },
   },
   {
      "[[",
      function()
         Snacks.words.jump(-vim.v.count1)
      end,
      desc = "Prev Reference",
      mode = { "n", "t" },
   },

   -- Picker (fuzzy finder)
   {
      "<leader>ff",
      function()
         Snacks.picker.files()
      end,
      desc = "Find Files",
   },
   {
      "<leader>fg",
      function()
         Snacks.picker.grep()
      end,
      desc = "Grep",
   },
   {
      "<leader>fb",
      function()
         Snacks.picker.buffers()
      end,
      desc = "Buffers",
   },
   {
      "<leader>fh",
      function()
         Snacks.picker.help()
      end,
      desc = "Help",
   },
   {
      "<leader>fr",
      function()
         Snacks.picker.recent()
      end,
      desc = "Recent Files",
   },
   {
      "<leader>fc",
      function()
         Snacks.picker.command_history()
      end,
      desc = "Command History",
   },
   {
      "<leader>:",
      function()
         Snacks.picker.commands()
      end,
      desc = "Commands",
   },
}

-- Conform.nvim keymaps
M.conform = {
   {
      "<leader>f",
      function()
         require("conform").format({ async = true, lsp_fallback = true })
      end,
      mode = { "n", "v" },
      desc = "Format buffer",
   },
}

-- Which-key group definitions
M.which_key_groups = {
   { "<leader>c", group = "Code" },
   { "<leader>f", group = "File/Find" },
   { "<leader>g", group = "Git" },
   { "<leader>s", group = "Search" },
   { "<leader>u", group = "UI" },
   { "<leader>w", group = "Windows/Workspace" },
   { "<leader>x", group = "Diagnostics/Quickfix" },
   { "<leader>b", group = "Buffers" },
   { "<leader>t", group = "Toggle/Terminal" },
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

-- Function to apply LSP keymaps (called in LspAttach autocmd)
function M.setup_lsp_keymaps(bufnr)
   -- print("Setting up LSP keymaps for buffer: " .. bufnr)
   for _, keymap in ipairs(M.lsp) do
      local key = keymap[1]
      local cmd = keymap[2]
      local mode = keymap.mode or "n"
      local modes = type(mode) == "string" and { mode } or mode
      local opts = {
         desc = keymap.desc,
         buffer = bufnr,
         noremap = keymap.noremap ~= false,
         silent = keymap.silent ~= false,
      }

      -- print("Setting LSP keymap: " .. key .. " with mode: " .. vim.inspect(modes) .. " with opts: " .. vim.inspect(opts))
      vim.keymap.set(modes, key, cmd, opts)
   end
end

return M

-- cSpell:words
