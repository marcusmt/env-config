-- Pull in the wezterm API
local wezterm = require 'wezterm'
local act = wezterm.action

-- This will hold the configuration.
local config = wezterm.config_builder()

-- This is where you actually apply your config choices

config.keys = {
    {
        key = '.',
        mods = 'ALT',
        action = wezterm.action.CloseCurrentPane { confirm = false },
    },
    {
        key = 'l',
        mods = 'ALT',
        action = wezterm.action.SplitPane {
            direction = 'Left',
            size = { Percent = 50 },
        },
    },
    {
        key = 'k',
        mods = 'ALT',
        action = wezterm.action.SplitPane {
            direction = 'Down',
            size = { Percent = 50 },
        },
    },
    {
        key = 'j',
        mods = 'CTRL|SHIFT',
        action = act.ActivatePaneDirection 'Left',
    },
    {
        key = 'l',
        mods = 'CTRL|SHIFT',
        action = act.ActivatePaneDirection 'Right',
    },
    {
        key = 'i',
        mods = 'CTRL|SHIFT',
        action = act.ActivatePaneDirection 'Up',
    },
    {
        key = 'k',
        mods = 'CTRL|SHIFT',
        action = act.ActivatePaneDirection 'Down',
    },
    {
        key = 'o',
        mods = 'ALT',
        action = act.SpawnTab 'DefaultDomain'
    },
    {
        key = 'p',
        mods = 'ALT',
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

-- For example, changing the color scheme:
config.color_scheme = 'ayu'

config.font = wezterm.font 'Hack Nerd Font'

-- and finally, return the configuration to wezterm
return config
