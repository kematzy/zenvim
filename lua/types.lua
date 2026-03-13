---@alias LazySpec table

-- ============================================================================
-- ZENVIM Type Definitions
-- Type annotations for better LSP support and documentation
-- ============================================================================

-- ----------------------------------------------------------------------------
-- Lazy.nvim Plugin Specification Types
-- ----------------------------------------------------------------------------

---@class LazyPluginSpec
---@field [1] string Plugin name (e.g., "folke/snacks.nvim")
---@field name? string Alternative way to specify plugin name
---@field dir? string Local directory path for the plugin
---@field url? string Full git URL
---@field dev? boolean Use local dev version
---@field lazy? boolean Whether to lazy load
---@field priority? number Plugin loading priority
---@field dependencies? string[] | LazyPluginSpec[] Dependencies
---@field init? fun() Initialize before loading
---@field config? fun(opts: table, opts: table) | boolean Config function
---@field opts? table | fun(): table Plugin options
---@field event? string | string[] | LazyEventSpec Event to trigger loading
---@field cmd? string | string[] Command to trigger loading
---@field ft? string | string[] Filetype to trigger loading
---@field keys? string | string[] | LazyKeySpec[] Keymaps to trigger loading
---@field cond? boolean | fun(): boolean Condition to load
---@field build? string | fun() Build command/script
---@field branch? string Git branch to use
---@field tag? string Git tag to use
---@field commit? string Git commit to use
---@field version? string | boolean Version constraint
---@field pin? boolean Pin to current version
---@field submodules? boolean Whether to clone submodules

---@class LazyEventSpec
---@field event string|string[]
---@field pattern? string|string[]

---@class LazyKeySpec
---@field [1] string LHS (key combination)
---@field [2] string|function RHS (command or function)
---@field desc? string Description
---@field mode? string|string[] Mode(s)
---@field noremap? boolean
---@field silent? boolean
---@field nowait? boolean
---@field expr? boolean
---@field unique? boolean

-- ----------------------------------------------------------------------------
-- Snacks.nvim Types
-- ----------------------------------------------------------------------------

---@class SnacksConfig
---@field bigfile? SnacksBigfileConfig
---@field dashboard? SnacksDashboardConfig
---@field explorer? SnacksExplorerConfig
---@field indent? SnacksIndentConfig
---@field input? SnacksInputConfig
---@field notifier? SnacksNotifierConfig
---@field picker? SnacksPickerConfig
---@field quickfile? SnacksQuickfileConfig
---@field scope? SnacksScopeConfig
---@field scratch? SnacksScratchConfig
---@field scroll? SnacksScrollConfig
---@field statuscolumn? SnacksStatusColumnConfig
---@field terminal? SnacksTerminalConfig
---@field toggle? SnacksToggleConfig
---@field words? SnacksWordsConfig
---@field zen? SnacksZenConfig

---@class SnacksPickerConfig
---@field enabled? boolean
---@field sources? table<string, SnacksPickerSource>
---@field layout? SnacksPickerLayout
---@field win? SnacksPickerWin

---@class SnacksPickerSource
---@field name string
---@field cmd? string
---@field format? string
---@field preview? string|function

---@class SnacksPickerLayout
---@field preset? string
---@field layout? table

---@class SnacksPickerWin
---@field input? table
---@field list? table
---@field preview? table

---@class SnacksDashboardConfig
---@field enabled? boolean
---@field sections? SnacksDashboardSection[]
---@field formats? table<string, function>

---@class SnacksDashboardSection
---@field section? string
---@field pane? integer
---@field enabled? boolean
---@field padding? integer|integer[]
---@field gap? integer
---@field [string] any Additional section-specific options

---@class SnacksBigfileConfig
---@field enabled? boolean
---@field notify? boolean
---@field size? number Size in bytes
---@field line_length? number

---@class SnacksIndentConfig
---@field enabled? boolean
---@field indent? table
---@field animate? table
---@field scope? table
---@field chunk? table

---@class SnacksNotifierConfig
---@field enabled? boolean
---@field timeout? integer
---@field width? table
---@field icons? table

---@class SnacksZenConfig
---@field enabled? boolean
---@field toggles? table
---@field show? table
---@field win? table

-- ----------------------------------------------------------------------------
-- LSP Configuration Types
-- ----------------------------------------------------------------------------

---@class LspServerConfig
---@field cmd? string[] Override command
---@field filetypes? string[] Override filetypes
---@field capabilities? table Override capabilities
---@field settings? table Server-specific settings
---@field on_attach? fun(client: table, bufnr: integer) Callback on attach
---@field root_dir? string|fun(filename: string, bufnr: integer): string
---@field single_file_support? boolean
---@field init_options? table
---@field handlers? table<string, function>

