-- Zenvim - Minimal Neovim configuration
-- Last updated: 29 August, 2026
-- Autocommands: filetype rules and yank highlight.
--

vim.filetype.add({
   extension = { slim = "slim" },
})

vim.api.nvim_create_autocmd("TextYankPost", {
   desc = "Highlight when yanking (copying) text",
   group = vim.api.nvim_create_augroup("zenvim-highlight-yank", { clear = true }),
   callback = function() vim.hl.on_yank() end,
})
