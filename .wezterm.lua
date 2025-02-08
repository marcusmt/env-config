-- Pull in the wezterm API
local wezterm = require 'wezterm'
local act = wezterm.action

-- This will hold the configuration.
local config = wezterm.config_builder()

-- This is where you actually apply your config choices

config.keys = {
    {
        key = 'w',
        mods = 'ALT',
        action = wezterm.action.CloseCurrentPane { confirm = false },
    },
    {
        key = 'RightArrow',
        mods = 'ALT|SHIFT',
        action = wezterm.action.SplitPane {
            direction = 'Left',
            size = { Percent = 50 },
        },
    },
    {
        key = 'DownArrow',
        mods = 'ALT|SHIFT',
        action = wezterm.action.SplitPane {
            direction = 'Down',
            size = { Percent = 50 },
        },
    },
    {
        key = 'LeftArrow',
        mods = 'ALT',
        action = act.ActivatePaneDirection 'Left',
    },
    {
        key = 'RightArrow',
        mods = 'ALT',
        action = act.ActivatePaneDirection 'Right',
    },
    {
        key = 'UpArrow',
        mods = 'ALT',
        action = act.ActivatePaneDirection 'Up',
    },
    {
        key = 'DownArrow',
        mods = 'ALT',
        action = act.ActivatePaneDirection 'Down',
    },
    {
        key = 't',
        mods = 'ALT',
        action = act.SpawnTab 'DefaultDomain'
    },
    {
        key = 'w',
        mods = 'ALT|SHIFT',
        action = wezterm.action.CloseCurrentTab { confirm = true },
    },
    {
        key = '[',
        mods = 'ALT',
        action = act.MoveTabRelative(-1)
    },
    {
        key = ']',
        mods = 'ALT',
        action = act.MoveTabRelative(1)
    },
}

for i = 1, 8 do
    -- CTRL+ALT + number to move to that position
    table.insert(config.keys, {
        key = tostring(i),
        mods = 'ALT|SHIFT',
        action = wezterm.action.MoveTab(i - 1),
    })
end

-- For example, changing the color scheme:
config.color_scheme = 'ayu'

-- and finally, return the configuration to wezterm
return config
