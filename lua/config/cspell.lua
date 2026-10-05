-- Zenvim - Minimal Neovim configuration
-- Last updated: 05 October, 2026
-- Buffer-local cSpell (cspell_ls) attach/detach helpers.
--

-- Buffer-local cSpell (cspell_ls) attach/detach.
local M = {}

local NAME = "cspell_ls"

local function bufnr_or_current(bufnr)
   if bufnr == nil or bufnr == 0 then return vim.api.nvim_get_current_buf() end
   return bufnr
end

local function clients(bufnr) return vim.lsp.get_clients({ bufnr = bufnr, name = NAME }) end

function M.enabled(bufnr)
   bufnr = bufnr_or_current(bufnr)
   if vim.b[bufnr].cspell == false then return false end
   return #clients(bufnr) > 0
end

function M.detach(bufnr)
   bufnr = bufnr_or_current(bufnr)
   vim.b[bufnr].cspell = false
   for _, client in ipairs(clients(bufnr)) do
      pcall(vim.lsp.buf_detach_client, bufnr, client.id)
      pcall(vim.diagnostic.reset, vim.lsp.diagnostic.get_namespace(client.id), bufnr)
   end
end

function M.attach(bufnr)
   bufnr = bufnr_or_current(bufnr)
   vim.b[bufnr].cspell = true
   if #clients(bufnr) > 0 then return end

   local existing = vim.lsp.get_clients({ name = NAME })[1]
   if existing then
      vim.lsp.buf_attach_client(bufnr, existing.id)
      return
   end

   local cfg = vim.lsp.config[NAME]
   if type(cfg) ~= "table" or cfg.cmd == nil then return end
   vim.lsp.start(vim.tbl_extend("force", cfg, { name = NAME }), { bufnr = bufnr })
end

function M.set(state, bufnr)
   if state then
      M.attach(bufnr)
   else
      M.detach(bufnr)
   end
end

return M
