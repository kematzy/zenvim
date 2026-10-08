-- Zenvim - Minimal Neovim configuration
-- Last updated: 08 October, 2026
-- Snacks: picker, explorer, dashboard, notifier and other QoL features.
--

-- load the keymaps configurations
local dashboard = require("config.dashboard")
local keymaps = require("config.keymap")

-- Horizontal pickers: list ~1/3, preview ~2/3.
local function preview_two_thirds(layout)
   local function apply(box)
      if type(box) ~= "table" then return end
      if box.box == "horizontal" then
         for _, child in ipairs(box) do
            if child.win == "preview" then child.width = 0.66 end
         end
      end
      for _, child in ipairs(box) do
         apply(child)
      end
   end
   apply(layout.layout)
end

return {
   -- Snacks.nvim - A collection of QoL plugins for Neovim
   -- DOCS: https://github.com/folke/snacks.nvim
   {
      "folke/snacks.nvim",
      priority = 1000,
      lazy = false,
      -- enabled = false,

      ---@type snacks.Config
      opts = {
         bigfile = { enabled = true },
         dashboard = {
            preset = {
               header = [[
   ███████╗███████╗███╗   ██╗██╗   ██╗██╗███╗   ███╗
   ╚══███╔╝██╔════╝████╗  ██║██║   ██║██║████╗ ████║
     ███╔╝ █████╗  ██╔██╗ ██║██║   ██║██║██╔████╔██║
    ███╔╝  ██╔══╝  ██║╚██╗██║╚██╗ ██╔╝██║██║╚██╔╝██║
   ███████╗███████╗██║ ╚████║ ╚████╔╝ ██║██║ ╚═╝ ██║
   ╚══════╝╚══════╝╚═╝  ╚═══╝  ╚═══╝  ╚═╝╚═╝     ╚═╝
   A customized Neovim configuration
               ]],
            },
            formats = {
               header = {
                  align = "left",
               },
            },
            sections = {
               { section = "header" },
               { section = "keys", gap = 1, padding = 1 },
               {
                  pane = 2,
                  icon = " ",
                  title = "Recent Files",
                  section = "recent_files",
                  indent = 2,
                  padding = 1,
               },
               {
                  pane = 2,
                  icon = " ",
                  title = "Projects",
                  section = "projects",
                  indent = 2,
                  padding = 1,
                  dirs = function() return dashboard.project_dirs(5) end,
               },
               dashboard.git_status,
               { section = "startup", icon = "" },
            },
         },
         explorer = {
            enabled = true,
            replace_netrw = true, -- `zenvim some/dir` opens the explorer there
         },
         indent = { enabled = true },
         input = { enabled = true },
         lazygit = { enabled = true },
         notifier = { enabled = true },
         picker = {
            enabled = true,
            win = {
               input = {
                  keys = {
                     ["<M-j>"] = "preview_scroll_down",
                     ["<M-k>"] = "preview_scroll_up",
                  },
               },
            },
            layout = {
               backdrop = false,
               height = 0.9,
               width = 0.9,
            },
            sources = {
               files = {
                  hidden = true, -- Show dotfiles
                  ignored = false, -- Hide gitignored files
                  layout = { config = preview_two_thirds },
               },
               grep = {
                  layout = { config = preview_two_thirds },
               },
               explorer = {
                  hidden = true, -- Show dotfiles
                  ignored = false, -- Hide gitignored files
                  follow_file = true, -- Focus the current file
                  layout = {
                     layout = {
                        position = "right",
                     },
                  },
                  auto_close = false, -- Keep Explorer open after selection
               },
            },
         },
         quickfile = { enabled = true },
         scroll = { enabled = true },
         statuscolumn = { enabled = true },
         words = { enabled = true },
         zen = { enabled = true },
      },

      -- add keymaps
      keys = keymaps.snacks,

      init = function()
         vim.api.nvim_create_autocmd("User", {
            pattern = "VeryLazy",
            callback = function()
               -- Setup some globals for debugging (lazy-loaded)
               _G.dd = function(...) Snacks.debug.inspect(...) end
               _G.bt = function() Snacks.debug.backtrace() end
               vim.print = _G.dd -- Override print to use snacks for `:=` command

               -- Create some toggle mappings
               Snacks.toggle.option("spell", { name = "spelling" }):map("<leader>us")
               Snacks.toggle({
                  name = "cSpell",
                  get = function() return require("config.cspell").enabled() end,
                  set = function(state) require("config.cspell").set(state) end,
               }):map("<leader>uS")
               Snacks.toggle.option("wrap", { name = "wrap" }):map("<leader>uw")
               Snacks.toggle
                  .option("relativenumber", { name = "relative number" })
                  :map("<leader>uL")
               Snacks.toggle.diagnostics():map("<leader>ud")
               Snacks.toggle.line_number():map("<leader>ul")
               Snacks.toggle
                  .option(
                     "conceallevel",
                     { off = 0, on = vim.o.conceallevel > 0 and vim.o.conceallevel or 2 }
                  )
                  :map("<leader>uc")
               Snacks.toggle.treesitter():map("<leader>uT")
               Snacks.toggle
                  .option("background", { off = "light", on = "dark", name = "dark background" })
                  :map("<leader>ub")
               Snacks.toggle.inlay_hints():map("<leader>uh")
               Snacks.toggle.indent():map("<leader>ug")
               Snacks.toggle.dim():map("<leader>uD")
            end,
         })
      end,
   },
}