---@class LspDiagnosticsConfig
---@field virtual_text? boolean|table
---@field signs? boolean|table
---@field underline? boolean
---@field update_in_insert? boolean
---@field severity_sort? boolean
---@field float? table

---@class LspCapabilities
---@field textDocumentSync? table
---@field completionProvider? table
---@field hoverProvider? boolean
---@field signatureHelpProvider? table
---@field definitionProvider? boolean
---@field referencesProvider? boolean
---@field documentHighlightProvider? boolean
---@field documentSymbolProvider? boolean
---@field codeActionProvider? boolean
---@field codeLensProvider? table
---@field formattingProvider? boolean
---@field renameProvider? boolean
---@field inlayHintProvider? boolean

-- ----------------------------------------------------------------------------
-- Keymap Types
-- ----------------------------------------------------------------------------

---@class KeymapSpec
---@field mode? string|string[] Vim mode(s)
---@field lhs string Left-hand side (key combination)
---@field rhs string|function Right-hand side (command or function)
---@field desc? string Description for which-key
---@field buffer? integer Buffer-local keymap
---@field noremap? boolean (default: true)
---@field silent? boolean (default: true)
---@field nowait? boolean
---@field expr? boolean
---@field unique? boolean

---@class KeymapGroup
---@field prefix string Group prefix (e.g., "<leader>f")
---@field name string Group name (e.g., "file/find")
---@field icon? string Icon for which-key

---@class KeymapConfig
---@field global? KeymapSpec[] Global keymaps
---@field lsp? KeymapSpec[] LSP-specific keymaps
---@field snacks? KeymapSpec[] Snacks-specific keymaps
---@field which_key_groups? KeymapGroup[] Which-key group definitions

-- ----------------------------------------------------------------------------
-- Health Check Types
-- ----------------------------------------------------------------------------

---@class HealthCheckResult
---@field status "ok" | "warn" | "error"
---@field message string

---@class HealthCheck
---@field name string Check name
---@field check fun(): HealthCheckResult Check function
---@field required? boolean Whether this check is required

---@class HealthConfig
---@field checks? HealthCheck[]
---@field auto_run? boolean Auto-run on startup
---@field notify_level? "error" | "warn" | "info" | "debug"

-- ----------------------------------------------------------------------------
-- Mason Types
-- ----------------------------------------------------------------------------

---@class MasonPackage
---@field name string
---@field category string
---@field languages string[]
---@field homepage? string
---@field description? string

---@class MasonConfig
---@field ensure_installed? string[]|MasonPackage[]
---@field automatic_installation? boolean
---@field ui? table

-- ----------------------------------------------------------------------------
-- Completion Types
-- ----------------------------------------------------------------------------

---@class BlinkConfig
---@field keymap? table
---@field completion? table
---@field sources? table
---@field signature? table

---@class BlinkSource
---@field name string
---@field module string
---@field score_offset? integer
---@field opts? table

-- ----------------------------------------------------------------------------
-- Treesitter Types
-- ----------------------------------------------------------------------------

---@class TreesitterConfig
---@field ensure_installed? string[]
---@field sync_install? boolean
---@field ignore_install? string[]
---@field auto_install? boolean
---@field highlight? table
---@field indent? table
---@field incremental_selection? table

-- ----------------------------------------------------------------------------
-- ZENVIM Global Types
-- ----------------------------------------------------------------------------

---@class ZenvimConfig
---@field startup_time? number Startup time in milliseconds
---@field have_nerd_font? boolean Whether Nerd Font is available
---@field mapleader? string Leader key
---@field maplocalleader? string Local leader key

-- Global variable definitions
---@type number
_G.ZENVIM_STARTUP_TIME = _G.ZENVIM_STARTUP_TIME or 0

---@type ZenvimConfig
vim.g.zenvim = vim.g.zenvim or {}

-- ----------------------------------------------------------------------------
-- Yazi Types (existing)
-- ----------------------------------------------------------------------------

