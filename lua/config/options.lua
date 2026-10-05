-- Zenvim - Minimal Neovim configuration
-- Last updated: 01 October, 2026
-- Editor options applied via `vim.opt`.
--

vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.signcolumn = "yes"
vim.opt.cursorline = true

vim.opt.list = true
vim.opt.listchars = {
   tab = "→ ",
   eol = "↲",
   nbsp = "␣",
   space = "·",
   lead = "·",
   trail = "•",
   extends = "⟩",
   precedes = "⟨",
}
vim.opt.showbreak = "↪ "

vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.hlsearch = true
vim.opt.incsearch = true
vim.opt.inccommand = "split"

vim.opt.wrap = false
vim.opt.breakindent = true

vim.opt.expandtab = true
vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.shiftwidth = 2
vim.opt.smartindent = true
vim.opt.textwidth = 119
vim.opt.colorcolumn = "-21,-40,+1"

vim.opt.clipboard = "unnamedplus"
vim.opt.confirm = true
vim.opt.showmode = false
vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undofile = true

vim.opt.termguicolors = true
vim.opt.scrolloff = 8
vim.opt.sidescrolloff = 8
vim.opt.linespace = 2
vim.opt.winborder = "rounded"

vim.opt.timeoutlen = 300
vim.opt.ttimeoutlen = 50
vim.opt.updatetime = 250
vim.opt.history = 1000
vim.opt.undolevels = 1000
