-- ZENVIM - MINIMAL - SETUP
-- Started on: 31 July, 2025
-- Requires Neovim v0.11.3 and above
-- Assistance by Claude Sonnet v4 and Grok 3
-- See: https://claude.ai/chat/077e450c-ab8a-4aeb-983b-a91f91b2ef72
--      https://grok.com/chat/cefa8717-0aee-4328-bcb6-7d1e1262d897
--

-- Highlight when yanking text
vim.api.nvim_create_autocmd("TextYankPost", {
   desc = "Highlight when yanking (copying) text",
   group = vim.api.nvim_create_augroup("kickstart-highlight-yank", { clear = true }),
   callback = function() vim.highlight.on_yank() end,
})

-- Set filetype for .slim files
vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
   pattern = "*.slim",
   desc = "Set filetype for Slim template files",
   group = vim.api.nvim_create_augroup("slim-filetype", { clear = true }),
   callback = function()
      vim.bo.filetype = "slim"
   end,
})

-- ---@type table<number, {token:lsp.ProgressToken, msg:string, done:boolean}[]>
-- local progress = vim.defaulttable()
-- vim.api.nvim_create_autocmd("LspProgress", {
--    ---@param ev {data: {client_id: integer, params: lsp.ProgressParams}}
--    callback = function(ev)
--       local client = vim.lsp.get_client_by_id(ev.data.client_id)
--       local value = ev.data.params.value --[[@as {percentage?: number, title?: string, message?: string, kind: "begin" | "report" | "end"}]]
--       if not client or type(value) ~= "table" then
--          return
--       end
--       local p = progress[client.id]

--       for i = 1, #p + 1 do
--          if i == #p + 1 or p[i].token == ev.data.params.token then
--             p[i] = {
--                token = ev.data.params.token,
--                msg = ("[%3d%%] %s%s"):format(
--                   value.kind == "end" and 100 or value.percentage or 100,
--                   value.title or "",
--                   value.message and (" **%s**"):format(value.message) or ""
--                ),
--                done = value.kind == "end",
--             }
--             break
--          end
--       end

--       local msg = {} ---@type string[]
--       progress[client.id] = vim.tbl_filter(function(v)
--          return table.insert(msg, v.msg) or not v.done
--       end, p)

--       local spinner = { "⠋", "⠙", "⠹", "⠸", "⠼", "⠴", "⠦", "⠧", "⠇", "⠏" }
--       vim.notify(table.concat(msg, "\n"), "info", {
--          id = "lsp_progress",
--          title = client.name,
--          opts = function(notif)
--             notif.icon = #progress[client.id] == 0 and " "
--                or spinner[math.floor(vim.uv.hrtime() / (1e6 * 80)) % #spinner + 1]
--          end,
--       })
--    end,
-- })

-- cSpell:words augroup defaulttable notif
