-- Zenvim - Minimal Neovim configuration
-- Last updated: 29 August, 2026
-- Autocommands: filetype rules, directory arguments, and yank highlight.
--

vim.filetype.add({
   extension = { slim = "slim" },
})

-- `zenvim some/dir` should work from that directory. Netrw is disabled, so
-- Snacks explorer lists the files; this sets the process cwd for pickers and git.
if vim.fn.argc(-1) == 1 then
   local arg = vim.fn.argv(0) --[[@as string]]
   if arg ~= "" and vim.fn.isdirectory(arg) == 1 then
      vim.api.nvim_set_current_dir(vim.fs.normalize(vim.fn.fnamemodify(arg, ":p")))
   end
end

vim.api.nvim_create_autocmd("TextYankPost", {
   desc = "Highlight when yanking (copying) text",
   group = vim.api.nvim_create_augroup("zenvim-highlight-yank", { clear = true }),
   callback = function() vim.hl.on_yank() end,
})
