pcall(require, "luarocks.loader")
require("awful.autofocus")
require("awful.hotkeys_popup.keys")
local gears = require("gears")
local awful = require("awful")
local wibox = require("wibox")
local beautiful = require("beautiful")
local naughty = require("naughty")
local menubar = require("menubar")
local hotkeys_popup = require("awful.hotkeys_popup")

if awesome.startup_errors then
    naughty.notify({
        preset = naughty.config.presets.critical,
        title = "Oops, there were errors during startup!",
        text = awesome.startup_errors
    })
end
do
    local in_error = false
    awesome.connect_signal("debug::error", function(err)
        -- Make sure we don't go into an endless error loop
        if in_error then
            return
        end
        in_error = true

        naughty.notify({
            preset = naughty.config.presets.critical,
            title = "Oops, an error happened!",
            text = tostring(err)
        })
        in_error = false
    end)
end

beautiful.init("/home/marcus/.config/awesome/theme/theme.lua")

terminal = "wezterm"
editor = os.getenv("EDITOR") or "vi"
editor_cmd = terminal .. " -e " .. editor
modkey = "Mod4"
awful.layout.layouts = { awful.layout.suit.tile.top, awful.layout.suit.max }

menubar.utils.terminal = terminal
mykeyboardlayout = awful.widget.keyboardlayout()

globalkeys = gears.table.join(
    awful.key({ modkey }, "Left",
        function()
            awful.client.focus.byidx(-1)
        end,
        {
            description = "focus next client by index",
            group = "client"
        }
    ),

    awful.key({ modkey }, "Right",
        function()
            awful.client.focus.byidx(1)
        end,
        {
            description = "focus previous client by index",
            group = "client"
        }
    ),

    awful.key({ modkey, "Shift" }, "Left",
        function()
            awful.client.swap.byidx(-1)
        end,
        {
            description = "swap with next client by index",
            group = "client"
        }
    ),

    awful.key({ modkey, "Shift" }, "Right",
        function()
            awful.client.swap.byidx(1)
        end, {
            description = "swap with previous client by index",
            group = "client"
        }
    ),

    awful.key({ modkey }, "Tab",
        function()
            awful.screen.focus_relative(1)
        end,
        {
            description = "focus the next screen",
            group = "screen"
        }
    ),

    awful.key({ modkey }, "Up",
        function()
            local c = awful.client.restore()
            if c then
                c:emit_signal("request::activate", "key.unminimize", {
                    raise = true
                })
            end
        end,
        {
            description = "restore minimized",
            group = "client"
        }
    ),

    -- Standard program
    awful.key({ modkey }, "Return",
        function()
            awful.spawn(terminal)
        end,
        {
            description = "open a terminal",
            group = "launcher"
        }
    ),

    awful.key({ modkey, "Shift" }, "r",
        awesome.restart,
        {
            description = "reload awesome",
            group = "awesome"
        }
    ),

    awful.key({ modkey, "Shift" }, "e",
        awesome.quit,
        {
            description = "quit awesome",
            group = "awesome"
        }
    ),

    awful.key({ modkey }, "e",
        function()
            awful.layout.inc(1)
        end,
        {
            description = "select next layout",
            group = "layout"
        }
    ),

    -- Prompt
    awful.key({ modkey }, "r",
        function()
            awful.screen.focused().mypromptbox:run()
        end,
        {
            description = "run prompt",
            group = "launcher"
        }
    ),

    awful.key({ modkey }, "d",
        function()
            menubar.show()
        end,
        {
            description = "show the menubar",
            group = "launcher"
        }
    ),

    awful.key({}, "Print",
        function()
            awful.spawn("flameshot gui")
        end,
        {
            description = "take screenshots",
            group = "layout"
        }
    ),

    awful.key({}, "XF86AudioRaiseVolume",
        function()
            awful.spawn.easy_async_with_shell(
                "pactl get-sink-volume @DEFAULT_SINK@ | grep -Po '[0-9]{1,3}(?=%)' | head -1",
                function(stdout)
                    if tonumber(stdout) < 100 then
                        awful.spawn("pactl set-sink-volume @DEFAULT_SINK@ +10%")
                    end

                    naughty.notify({
                        preset = naughty.config.presets.normal,
                        title = "Vol Icon",
                        text = stdout
                    })
                end)
        end,
        {
            description = "Volume Up",
            group = "layout"
        }
    ),

    awful.key({}, "XF86AudioLowerVolume",
        function()
            awful.spawn("pactl set-sink-volume @DEFAULT_SINK@ -10%")
            awful.spawn.easy_async_with_shell(
                "pactl get-sink-volume @DEFAULT_SINK@ | grep -Po '[0-9]{1,3}(?=%)' | head -1",
                function(stdout)
                    naughty.notify({
                        preset = naughty.config.presets.normal,
                        title = "Vol Icon",
                        text = stdout
                    })
                end)
        end,
        {
            description = "Volume Down",
            group = "layout"
        }
    )
)

