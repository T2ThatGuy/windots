local wezterm = require("wezterm")
local config = {}

-- Windows Option
if wezterm.target_triple == "x86_64-pc-windows-msvc" then
    config.default_prog = { "C:\\Windows\\System32\\WindowsPowerShell\\v1.0\\powershell.exe", "-NoLogo"}
end

config.color_scheme = "Catppuccin Frappe"
config.font_size = 14
config.font = wezterm.font("JetBrainsMono Nerd Font", { weight = "Regular", stretch = "Normal", style = "Normal" })
config.window_background_opacity = 0.95
-- config.hide_tab_bar_if_only_one_tab = true
config.tab_bar_at_bottom = true
config.window_decorations = "RESIZE"
config.use_fancy_tab_bar = false

-- Keybinds
config.disable_default_key_bindings = true

config.leader = { key = "Space", mods = "SHIFT", timeout_milliseconds = 800 }
config.keys = {
    -- Tabs
    { key="t", mods="LEADER", action=wezterm.action.ActivateKeyTable({ name = "tab_control" }) },

    -- Panes
    { key="r", mods="LEADER", action=wezterm.action.ActivateKeyTable({ name = "resize_pane", one_shot = false }) },

    { key="w", mods="LEADER", action=wezterm.action.CloseCurrentPane({ confirm = true }) },
    { key="h", mods="LEADER", action=wezterm.action.SplitHorizontal({ domain = "CurrentPaneDomain" }) },
    { key="v", mods="LEADER", action=wezterm.action.SplitVertical({ domain = "CurrentPaneDomain" }) },
}

config.key_tables = {
    tab_control = {
        { key = "n", action = wezterm.action.SpawnTab("DefaultDomain") },
        { key = "q", action = wezterm.action.CloseCurrentTab({ confirm = true }) },
        { key = "h", action = wezterm.action.ActivateTabRelative(-1) },
        { key = "l", action = wezterm.action.ActivateTabRelative(1) },
    },

    resize_pane = {
        { key = "h", action = wezterm.action.AdjustPaneSize({ "Left", 5 }) },
        { key = "j", action = wezterm.action.AdjustPaneSize({ "Down", 5 }) },
        { key = "k", action = wezterm.action.AdjustPaneSize({ "Up", 5 }) },
        { key = "l", action = wezterm.action.AdjustPaneSize({ "Right", 5 }) },
        { key = "Escape", action = "PopKeyTable" },
    }
}

for i = 1, 9 do
    table.insert(
        config.key_tables.tab_control,
        { key = tostring(i), action = wezterm.action.ActivateTab(i - 1) }
    )
end

wezterm.on("update-right-status", function(window, pane)
  local leader = "LEADER INACTIVE"
  if window:leader_is_active() then
    leader = "LEADER ACTIVE"
  end
  window:set_right_status(leader)
end)

return config

