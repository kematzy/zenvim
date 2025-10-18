-- ZENVIM - MINIMAL - SETUP
-- Started on: 31 July, 2025
-- Requires Neovim v0.11.3 and above
-- Assistance by Claude Sonnet v4 and Grok 3
-- See: https://claude.ai/chat/077e450c-ab8a-4aeb-983b-a91f91b2ef72
--      https://grok.com/chat/cefa8717-0aee-4328-bcb6-7d1e1262d897

require("config.globals")
require("config.options")
-- load the keymaps configurations
local keymaps = require("config.keymap")
-- Setup global keymaps
keymaps.setup_global_keymaps()

require("config.autocmd")
require("config.lazy")

require("config.lsp")

-- cSpell:words autocmd