clientkeys = gears.table.join(
    awful.key({ modkey }, "x",
        function(c)
            c:move_to_screen()
        end,
        {
            description = "move client to other screen",
            group = "client"
        }
    ),

    awful.key({ modkey, "Shift" }, "q",
        function(c)
            c:kill()
        end,
        {
            description = "close",
            group = "client"
        }
    ),

    awful.key({ modkey, "Shift" }, "space",
        awful.client.floating.toggle,
        {
            description = "toggle floating",
            group = "client"
        }
    ),

    awful.key({ modkey }, "Down",
        function(c)
            c.minimized = true
        end,
        {
            description = "minimize",
            group = "client"
        }
    ),

    awful.key({ modkey }, "f",
        function(c)
            c.maximized = not c.maximized
            c:raise()
        end,
        {
            description = "(un)maximize",
            group = "client"
        }
    )
)

for i = 1, 9 do
    globalkeys = gears.table.join(
        globalkeys, awful.key({ modkey }, "#" .. i + 9,
            function()
                local screen = awful.screen.focused()
                local tag = screen.tags[i]
                if tag then
                    tag:view_only()
                end
            end,
            {
                description = "view tag #" .. i,
                group = "tag"
            }
        ),

        awful.key({ modkey, "Control" }, "#" .. i + 9,
            function()
                local screen = awful.screen.focused()
                local tag = screen.tags[i]
                if tag then
                    awful.tag.viewtoggle(tag)
                end
            end,
            {
                description = "toggle tag #" .. i,
                group = "tag"
            }
        ),

        awful.key({ modkey, "Shift" }, "#" .. i + 9,
            function()
                if client.focus then
                    local tag = client.focus.screen.tags[i]
                    if tag then
                        client.focus:move_to_tag(tag)
                    end
                end
            end,
            {
                description = "move focused client to tag #" .. i,
                group = "tag"
            }
        ),

        awful.key({ modkey, "Control", "Shift" }, "#" .. i + 9,
            function()
                if client.focus then
                    local tag = client.focus.screen.tags[i]
                    if tag then
                        client.focus:toggle_tag(tag)
                    end
                end
            end,
            {
                description = "toggle focused client on tag #" .. i,
                group = "tag"
            }
        )
    )
end

clientbuttons = gears.table.join(
    awful.button({}, 1,
        function(c)
            c:emit_signal("request::activate", "mouse_click", { raise = true })
        end
    ),

    awful.button({ modkey }, 1,
        function(c)
            c:emit_signal("request::activate", "mouse_click", { raise = true })
            awful.mouse.client.move(c)
        end
    ),

    awful.button({ modkey }, 3,
        function(c)
            c:emit_signal("request::activate", "mouse_click", { raise = true })
            awful.mouse.client.resize(c)
        end
    )
)

root.keys(globalkeys)

