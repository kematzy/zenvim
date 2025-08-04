-- ZENVIM - MINIMAL - SETUP
-- Started on: 31 July, 2025
-- Requires Neovim v0.11.3 and above
-- Assistance by Claude Sonnet v4 and Grok 3
-- See: https://claude.ai/chat/077e450c-ab8a-4aeb-983b-a91f91b2ef72
--      https://grok.com/chat/cefa8717-0aee-4328-bcb6-7d1e1262d897
--

-- load the keymaps configurations
local keymaps = require("zenvim.config.keymaps")

return {
   -- LSP Configuration
   -- DOCS: https://github.com/neovim/nvim-lspconfig
   {
      "neovim/nvim-lspconfig",
      event = { "BufReadPre", "BufNewFile" },
      dependencies = {
         "williamboman/mason.nvim",
         "williamboman/mason-lspconfig.nvim",
         "WhoIsSethDaniel/mason-tool-installer.nvim",
      },

      config = function()
         local servers = {
            bashls = {},
            cssls = {},
            gopls = {}, -- Go
            html = {},
            intelephense = {}, -- PHP
            jsonls = {},
            lua_ls = {},
            marksman = {}, -- Markdown
            pyright = {}, -- Python
            solargraph = {}, -- Ruby
            -- tsserver = {}, -- JavaScript/TypeScript
            taplo = {}, -- TOML
            yamlls = {},
         }

         local capabilities = vim.lsp.protocol.make_client_capabilities()
         capabilities = vim.tbl_deep_extend("force", capabilities, require("blink.cmp").get_lsp_capabilities())

         -- Setup each server individually (more reliable than setup_handlers)
         for server_name, server_config in pairs(servers) do
            server_config.capabilities =
               vim.tbl_deep_extend("force", {}, capabilities, server_config.capabilities or {})
            require("lspconfig")[server_name].setup(server_config)
         end

         -- LSP keymaps
         vim.api.nvim_create_autocmd("LspAttach", {
            group = vim.api.nvim_create_augroup("UserLspConfig", {}),
            callback = function(ev)
               keymaps.setup_lsp_keymaps(ev.buf)
            end,
         })
      end,
   },
}


-- cSpell:words williamboman lspconfig cssls jsonls yamlls taplo bashls pyright gopls gofumpt augroup
