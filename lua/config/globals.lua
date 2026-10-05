-- Zenvim - Minimal Neovim configuration
-- Last updated: 18 October, 2025
-- Global variables: leader keys, netrw disable and Nerd Font flag.
--

-- Disable Netrw to avoid interference
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- Set leader key early
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Set to true if you have a Nerd Font installed and selected in the terminal
vim.g.have_nerd_font = true