awful.rules.rules = { -- All clients will match this rule.
    {
        rule = {},
        properties = {
            border_width = beautiful.border_width,
            border_color = beautiful.border_normal,
            focus = awful.client.focus.filter,
            raise = true,
            keys = clientkeys,
            buttons = clientbuttons,
            screen = awful.screen.preferred,
            placement = awful.placement.no_overlap + awful.placement.no_offscreen
        }
    }, -- Floating clients.
    {
        rule_any = {
            instance = { "DTA", -- Firefox addon DownThemAll.
                "copyq",        -- Includes session name in class.
                "pinentry" },
            class = { "Arandr", "Blueman-manager" },

            -- Note that the name property shown in xprop might be set slightly after creation of the client
            -- and the name shown there might not match defined rules here.
            name = { "Event Tester" -- xev.
            },
            role = { "AlarmWindow", -- Thunderbird's calendar.
                "ConfigManager",    -- Thunderbird's about:config.
                "pop-up"            -- e.g. Google Chrome's (detached) Developer Tools.
            }
        },
        properties = {
            floating = true
        }
    }, -- Add titlebars to normal clients and dialogs
    {
        rule_any = {
            type = { "normal", "dialog" }
        },
        properties = {
            titlebars_enabled = true
        }
    } -- Set Firefox to always map on the tag named "2" on screen 1.
    -- { rule = { class = "Firefox" },
    --   properties = { screen = 1, tag = "2" } },
}

-- Adjust new clients
client.connect_signal("manage", function(c)
    awful.tag.incnmaster(1, nil, true)

    if awesome.startup and not c.size_hints.user_position and not c.size_hints.program_position then
        awful.placement.no_offscreen(c)
        -- Distribute clients evenly vertically
        awful.client.setslave(c)
    end
end)

-- Focus follow mouse
client.connect_signal("mouse::enter", function(c)
    c:emit_signal("request::activate", "mouse_enter", {
        raise = false
    })
end)

client.connect_signal("focus", function(c)
    c.border_color = beautiful.border_focus
end)

client.connect_signal("unfocus", function(c)
    c.border_color = beautiful.border_normal
end)

-- Rounded corners
client.connect_signal("manage", function(c)
    c.shape = function(cr, w, h)
        gears.shape.rounded_rect(cr, w, h, 10)
    end
end)

local function set_wallpaper(s)
    if beautiful.wallpaper then
        local wallpaper = beautiful.wallpaper
        if type(wallpaper) == "function" then
            wallpaper = wallpaper(s)
        end
        gears.wallpaper.maximized(wallpaper, s, true)
    end
end
screen.connect_signal("property::geometry", set_wallpaper)

-- Top Bar
mytextclock = wibox.widget.textclock()
local tasklist_buttons = gears.table.join(awful.button({}, 1, function(c)
    if c == client.focus then
        c.minimized = true
    else
        c:emit_signal("request::activate", "tasklist", {
            raise = true
        })
    end
end))

local taglist_buttons = gears.table.join(awful.button({}, 1, function(t)
    t:view_only()
end))

awful.screen.connect_for_each_screen(function(s)
    set_wallpaper(s)

    awful.tag({ "1", "2", "3", "4", "5" }, s, awful.layout.layouts[2])

    s.mypromptbox = awful.widget.prompt()
    s.mytaglist = awful.widget.taglist {
        screen = s,
        filter = awful.widget.taglist.filter.all,
        buttons = taglist_buttons
    }
    s.mytasklist = awful.widget.tasklist {
        screen = s,
        filter = awful.widget.tasklist.filter.currenttags,
        buttons = tasklist_buttons,
        layout = {
            spacing = 5,
            max_widget_size = awful.screen.focused().workarea.width * 0.12,
            layout = wibox.layout.flex.horizontal
        }
    }

    s.mywibox = awful.wibar({
        position = "top",
        screen = s
    })
    s.mywibox:setup {
        layout = wibox.layout.align.horizontal,
        { -- Left widgets
            layout = wibox.layout.fixed.horizontal,
            s.mytaglist,
            s.mypromptbox
        },
        {
            layout = wibox.layout.fixed.horizontal,
            s.mytasklist
        }, -- Middle widget
        {  -- Right widgets
            layout = wibox.layout.fixed.horizontal,
            wibox.widget.systray(),
            mytextclock
        }
    }
end)

awful.spawn.with_shell("/home/marcus/.screenlayout/ext_home.sh")
awful.spawn.easy_async_with_shell("pasystray")
awful.spawn.easy_async_with_shell("nm-applet")
