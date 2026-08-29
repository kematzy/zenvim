#!/usr/bin/env bash
# Local quality gates for ZENVIM. Run from the config root: ./scripts/check.sh
set -euo pipefail

root="$(cd "$(dirname "$0")/.." && pwd)"
cd "$root"

mason_bin="${HOME}/.local/share/zenvim/mason/bin"
if [[ -d "$mason_bin" ]]; then
   export PATH="${mason_bin}:${PATH}"
fi

fail=0

need() {
   if ! command -v "$1" >/dev/null 2>&1; then
      echo "missing tool: $1" >&2
      fail=1
      return 1
   fi
}

run() {
   local name="$1"
   shift
   echo "==> ${name}"
   if "$@"; then
      echo "ok  ${name}"
   else
      echo "FAIL ${name}" >&2
      fail=1
   fi
}

need stylua
need luacheck
need cspell
need nvim
need python3

run "stylua" stylua --check .
run "luacheck" luacheck init.lua lua
run "cspell" cspell lint --no-progress --gitignore --config cspell.json .
run "json" python3 - <<'PY'
import json, pathlib, sys
root = pathlib.Path(".")
errors = []
for path in [root / "cspell.json", root / ".luarc.json", *sorted((root / "snippets").glob("*.json"))]:
    try:
        json.loads(path.read_text())
    except Exception as exc:
        errors.append(f"{path}: {exc}")
if errors:
    print("\n".join(errors), file=sys.stderr)
    sys.exit(1)
PY

run "zenvim-load" env NVIM_APPNAME=zenvim nvim --headless -c "lua vim.schedule(function()
  local errs = {}
  local ok, lazy = pcall(require, 'lazy.core.config')
  if not ok then
    io.stderr:write('lazy.nvim failed to load: ' .. tostring(lazy) .. '\\n')
    vim.cmd('cquit 1')
    return
  end
  for name, plugin in pairs(lazy.plugins) do
    if plugin._ and plugin._.error then
      table.insert(errs, name .. ': ' .. tostring(plugin._.error))
    end
  end
  if #errs > 0 then
    io.stderr:write(table.concat(errs, '\\n') .. '\\n')
    vim.cmd('cquit 1')
  else
    vim.cmd('qa!')
  end
end)"

if [[ "$fail" -ne 0 ]]; then
   echo "checks failed" >&2
   exit 1
fi
echo "all checks passed"
