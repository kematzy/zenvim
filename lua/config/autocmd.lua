-- Zenvim - Minimal Neovim configuration
-- Last updated: 08 October, 2026
-- Autocommands: filetype rules, directory arguments, and yank highlight.
--

vim.filetype.add({
   extension = { slim = "slim" },
})

-- `zenvim some/dir` should work from that directory. Keep buffer 1 empty
-- and unnamed so the Snacks dashboard can occupy it. Drop the directory
-- argument so the explorer does not open a sidebar at startup. `:edit` of
-- a directory still uses the explorer (replace_netrw).
if vim.fn.argc(-1) == 1 then
   local arg = vim.fn.argv(0) --[[@as string]]
   if arg ~= "" and vim.fn.isdirectory(arg) == 1 then
      vim.api.nvim_set_current_dir(vim.fs.normalize(vim.fn.fnamemodify(arg, ":p")))
      vim.cmd("%argdelete")
      pcall(vim.api.nvim_buf_set_name, 0, "")
   end
end

vim.api.nvim_create_autocmd("TextYankPost", {
   desc = "Highlight when yanking (copying) text",
   group = vim.api.nvim_create_augroup("zenvim-highlight-yank", { clear = true }),
   callback = function() vim.hl.on_yank() end,
})
