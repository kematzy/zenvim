-- nvim-treesitter `main` is required for Neovim 0.12 (highlighter + queries).
-- `master` is frozen for 0.11 and crashes the decoration provider on markdown previews.
local parsers = {
   "bash",
   "comment",
   "css",
   "csv",
   "diff",
   "dockerfile",
   "go",
   "gitignore",
   "html",
   "ini",
   "javascript",
   "json",
   "lua",
   "luadoc",
   "markdown",
   "markdown_inline",
   "php",
   "phpdoc",
   "python",
   "regex",
   "ruby",
   "scss",
   "slim",
   "sql",
   "svelte",
   "tsx",
   "typescript",
   "vim",
   "vimdoc",
   "toml",
   "tsv",
   "xml",
   "yaml",
}

return {
   {
      "nvim-treesitter/nvim-treesitter",
      branch = "main",
      lazy = false,
      build = ":TSUpdate",
      config = function()
         require("nvim-treesitter").install(parsers)

         vim.api.nvim_create_autocmd("FileType", {
            group = vim.api.nvim_create_augroup("zenvim-treesitter", { clear = true }),
            callback = function(args)
               if not pcall(vim.treesitter.start, args.buf) then return end
               vim.bo[args.buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
            end,
         })
      end,
   },
}
