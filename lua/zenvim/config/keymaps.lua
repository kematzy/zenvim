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
   { "<C-q>", "<cmd>qa<cr>", desc = "Quit (NeoVim)", noremap = true },
   { "<C-w>", "<cmd>bd<cr>", desc = "Close Buffer" },
   -- { "<leader>m", "<cmd>messages<cr>", desc = "Show Messages" },

   -- add shortcut to save current buffer.
   { "<C-s>", "<cmd>w<cr><esc>", mode = { "n", "i", "x", "s" }, desc = "Save (file)" },

   -- Clear search highlighting
   { "<Esc>", "<cmd>nohlsearch<cr>", desc = "Clear search highlighting" },

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
   { "<C-Up>", "<cmd>resize +2<cr>", desc = "Increase window height" },
   { "<C-Down>", "<cmd>resize -2<cr>", desc = "Decrease window height" },
   { "<C-Left>", "<cmd>vertical resize -2<cr>", desc = "Decrease window width" },
   { "<C-Right>", "<cmd>vertical resize +2<cr>", desc = "Increase window width" },

   -- Better indenting
   { "<", "<gv", mode = "v", desc = "Indent left and reselect" },
   { ">", ">gv", mode = "v", desc = "Indent right and reselect" },

   -- Move text up and down
   { "<A-j>", ":m .+1<cr>==", desc = "Move line down" },
   { "<A-k>", ":m .-2<cr>==", desc = "Move line up" },
   { "<A-j>", ":m '>+1<cr>gv=gv", mode = "x", desc = "Move selection down" },
   { "<A-k>", ":m '<-2<cr>gv=gv", mode = "x", desc = "Move selection up" },
}

-- LSP keymaps (applied on LspAttach)
M.lsp = {
   -- { "gD", vim.lsp.buf.declaration, desc = "Go to declaration" },
   -- { "gd", vim.lsp.buf.definition, desc = "Go to definition" },
   -- { "gi", vim.lsp.buf.implementation, desc = "Go to implementation" },
   -- { "gr", vim.lsp.buf.references, desc = "Go to references" },
   -- { "K", vim.lsp.buf.hover, desc = "Hover documentation" },
   { "<C-k>", vim.lsp.buf.signature_help, desc = "Signature help" },
   { "<leader>cn", vim.lsp.buf.rename, desc = "Rename symbol" },
   { "<leader>ca", vim.lsp.buf.code_action, desc = "Code action", mode = { "n", "v" } },

   -- { "<leader>ca", vim.lsp.buf.code_action, desc = "Code action", mode = "v" },
   { "<leader>D", vim.lsp.buf.type_definition, desc = "Type definition" },
   { "<leader>wa", vim.lsp.buf.add_workspace_folder, desc = "Add workspace folder" },
   { "<leader>wr", vim.lsp.buf.remove_workspace_folder, desc = "Remove workspace folder" },
   {
      "<leader>wl",
      function() print(vim.inspect(vim.lsp.buf.list_workspace_folders())) end,
      desc = "List workspace folders",
   },
}

