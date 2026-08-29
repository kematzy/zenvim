local servers = {
   "bashls",
   "cssls",
   "css_variables",
   "cspell_ls",
   "docker_language_server",
   "gopls",
   "html",
   "intelephense",
   "jsonls",
   "lemminx",
   "lua_ls",
   "marksman",
   "pyright",
   "solargraph",
   "sqlls",
   "tailwindcss",
   "taplo",
   "ts_ls",
   "yamlls",
}

return {
   {
      "folke/lazydev.nvim",
      ft = "lua",
      opts = {
         library = {
            { path = "${3rd}/luv/library", words = { "vim%.uv" } },
         },
      },
   },

   {
      "neovim/nvim-lspconfig",
      dependencies = {
         "mason-org/mason.nvim",
         "mason-org/mason-lspconfig.nvim",
         "saghen/blink.cmp",
         { "j-hui/fidget.nvim", opts = {} },
      },

      config = function()
         vim.api.nvim_create_autocmd("LspAttach", {
            group = vim.api.nvim_create_augroup("zenvim-lsp-attach", { clear = true }),
            callback = function(event)
               if vim.bo[event.buf].buftype == "terminal" then return end

               local map = function(keys, func, desc, mode)
                  vim.keymap.set(mode or "n", keys, func, {
                     buffer = event.buf,
                     desc = "LSP: " .. desc,
                  })
               end

               map("gd", function() Snacks.picker.lsp_definitions() end, "Goto Definition")
               map("gr", function() Snacks.picker.lsp_references() end, "Goto References")
               map("gI", function() Snacks.picker.lsp_implementations() end, "Goto Implementation")
               map("gD", vim.lsp.buf.declaration, "Goto Declaration")
               map(
                  "<leader>D",
                  function() Snacks.picker.lsp_type_definitions() end,
                  "Type Definition"
               )
               map("<leader>ds", function() Snacks.picker.lsp_symbols() end, "Document Symbols")
               map(
                  "<leader>ws",
                  function() Snacks.picker.lsp_workspace_symbols() end,
                  "Workspace Symbols"
               )
               map("<leader>cr", vim.lsp.buf.rename, "Rename")
               map("<leader>ca", vim.lsp.buf.code_action, "Code Action", { "n", "x" })

               local client = vim.lsp.get_client_by_id(event.data.client_id)
               if
                  client
                  and client:supports_method(
                     vim.lsp.protocol.Methods.textDocument_documentHighlight,
                     event.buf
                  )
               then
                  local highlight_augroup =
                     vim.api.nvim_create_augroup("zenvim-lsp-highlight", { clear = false })
                  vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
                     buffer = event.buf,
                     group = highlight_augroup,
                     callback = vim.lsp.buf.document_highlight,
                  })
                  vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
                     buffer = event.buf,
                     group = highlight_augroup,
                     callback = vim.lsp.buf.clear_references,
                  })
                  vim.api.nvim_create_autocmd("LspDetach", {
                     group = vim.api.nvim_create_augroup("zenvim-lsp-detach", { clear = true }),
                     callback = function(event2)
                        vim.lsp.buf.clear_references()
                        vim.api.nvim_clear_autocmds({
                           group = "zenvim-lsp-highlight",
                           buffer = event2.buf,
                        })
                     end,
                  })
               end
            end,
         })

         vim.diagnostic.config({
            virtual_text = true,
            update_in_insert = false,
            underline = true,
            severity_sort = true,
            float = {
               focusable = false,
               border = "rounded",
               source = "if_many",
            },
            signs = vim.g.have_nerd_font and {
               text = {
                  [vim.diagnostic.severity.ERROR] = "󰅚",
                  [vim.diagnostic.severity.WARN] = "󰀪",
                  [vim.diagnostic.severity.INFO] = "󰋽",
                  [vim.diagnostic.severity.HINT] = "󰌶",
               },
            } or true,
         })

         vim.lsp.config("*", {
            capabilities = require("blink.cmp").get_lsp_capabilities(),
         })

         vim.lsp.config("lua_ls", {
            settings = {
               Lua = {
                  completion = { callSnippet = "Replace" },
                  diagnostics = { disable = { "missing-fields" } },
               },
            },
         })

         vim.lsp.config("cspell_ls", {
            filetypes = {
               "bash",
               "css",
               "dockerfile",
               "go",
               "html",
               "javascript",
               "javascriptreact",
               "json",
               "lua",
               "markdown",
               "php",
               "python",
               "ruby",
               "scss",
               "sh",
               "sql",
               "typescript",
               "typescriptreact",
               "yaml",
            },
         })

         vim.lsp.config("yamlls", {
            settings = {
               redhat = { telemetry = { enabled = false } },
               yaml = { format = { enable = false } },
            },
         })

         require("mason-lspconfig").setup({
            ensure_installed = servers,
         })
      end,
   },
}
