-- ZENVIM - MINIMAL - SETUP
-- Started on: 31 July, 2025
-- Requires Neovim v0.11.3 and above
-- Assistance by Claude Sonnet v4 and Grok 3
-- See: https://claude.ai/chat/077e450c-ab8a-4aeb-983b-a91f91b2ef72
--      https://grok.com/chat/cefa8717-0aee-4328-bcb6-7d1e1262d897
--

-- load Zen colors and styles
local Zen = require("zenvim.config.zen")

return {
   -- A blazing fast and easy to configure neovim statusline plugin written.
   -- DOCS: https://github.com/nvim-lualine/lualine.nvim
   {
      "nvim-lualine/lualine.nvim",
      dependencies = {
         {
            -- DOCS: https://github.com/folke/noice.nvim
            "folke/noice.nvim",
         },
         {
            -- DOCS: https://github.com/folke/trouble.nvim
            "folke/trouble.nvim",
         },
         {
            -- DOCS: https://github.com/nvim-tree/nvim-web-devicons
            "nvim-tree/nvim-web-devicons",
         },
      },
      config = function()
         local fn = {}

         local __center__ = "%="

         function fn.should_ignore_filetype()
            local ft = vim.bo.filetype
            return ft == "noice"
         end

         -- Tabline sections
         local TablineItems = {
            -- Tabline A
            project = function()
               return {
                  function()
                     local cwd = vim.fn.getcwd()
                     return "󰋜 " .. cwd:gsub(vim.env.HOME, "~") -- replace /home/user with ~
                  end,
                  padding = { left = 2, right = 3 },
                  color = function()
                     return {
                        fg = "#566886",
                        -- fg = Zen.palette.bar_text,
                        bg = Zen.palette.bar_bg,
                        -- gui = "bold",
                     }
                  end,
               }
            end,
            -- Tabline C
            symbol = function()
               return {
                  "TODO: symbols",
               }
               -- local trouble = require("trouble")

               -- local symbols = trouble.statusline({
               --    mode = "lsp_document_symbols",
               --    groups = {},
               --    title = false,
               --    filter = { range = true },
               --    format = "{kind_icon:StatusBarSegmentFaded}{symbol.name:StatusBarSegmentFaded} ",
               --    hl_group = "StatusBarSegmentFaded",
               -- })

               -- return {
               --    symbols and symbols.get,
               --    cond = function()
               --       return vim.b.trouble_lualine ~= false and symbols.has()
               --    end,
               -- }
            end,
         }

         -- Lualine sections
         local Sections = {
            -- Section A
            mode = function()
               return {
                  "mode",
                  padding = { left = 1, right = 1 },
               }
            end,
            -- Section B
            branch = function()
               return {
                  "branch",
                  padding = { left = 1, right = 2 },
                  color = function()
                     return {
                        fg = Zen.palette.bar_faded_text,
                        -- bg = Zen.palette.bar_bg
                     }
                  end,
               }
            end,
            -- Section B
            diff = function()
               return {
                  "diff",
                  padding = { left = 1, right = 2 },
                  colored = true, -- Displays a colored diff status if set to true
                  -- symbols = {
                  --   added = " ",
                  --   modified = " ",
                  --   removed = " ",
                  -- },
                  color = function()
                     return {
                        -- fg = Zen.palette.bar_faded_text,
                        -- bg = Zen.palette.bar_bg
                        bg = "",
                     }
                  end,
               }
            end,
            -- Section B
            filename = function()
               return {
                  "filename",
                  path = 1,
                  padding = { left = 1, right = 2 },
                  color = function() return { fg = Zen.palette.bar_faded_text, bg = "" } end,
               }
            end,
            -- Section C
            diagnostics = function()
               return {
                  __center__,
                  "diagnostics",
               }
            end,

            -- Sections X
            lazy_status = function()
               local status = require("lazy.status")

               return {
                  status.updates,
                  cond = status.has_updates,
                  color = function() return { fg = Zen.palette.bar_faded_text } end,
               }
            end,

            filetype = function()
               return {
                  "filetype",
                  padding = { left = 1, right = 1 },
                  colored = false,
                  color = function()
                     return {
                        fg = Zen.palette.bar_faded_text,
                        -- bg = Zen.palette.bar_bg
                     }
                  end,
               }
            end,

            location = function()
               return {
                  "location",
                  padding = { left = 1, right = 0 },
               }
            end,
         }

         require("lualine").setup({
            options = {
               theme = "catppuccin",
               -- component_separators = { left = '', right = '' },
               component_separators = { left = "", right = "" },
               -- section_separators = { left = " ", right = " " },
               section_separators = { left = "", right = "" },
               --
               always_divide_middle = true,
               always_show_tabline = true,
               globalstatus = false,
            },
            sections = {
               lualine_a = { Sections.mode() },
               lualine_b = {
                  Sections.branch(),
                  Sections.diff(),
                  Sections.filename(),
               },
               lualine_c = { Sections.diagnostics() },
               lualine_x = {
                  Sections.lazy_status(),
                  Sections.filetype(),
                  -- 'encoding',
                  -- 'fileformat',
               },
               lualine_y = { "progress" },
               lualine_z = { "location" },
            },
            tabline = {
               lualine_a = {
                  "buffers",
               },
               lualine_b = {},
               lualine_c = {
                  __center__,
                  TablineItems.symbol(),
               },
               lualine_x = {},
               lualine_y = {},
               lualine_z = {
                  TablineItems.project(),
               },
            },
         })
      end,
   },
}

-- cSpell:words devicons noice globalstatus fileformat