-- Snacks.nvim keymaps
M.snacks = {
   -- Core functionality
   { "<leader>e", function() Snacks.explorer() end, desc = "Explorer" },
   { "<leader>z", function() Snacks.zen() end, desc = "Toggle Zen Mode" },
   { "<leader>Z", function() Snacks.zen.zoom() end, desc = "Toggle Zoom" },

   -- Scratch buffers
   { "<leader>.", function() Snacks.scratch() end, desc = "Toggle Scratch Buffer" },
   { "<leader>S", function() Snacks.scratch.select() end, desc = "Select Scratch Buffer" },

   -- Notifications
   { "<leader>n", function() Snacks.notifier.show_history() end, desc = "Notification History" },
   { "<leader>un", function() Snacks.notifier.hide() end, desc = "Dismiss All Notifications" },

   -- Buffer management
   { "<leader>bd", function() Snacks.bufdelete() end, desc = "Delete Buffer" },

   -- File operations
   { "<leader>cR", function() Snacks.rename.rename_file() end, desc = "Rename File" },

   -- Git integration
   -- { "<leader>gB", function() Snacks.gitbrowse() end, desc = "Git Browse" },
   { "<leader>gb", function() Snacks.git.blame_line() end, desc = "Git Blame Line" },
   { "<leader>gB", function() Snacks.picker.git_branches() end, desc = "Git Branches" },
   { "<leader>gl", function() Snacks.picker.git_log() end, desc = "Git Log" },
   { "<leader>gL", function() Snacks.picker.git_log_line() end, desc = "Git Log Line" },
   { "<leader>gs", function() Snacks.picker.git_status() end, desc = "Git Status" },
   { "<leader>gS", function() Snacks.picker.git_stash() end, desc = "Git Stash" },
   { "<leader>gd", function() Snacks.picker.git_diff() end, desc = "Git Diff (Hunks)" },
   { "<leader>gF", function() Snacks.picker.git_log_file() end, desc = "Git Log File" },

   -- Terminal
   -- { "<c-/>", function() Snacks.terminal() end, desc = "Toggle Terminal" },
   -- { "<c-_>", function() Snacks.terminal() end, desc = "which_key_ignore" },

   -- Word navigation
   {
      "]]",
      function() Snacks.words.jump(vim.v.count1) end,
      desc = "Next Reference",
      mode = { "n", "t" },
   },
   {
      "[[",
      function() Snacks.words.jump(-vim.v.count1) end,
      desc = "Prev Reference",
      mode = { "n", "t" },
   },

   -- Picker (fuzzy finder)
   { "<leader>ff", function() Snacks.picker.files() end, desc = "Find Files" },
   {
      "<leader>fc",
      function() Snacks.picker.files({ cwd = vim.fn.stdpath("config") }) end,
      desc = "Find Config File",
   },
   { "<leader>fg", function() Snacks.picker.grep() end, desc = "Grep" },
   { "<leader>fG", function() Snacks.picker.git_files() end, desc = "Find Git Files" },
   { "<leader>fb", function() Snacks.picker.buffers() end, desc = "Buffers" },
   { "<leader>fp", function() Snacks.picker.projects() end, desc = "Projects" },
   { "<leader>fu", function() Snacks.picker.undo() end, desc = "Undo" },
   -- { "<leader>fh", function() Snacks.picker.help() end, desc = "Help" },
   { "<leader>fr", function() Snacks.picker.recent() end, desc = "Recent Files" },
   --

   -- { "<leader>:", function() Snacks.picker.commands() end, desc = "Commands" },

   -- Search related
   { "<leader>sc", function() Snacks.picker.command_history() end, desc = "Command History" },
   { "<leader>sC", function() Snacks.picker.commands() end, desc = "Search Commands" },
   { "<leader>sh", function() Snacks.picker.help() end, desc = "Search Help Pages" },
   { "<leader>sH", function() Snacks.picker.highlights() end, desc = "Search Highlights" },
   { "<leader>si", function() Snacks.picker.icons() end, desc = "Search Icons" },
   { "<leader>sk", function() Snacks.picker.keymaps() end, desc = "Search Keymaps" },
   { "<leader>sm", function() Snacks.picker.marks() end, desc = "Search Marks" },
   { "<leader>sM", function() Snacks.picker.man() end, desc = "Search Man Pages" },
   { "<leader>s/", function() Snacks.picker.search_history() end, desc = "Search History" },
   { "<leader>sp", function() Snacks.picker.lazy() end, desc = "Search Plugin Spec" },
   { "<leader>sq", function() Snacks.picker.qflist() end, desc = "Quickfix List" },
   { "<leader>sR", function() Snacks.picker.resume() end, desc = "Resume" },
   { "<leader>su", function() Snacks.picker.undo() end, desc = "Undo History" },
   { "<leader>sa", function() Snacks.picker.autocmds() end, desc = "Search AutoCommands" },
   { '<leader>s"', function() Snacks.picker.registers() end, desc = "Search Registers" },

   -- { "<leader>sb", function() Snacks.picker.lines() end, desc = "Buffer Lines" },
   { "<leader>sd", function() Snacks.picker.diagnostics() end, desc = "Search Diagnostics" },
   {
      "<leader>sD",
      function() Snacks.picker.diagnostics_buffer() end,
      desc = "Search Buffer Diagnostics",
   },
   { "<leader>sj", function() Snacks.picker.jumps() end, desc = "Search Jumps" },
   { "<leader>sl", function() Snacks.picker.loclist() end, desc = "Search Location List" },

   { "<leader>uC", function() Snacks.picker.colorschemes() end, desc = "Change Colorscheme" },

   --
}

-- Telescope keymaps (fallback/advanced features)
M.telescope = {
   -- { "<leader>sh", function() require("telescope.builtin").help_tags() end, desc = "Search Help", },
   -- { "<leader>sk", function() require("telescope.builtin").keymaps() end, desc = "Search Keymaps",  },
   -- {
   --    "<leader>ss",
   --    function() require("telescope.builtin").builtin() end,
   --    desc = "Search Select Telescope",
   -- },
   -- {
   --    "<leader>sw",
   --    function() require("telescope.builtin").grep_string() end,
   --    desc = "Search current Word",
   -- },
   -- {
   --    "<leader>sd",
   --    function() require("telescope.builtin").diagnostics() end,
   --    desc = "Search Diagnostics",
   -- },
   -- {
   --    "<leader>sr",
   --    function() require("telescope.builtin").resume() end,
   --    desc = "Search Resume",
   -- },
}

-- Conform.nvim keymaps
M.conform = {
   {
      "<leader>f",
      function() require("conform").format({ async = true, lsp_fallback = true }) end,
      mode = { "n", "v" },
      desc = "Format buffer",
   },
}

-- akinsho/toggleterm.nvim keymaps
M.toggleterm = {
   {
      "<leader>tt",
      "<cmd>ToggleTerm size=40 dir=. direction=float name=' Terminal '<cr>",
      desc = "Terminal",
   },
}

-- mgierada/lazydocker.nvim keymaps
M.lazydocker = {
   {
      "<leader>td",
      "<cmd>Lazydocker<cr>",
      -- function() require("lazydocker").toggle() end,
      desc = "LazyDocker",
   },
}

-- kdheepak/lazygit.nvim keymaps
M.lazygit = {
   { "<leader>gg", "<cmd>LazyGit<cr>", desc = "LazyGit" },
   { "<leader>tg", "<cmd>LazyGit<cr>", desc = "LazyGit" },
   { "<leader>tG", "<cmd>LazyGitConfig<cr>", desc = "LazyGit Config" },
}

-- folke/which-key.nvim keymaps /  group definitions
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

-- cSpell:words loclist colorschemes akinsho toggleterm mgierada kdheepak mikavilpas
