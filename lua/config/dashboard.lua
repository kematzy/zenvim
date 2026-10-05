-- Zenvim - Minimal Neovim configuration
-- Last updated: 01 October, 2026
-- Sidebar data provider for the Snacks dashboard.
--

-- Sidebar data for the Snacks dashboard.
-- ZENVIM stores its own file history (NVIM_APPNAME), so a new install has no
-- recent files. The main Neovim history is appended until this one fills in.
local M = {}

local supplemented = false

local function filename(value)
   if type(value) == "string" and value ~= "" and not value:find("://", 1, true) then
      return value
   end
end

local function state_dir()
   local state = vim.env.XDG_STATE_HOME
   if type(state) ~= "string" or state == "" then
      state = (vim.env.HOME or "") .. "/.local/state"
   end
   return state
end

-- Local marks (ShaDa type 10) are what Neovim turns into v:oldfiles.
local function files_from_shada(path)
   local ok, objs = pcall(vim.fn.msgpackparse, vim.fn.readfile(path, "b"))
   if not ok or type(objs) ~= "table" then return {} end

   local newest = {}
   local index = 1
   while index + 3 <= #objs do
      local kind, stamp, body = objs[index], objs[index + 1], objs[index + 3]
      if type(kind) ~= "number" then break end
      if kind == 10 and type(body) == "table" then
         local file = filename(body.f)
         local when = type(stamp) == "number" and stamp or 0
         if file and when >= (newest[file] or 0) then newest[file] = when end
      end
      index = index + 4
   end

   local ranked = {}
   for file, when in pairs(newest) do
      if vim.uv.fs_stat(file) then ranked[#ranked + 1] = { file = file, when = when } end
   end
   table.sort(ranked, function(a, b)
      if a.when ~= b.when then return a.when > b.when end
      return a.file < b.file
   end)

   local files = {}
   for _, item in ipairs(ranked) do
      files[#files + 1] = item.file
   end
   return files
end

function M.supplement_oldfiles()
   if supplemented then return end
   supplemented = true

   local own = vim.fn.stdpath("state") .. "/shada/main.shada"
   local main = state_dir() .. "/nvim/shada/main.shada"
   if own == main or vim.uv.fs_stat(main) == nil then return end

   -- Reading v:oldfiles returns a copy. Inserts have to be written back.
   local files = vim.list_extend({}, vim.v.oldfiles)
   local seen = {}
   for _, file in ipairs(files) do
      seen[file] = true
   end
   for _, file in ipairs(files_from_shada(main)) do
      if not seen[file] then
         files[#files + 1] = file
         seen[file] = true
      end
   end
   vim.v.oldfiles = files
end

vim.api.nvim_create_autocmd("VimEnter", {
   once = true,
   desc = "Fill dashboard history from the main Neovim ShaDa file",
   callback = function() M.supplement_oldfiles() end,
})

--- Git roots for the Projects section, current repo first.
---@param limit number
---@return string[]
function M.project_dirs(limit)
   local dirs = {}
   local seen = {}
   local function add(dir)
      if type(dir) ~= "string" or dir == "" or seen[dir] or #dirs >= limit then return end
      seen[dir] = true
      dirs[#dirs + 1] = dir
   end

   add(Snacks.git.get_root())
   for _, file in ipairs(vim.v.oldfiles) do
      if #dirs >= limit then break end
      if type(file) == "string" and vim.uv.fs_stat(file) then add(Snacks.git.get_root(file)) end
   end
   return dirs
end

local git_cache = { at = 0, root = nil, lines = {} }
local git_ttl = 5 * 60

local function status_path(line)
   if vim.startswith(line, "##") then return nil end
   local path = line:match("^.. (.+)$")
   if not path then return nil end
   return path:match(" -> (.+)$") or path
end

local function clip(line, width)
   if vim.api.nvim_strwidth(line) <= width then return line end
   return vim.fn.strcharpart(line, 0, width - 3) .. "..."
end

--- Git status as dashboard text. A terminal section keeps Neovim's
--- "[process exited 0]" line in the pane after git exits.
function M.git_status()
   local root = Snacks.git.get_root()
   if not root then return nil end

   local now = os.time()
   if git_cache.root ~= root or now - git_cache.at >= git_ttl then
      local result = vim.system({
         "git",
         "-C",
         root,
         "-c",
         "color.ui=never",
         "--no-pager",
         "status",
         "--short",
         "--branch",
         "--renames",
      }, { text = true }):wait(500)
      local lines = {}
      if result and result.code == 0 then
         lines = vim.split(result.stdout or "", "\n", { trimempty = true })
      else
         local err = result and (result.stderr or "") or ""
         err = vim.trim(err)
         lines = { err ~= "" and err or "git status failed" }
      end
      git_cache = { at = now, root = root, lines = lines }
   end

   local section = {
      pane = 2,
      icon = "  ",
      title = "Git Status",
      indent = 2,
      padding = 1,
   }
   local max_lines = 5
   local shown = 0
   for _, line in ipairs(git_cache.lines) do
      if shown >= max_lines then break end
      shown = shown + 1
      local item = { text = clip(line, 56), pane = 2, indent = 3 }
      local rel = status_path(line)
      if rel then
         local abs = root .. "/" .. rel
         item.action = function() vim.cmd.edit(vim.fn.fnameescape(abs)) end
      end
      section[#section + 1] = item
   end
   local extra = #git_cache.lines - shown
   if extra > 0 then
      section[#section + 1] = { text = ("... %d more"):format(extra), pane = 2, indent = 3 }
   end
   if shown == 0 then section[1] = { text = "(clean)", pane = 2, indent = 3 } end
   return section
end

return M
