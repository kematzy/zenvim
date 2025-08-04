-- ZENVIM - MINIMAL - SETUP
-- Started on: 31 July, 2025
-- Requires Neovim v0.11.3 and above
-- Assistance by Claude Sonnet v4 and Grok 3
-- See: https://claude.ai/chat/077e450c-ab8a-4aeb-983b-a91f91b2ef72
--      https://grok.com/chat/cefa8717-0aee-4328-bcb6-7d1e1262d897

-- Disable Netrw to avoid interference
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- Set leader key early
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- load the keymaps configurations
local keymaps = require("zenvim.config.keymaps")

require("zenvim.options")
require("zenvim.lazy")

-- Setup global keymaps
keymaps.setup_global_keymaps()

require("zenvim.autocommands")

-- cSpell:words autocommands