---@class (exact) YaziConfig
---@field public open_for_directories? boolean
---@field public chosen_file_path? string "the path to a temporary file that will be created by yazi to store the chosen file path"
---@field public cwd_file_path? string "the path to a temporary file that will be created by yazi to store the last directory that yazi was in before it was closed"
---@field public open_multiple_tabs? boolean "open multiple open files in yazi tabs when opening yazi"
---@field public enable_mouse_support? boolean
---@field public change_neovim_cwd_on_close? boolean "when yazi is closed with no file chosen, change the Neovim working directory to the directory that yazi was in before it was closed. Defaults to being off (`false`)"
---@field public open_file_function? fun(chosen_file: string, config: YaziConfig, state: YaziClosedState): nil "a function that will be called when a file is chosen in yazi"
---@field public keymaps? YaziKeymaps | false # The keymaps that are available when yazi is open and focused. Set to `false` to disable all default keymaps.
---@field public set_keymappings_function? fun(buffer: integer, config: YaziConfig, context: YaziActiveContext): nil # Can be used to create new, custom keybindings. In most cases it's recommended to use `keymaps` to customize the keybindings that come with yazi.nvim
---@field public hooks? YaziConfigHooks
---@field public highlight_groups? YaziConfigHighlightGroups
---@field public integrations? YaziConfigIntegrations
---@field public floating_window_scaling_factor? number | YaziFloatingWindowScaling "the scaling factor for the floating window. 1 means 100%, 0.9 means 90%, etc."
---@field public yazi_floating_window_winblend? number "the transparency of the yazi floating window (0-100). See :h winblend"
---@field public yazi_floating_window_border? any "the type of border to use. See nvim_open_win() for the values your neovim version supports"
---@field public yazi_floating_window_zindex? number "the zindex of the yazi floating window. Can be used to make the yazi window fullscreen. See `:h nvim_open_win()` for more information."
---@field public log_level? yazi.LogLevel
---@field public clipboard_register? string the register to use for copying. Defaults to "*", the system clipboard
---@field public highlight_hovered_buffers_in_same_directory? boolean "highlight buffers in the same directory as the hovered buffer"
---@field public forwarded_dds_events? string[] "Yazi events to listen to. These are published as neovim autocmds so that the user can set up custom handlers for themselves. Defaults to `nil`."
---@field public future_features? yazi.OptInFeatures # Features that are not yet stable, but can be tested by the user. These features might change or be removed in the future. They may also become built-in features that are on by default, making it unnecessary to opt into using them.
---@field public config_home? string # optional path for nvim yazi to find a custom yazi.toml

---@class (exact) YaziActiveContext # context state for a single yazi session
---@field api YaziProcessApi
---@field ya_process YaProcess the ya process that is currently running, listening for events from yazi
---@field input_path Path the path that is first selected by yazi when it's opened
---@field cycled_file? RenameableBuffer the last file that was cycled to with e.g. the <tab> key

---@class (exact) YaziConfigHooks
---@field public yazi_opened fun(preselected_path: string | nil, buffer: integer, config: YaziConfig):nil
---@field public on_yazi_ready fun(buffer: integer, config: YaziConfig, process_api: YaziProcessApi):nil
---@field public yazi_closed_successfully fun(chosen_file: string | nil, config: YaziConfig, state: YaziClosedState): nil
---@field public yazi_opened_multiple_files fun(chosen_files: string[], config: YaziConfig, state: YaziClosedState): nil

---@class (exact) YaziClosedState # describes the state of yazi when it was closed; the last known state
---@field public last_directory Path # the last directory that yazi was in before it was closed

---@alias YaziKeymap string | false # `string` is a keybinding such as "<c-tab>", false means the keybinding is disabled

---@class YaziKeymaps # The keybindings that are set by yazi, and can be overridden by the user. Will be set to a default value if not given explicitly
---@field show_help? YaziKeymap # Show a help menu with all the keybindings
---@field open_file_in_vertical_split? YaziKeymap # When a file is hovered, open it in a vertical split
---@field open_file_in_horizontal_split? YaziKeymap # When a file is hovered, open it in a horizontal split
---@field open_file_in_tab? YaziKeymap # When a file is hovered, open it in a new tab
---@field grep_in_directory? YaziKeymap # Close yazi and open a grep narrowed to the directory yazi is in
---@field replace_in_directory? YaziKeymap # Close yazi and open a replacer (default: grug-far.nvim) narrowed to the directory yazi is in
---@field cycle_open_buffers? YaziKeymap # When Neovim has multiple splits open and visible, make yazi jump to the directory of the next one
---@field copy_relative_path_to_selected_files? YaziKeymap # Copy the relative paths of the selected files to the clipboard
---@field send_to_quickfix_list? YaziKeymap # Send the selected files to the quickfix list for later processing
---@field change_working_directory? YaziKeymap # Change working directory to the directory opened by yazi
---@field open_and_pick_window? YaziKeymap # Pick a window to open the file in
