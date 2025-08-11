-- ZENVIM - MINIMAL - SETUP
-- Started on: 31 July, 2025
-- Requires Neovim v0.11.3 and above
-- Assistance by Claude Sonnet v4 and Grok 3
-- See: https://claude.ai/chat/077e450c-ab8a-4aeb-983b-a91f91b2ef72
--      https://grok.com/chat/cefa8717-0aee-4328-bcb6-7d1e1262d897
--

-- enable line numbers
vim.opt.number = true
-- enable relative line numbers. Default: false
vim.opt.relativenumber = true
-- expand tab to spaces
vim.opt.expandtab = true
-- set indent width to n spaces
vim.opt.shiftwidth = 2
-- set n spaces for tabs (prettier default)
vim.opt.tabstop = 2
-- enable smart·auto-indenting·when·starting·a·new·line
vim.opt.smartindent = true
-- disable line wrapping
vim.opt.wrap = false
-- highlight the current cursor line
vim.opt.cursorline = true
-- Maximum width of text that is being inserted.
-- A longer line will be broken after whitespace to get the width.
-- A zero value disables this.
vim.opt.textwidth = 120
-- comma-separated list of highlighted screen columns used to align text.
-- makes screen redrawing slower
vim.opt.colorcolumn = "-20,-40,+1"
-- add support for showing hidden whitespace characters. Default: false
vim.opt.list = true
-- Characters used to visually show hidden characters
vim.opt.listchars = {
   -- 2 - 3 characters to show a tab. The 3rd character is optional.
   tab = "→ ",
   -- character to show at the end of each line.
   -- when omitted, there is no extra character at the end of the line.
   eol = "↲",
   -- character to show for a non-breakable space character
   nbsp = "␣",
   -- character to show for a space.
   space = "·",
   -- character to show for leading spaces.
   lead = "·",
   -- character to show for trailing spaces.
   trail = "•",
   -- character to show in the last column, when 'wrap' is off and
   -- the line continues beyond the right of the screen.
   extends = "⟩",
   -- character to show in the first visible column of the physical line,
   -- when there is text prec ding the character visible in the first column.
   precedes = "⟨",
}
-- string to put at the start of lines that have been wrapped.
vim.opt.showbreak = "↪ "
-- confirm to save changes before exiting modified buffer
vim.opt.confirm = true
-- disable show mode if we have a status-line
vim.opt.showmode = false
-- turn off swapfile
vim.opt.swapfile = false
-- disable making·a·backup·before·overwriting·a·file.
vim.opt.backup = false
-- enable persistent undo across sessions
vim.opt.undofile = true
-- disable search result highlighting. Default: true
vim.opt.hlsearch = false
-- show matches while typing search pattern
vim.opt.incsearch = true
-- enable 24-bit RGB color in the terminal
vim.opt.termguicolors = true
-- minimum number of screen lines to keep above and below the cursor
vim.opt.scrolloff = 8
-- when and how to display the sign column
vim.opt.signcolumn = "yes"
-- time in milliseconds for CursorHold events and swap file writing
vim.opt.updatetime = 50
-- Adds 2px of vertical padding per line. Only works in GUIs, not terminals
vim.opt.linespace = 2
-- Adds "visual margin" when scrolling
vim.opt.scrolloff = 5

-- cSpell:words shiftwidth smartindent textwidth cursorline colorcolumn listchars prec showbreak  showmode swapfile  undofile hlsearch  incsearch termguicolors signcolumn  updatetime linespace scrolloff
