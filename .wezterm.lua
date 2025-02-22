-- Pull in the wezterm API
local wezterm = require 'wezterm'
local act = wezterm.action

-- This will hold the configuration.
local config = wezterm.config_builder()
config.default_prog = { 'fish', '-l' }

-- This is where you actually apply your config choices

config.keys = {
    {
        key = 'RightArrow',
        mods = 'CTRL|SHIFT',
        action = wezterm.action.SplitPane {
            direction = 'Right',
            size = { Percent = 50 },
        },
    },
    {
        key = 'LeftArrow',
        mods = 'CTRL|SHIFT',
        action = wezterm.action.SplitPane {
            direction = 'Left',
            size = { Percent = 50 },
        },
    },
    {
        key = 'DownArrow',
        mods = 'CTRL|SHIFT',
        action = wezterm.action.SplitPane {
            direction = 'Down',
            size = { Percent = 50 },
        },
    },
    {
        key = 'UpArrow',
        mods = 'CTRL|SHIFT',
        action = wezterm.action.SplitPane {
            direction = 'Up',
            size = { Percent = 50 },
        },
    },
    {
        key = 'LeftArrow',
        mods = 'CTRL',
        action = act.ActivatePaneDirection 'Left',
    },
    {
        key = 'RightArrow',
        mods = 'CTRL',
        action = act.ActivatePaneDirection 'Right',
    },
    {
        key = 'UpArrow',
        mods = 'CTRL',
        action = act.ActivatePaneDirection 'Up',
    },
    {
        key = 'DownArrow',
        mods = 'CTRL',
        action = act.ActivatePaneDirection 'Down',
    },
    {
        key = 'e',
        mods = 'CTRL',
        action = act.SpawnTab 'DefaultDomain'
    },
    {
        key = 'w',
        mods = 'CTRL',
        action = wezterm.action.CloseCurrentPane { confirm = false },
    },
    {
        key = 'w',
        mods = 'CTRL|SHIFT',
        action = wezterm.action.CloseCurrentTab { confirm = true },
    },
    {
        key = 'a',
        mods = 'CTRL',
        action = act.MoveTabRelative(-1)
    },
    {
        key = 'd',
        mods = 'CTRL',
        action = act.MoveTabRelative(1)
    },
}

for i = 1, 8 do
    -- CTRL+ALT + number to move to that position
    table.insert(config.keys, {
        key = tostring(i),
        mods = 'CTRL|SHIFT',
        action = wezterm.action.MoveTab(i - 1),
    })
end

-- For example, changing the color scheme:
config.color_scheme = 'ayu'
config.enable_scroll_bar = true
config.pane_focus_follows_mouse = true
config.scrollback_lines = 9999999
config.tab_bar_at_bottom = true

-- and finally, return the configuration to wezterm
return config
