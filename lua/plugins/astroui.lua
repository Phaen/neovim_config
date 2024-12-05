-- AstroUI provides the basis for configuring the AstroNvim User Interface
-- Configuration documentation can be found with `:h astroui`
-- NOTE: We highly recommend setting up the Lua Language Server (`:LspInstall lua_ls`)
--       as this provides autocomplete and documentation while editing

local theme

-- Switch between themes depending on dark mode
if vim.fn.has "mac" == 1 then
  theme = vim.fn.system("defaults read -g AppleInterfaceStyle 2>/dev/null"):find "Dark" and "nightfox" or "dawnfox"
elseif vim.fn.has "unix" == 1 then
  theme = vim.fn.system("gsettings get org.gnome.desktop.interface color-scheme 2>/dev/null"):find "dark" and "nightfox"
    or "dawnfox"
elseif vim.fn.has "win32" == 1 then
  theme = vim.fn
    .system("reg query HKCU\\Software\\Microsoft\\Windows\\CurrentVersion\\Themes\\Personalize /v AppsUseLightTheme 2>&1")
    :find "0x0" and "nightfox" or "dawnfox"
else
  theme = "nightfox"
end

-- An editor in lightmode, what was I thinking?
theme = "nightfox"

---@type LazySpec
return {
  "AstroNvim/astroui",
  ---@type AstroUIOpts
  opts = {
    -- change colorscheme
    colorscheme = theme,
    -- AstroUI allows you to easily modify highlight groups easily for any and all colorschemes
    highlights = {
      init = { -- this table overrides highlights in all themes
        -- Normal = { bg = "#000000" },
      },
      astrodark = { -- a table of overrides/changes when applying the astrotheme theme
        -- Normal = { bg = "#000000" },
      },
    },
    -- Icons can be configured throughout the interface
    icons = {
      -- configure the loading of the lsp in the status line
      LSPLoading1 = "⠋",
      LSPLoading2 = "⠙",
      LSPLoading3 = "⠹",
      LSPLoading4 = "⠸",
      LSPLoading5 = "⠼",
      LSPLoading6 = "⠴",
      LSPLoading7 = "⠦",
      LSPLoading8 = "⠧",
      LSPLoading9 = "⠇",
      LSPLoading10 = "⠏",
    },
  },
}
