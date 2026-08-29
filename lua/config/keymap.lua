-- Centralized keybinding configuration.
-- LSP buffer maps live in lua/plugins/lsp.lua (LspAttach only).
local M = {}

local function apply(maps)
   for _, keymap in ipairs(maps) do
      local opts = {
         desc = keymap.desc,
         silent = keymap.silent ~= false,
      }
      if keymap.remap then
         opts.remap = true
      else
         opts.noremap = keymap.noremap ~= false
      end
      vim.keymap.set(keymap.mode or "n", keymap[1], keymap[2], opts)
   end
end

M.global = {
   {
      "<C-q>",
      "<cmd>qa<cr>",
      desc = "Quit Neovim",
   },
   {
      "<C-s>",
      "<cmd>w<cr><esc>",
      mode = { "n", "i", "x", "s" },
      desc = "Save file",
   },
   { "<Esc>", "<cmd>nohlsearch<cr>", desc = "Clear search highlighting" },

   {
      "[d",
      function() vim.diagnostic.jump({ count = -1, float = true }) end,
      desc = "Previous diagnostic",
   },
   {
      "]d",
      function() vim.diagnostic.jump({ count = 1, float = true }) end,
      desc = "Next diagnostic",
   },
   { "<leader>xq", vim.diagnostic.setloclist, desc = "Diagnostic location list" },

   { "<C-h>", "<C-w>h", desc = "Move to left window" },
   { "<C-j>", "<C-w>j", desc = "Move to bottom window" },
   { "<C-k>", "<C-w>k", desc = "Move to top window" },
   { "<C-l>", "<C-w>l", desc = "Move to right window" },

   { "<C-Up>", "<cmd>resize +2<cr>", desc = "Increase window height" },
   { "<C-Down>", "<cmd>resize -2<cr>", desc = "Decrease window height" },
   { "<C-Left>", "<cmd>vertical resize -2<cr>", desc = "Decrease window width" },
   { "<C-Right>", "<cmd>vertical resize +2<cr>", desc = "Increase window width" },

   { "<", "<gv", mode = "v", desc = "Indent left and reselect" },
   { ">", ">gv", mode = "v", desc = "Indent right and reselect" },

   { "<A-j>", "<cmd>m .+1<cr>==", desc = "Move line down" },
   { "<A-k>", "<cmd>m .-2<cr>==", desc = "Move line up" },
   { "<A-j>", ":m '>+1<cr>gv=gv", mode = "x", desc = "Move selection down" },
   { "<A-k>", ":m '<-2<cr>gv=gv", mode = "x", desc = "Move selection up" },

   -- Neovim 0.10+ built-in commenting (`gcc` / `gc`)
   { "<C-/>", "gcc", mode = "n", remap = true, desc = "Toggle comment line" },
   { "<C-_>", "gcc", mode = "n", remap = true, desc = "which_key_ignore" },
   { "<C-/>", "gc", mode = "x", remap = true, desc = "Toggle comment selection" },
   { "<C-_>", "gc", mode = "x", remap = true, desc = "which_key_ignore" },
}

M.snacks = {
   { "<leader>e", function() Snacks.explorer() end, desc = "Explorer" },
   { "<leader>z", function() Snacks.zen() end, desc = "Toggle Zen Mode" },
   { "<leader>Z", function() Snacks.zen.zoom() end, desc = "Toggle Zoom" },

   { "<leader>.", function() Snacks.scratch() end, desc = "Toggle Scratch Buffer" },
   { "<leader>S", function() Snacks.scratch.select() end, desc = "Select Scratch Buffer" },

   { "<leader>n", function() Snacks.notifier.show_history() end, desc = "Notification History" },
   { "<leader>un", function() Snacks.notifier.hide() end, desc = "Dismiss All Notifications" },

   { "<leader>bd", function() Snacks.bufdelete() end, desc = "Delete Buffer" },
   { "<leader>cR", function() Snacks.rename.rename_file() end, desc = "Rename File" },

   { "<leader>gb", function() Snacks.git.blame_line() end, desc = "Git Blame Line" },
   { "<leader>gB", function() Snacks.picker.git_branches() end, desc = "Git Branches" },
   { "<leader>gl", function() Snacks.picker.git_log() end, desc = "Git Log" },
   { "<leader>gL", function() Snacks.picker.git_log_line() end, desc = "Git Log Line" },
   { "<leader>gs", function() Snacks.picker.git_status() end, desc = "Git Status" },
   { "<leader>gS", function() Snacks.picker.git_stash() end, desc = "Git Stash" },
   { "<leader>gd", function() Snacks.picker.git_diff() end, desc = "Git Diff (Hunks)" },
   { "<leader>gF", function() Snacks.picker.git_log_file() end, desc = "Git Log File" },
   { "<leader>gg", function() Snacks.lazygit() end, desc = "LazyGit" },
   { "<leader>tg", function() Snacks.lazygit() end, desc = "LazyGit" },

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
   { "<leader>fr", function() Snacks.picker.recent() end, desc = "Recent Files" },

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
   { "<leader>sd", function() Snacks.picker.diagnostics() end, desc = "Search Diagnostics" },
   {
      "<leader>sD",
      function() Snacks.picker.diagnostics_buffer() end,
      desc = "Search Buffer Diagnostics",
   },
   { "<leader>sj", function() Snacks.picker.jumps() end, desc = "Search Jumps" },
   { "<leader>sl", function() Snacks.picker.loclist() end, desc = "Search Location List" },
   { "<leader>uC", function() Snacks.picker.colorschemes() end, desc = "Change Colorscheme" },
}

M.conform = {
   {
      "<leader>cf",
      function() require("conform").format({ async = true, lsp_format = "fallback" }) end,
      mode = { "n", "v" },
      desc = "Format buffer",
   },
}

M.toggleterm = {
   {
      "<leader>tt",
      "<cmd>ToggleTerm size=40 dir=. direction=float name=' Terminal '<cr>",
      desc = "Terminal",
   },
}

M.lazydocker = {
   { "<leader>td", "<cmd>Lazydocker<cr>", desc = "LazyDocker" },
}

M.yazi = {
   { "<leader>ty", "<cmd>Yazi<cr>", desc = "Yazi (Current File)", mode = { "n", "v" } },
   { "<leader>tY", "<cmd>Yazi cwd<cr>", desc = "Yazi (Working directory)" },
   { "<leader>t.", "<cmd>Yazi toggle<cr>", desc = "Resume last Yazi session" },
}

M.trouble = {
   { "<leader>xx", "<cmd>Trouble diagnostics toggle<cr>", desc = "Diagnostics (Trouble)" },
   {
      "<leader>xX",
      "<cmd>Trouble diagnostics toggle filter.buf=0<cr>",
      desc = "Buffer Diagnostics (Trouble)",
   },
   { "<leader>cs", "<cmd>Trouble symbols toggle focus=false<cr>", desc = "Symbols (Trouble)" },
   {
      "<leader>cl",
      "<cmd>Trouble lsp toggle focus=false win.position=right<cr>",
      desc = "LSP Definitions / references / ... (Trouble)",
   },
   { "<leader>xL", "<cmd>Trouble loclist toggle<cr>", desc = "Location List (Trouble)" },
   { "<leader>xQ", "<cmd>Trouble qflist toggle<cr>", desc = "Quickfix List (Trouble)" },
}

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

function M.setup_global_keymaps() apply(M.global) end

return M
