-- ZENVIM - MINIMAL - SETUP
-- Started on: 31 July, 2025
-- Requires Neovim v0.11.3 and above
-- Assistance by Claude Sonnet v4 and Grok 3
-- See: https://claude.ai/chat/077e450c-ab8a-4aeb-983b-a91f91b2ef72
--      https://grok.com/chat/cefa8717-0aee-4328-bcb6-7d1e1262d897
--

-- load Zen colors and styles
local Zen = require("config.zen")

return {
   -- A blazing fast and easy to configure neovim statusline plugin written.
   -- DOCS: https://github.com/nvim-lualine/lualine.nvim
   {
      "nvim-lualine/lualine.nvim",
      dependencies = {
         -- DOCS: https://github.com/nvim-tree/nvim-web-devicons
         "nvim-tree/nvim-web-devicons",
      },
      config = function()
         local function set_status_highlights()
            vim.api.nvim_set_hl(0, "StatusBarSegmentFaded", {
               fg = Zen.palette.bar_faded_text,
               bg = Zen.palette.bar_bg,
            })
         end
         set_status_highlights()
         vim.api.nvim_create_autocmd("ColorScheme", {
            group = vim.api.nvim_create_augroup("zenvim-status-hl", { clear = true }),
            callback = set_status_highlights,
         })

         local __center__ = "%="

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
                        fg = "#888888",
                        -- fg = "#566886",
                        bg = "#323F56",
                        -- fg = Zen.palette.bar_text,
                        -- bg = Zen.palette.bar_bg,
                        -- gui = "bold",
                     }
                  end,
               }
            end,
            -- Tabline C
            symbol = function()
               local symbols
               local function ensure()
                  if symbols then return symbols end
                  local ok, trouble = pcall(require, "trouble")
                  if not ok then return nil end
                  symbols = trouble.statusline({
                     mode = "lsp_document_symbols",
                     groups = {},
                     title = false,
                     filter = { range = true },
                     format = "{kind_icon:StatusBarSegmentFaded}"
                        .. "{symbol.name:StatusBarSegmentFaded} ",
                     hl_group = "StatusBarSegmentFaded",
                  })
                  return symbols
               end

               return {
                  function()
                     local current = ensure()
                     if not current or not current.has() then return "" end
                     return current.get()
                  end,
                  cond = function()
                     if vim.b.trouble_lualine == false then return false end
                     local current = ensure()
                     return current ~= nil and current.has()
                  end,
               }
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
               theme = "catppuccin-mocha",
               -- component_separators = { left = '', right = '' },
               -- section_separators = { left = " ", right = " " },
               component_separators = { left = "", right = "" },
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
               lualine_c = {
                  __center__,
                  "diagnostics",
               },
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
                  {
                     "buffers",
                     color = function()
                        return {
                           fg = Zen.palette.bar_faded_text,
                           bg = Zen.palette.bar_bg,
                           -- bg = "",
                        }
                     end,
                     -- Shows specific buffer name for that filetype
                     -- ( { `filetype` = `buffer_name`, ... } )
                     filetype_names = {
                        dashboard = "Dashboard",
                        packer = "Packer",
                        fzf = "FZF",
                        alpha = "Alpha",
                        lazygit = "LazyGit",
                        yazi = "Yazi",
                        picker = "Snacks Picker",
                        explorer = "Explorer",
                     },

                     -- Automatically updates active buffer color to match color of other components
                     -- (will be overidden if buffers_color is set)
                     use_mode_colors = false,

                     -- buffers_color = {
                     --    -- Same values as the general color option can be used here.
                     --    active = "lualine_{section}_normal", -- Color for active buffer.
                     --    inactive = "lualine_{section}_inactive", -- Color for inactive buffer.
                     -- },

                     symbols = {
                        -- 󰜳   󰜲  󰜱  󱞢    󰆓    󰳻  󱙃      󰴓         󰁎  󱞶
                        -- shown when the buffer is modified
                        modified = " ",
                        -- identifying previous edited file
                        alternate_file = "󱞶 ",
                        -- shown when the buffer is a directory
                        directory = "",
                     },
                  },
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
