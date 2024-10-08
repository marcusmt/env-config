pcall(require, "luarocks.loader")
local gears = require("gears")
local awful = require("awful")
require("awful.autofocus")
local wibox = require("wibox")
local beautiful = require("beautiful")
local naughty = require("naughty")
local menubar = require("menubar")
menubar.utils.terminal = terminal
local hotkeys_popup = require("awful.hotkeys_popup")
require("awful.hotkeys_popup.keys")
local has_fdo, freedesktop = pcall(require, "freedesktop")

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
        if in_error then return end
        in_error = true

        naughty.notify({
            preset = naughty.config.presets.critical,
            title = "Oops, an error happened!",
            text = tostring(err)
        })
        in_error = false
    end)
end

beautiful.init("/home/marcus/.config/awesome/default/theme.lua")
terminal = "alacritty"
editor = os.getenv("EDITOR") or "editor"
editor_cmd = terminal .. " -e " .. editor
modkey = "Mod4"

awful.layout.layouts = {
    awful.layout.suit.tile.top,
    awful.layout.suit.max
}

local taglist_buttons = gears.table.join(
    awful.button({}, 1, function(t) t:view_only() end)
)

local tasklist_buttons = gears.table.join(
                     awful.button({ }, 1, function (c)
                                              if c == client.focus then
                                                  c.minimized = true
                                              else
                                                  c:emit_signal(
                                                      "request::activate",
                                                      "tasklist",
                                                      {raise = true}
                                                  )
                                              end
                                          end),
                     awful.button({ }, 3, function()
                                              awful.menu.client_list({ theme = { width = 250 } })
                                          end))

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

mytextclock = wibox.widget.textclock('%H:%M')
awful.screen.connect_for_each_screen(function(s)
    set_wallpaper(s)

    awful.tag({ "1", "2", "3", "4", "5" }, s, awful.layout.layouts[2])

    s.mypromptbox = awful.widget.prompt()
    s.mytaglist = awful.widget.taglist {
        screen  = s,
        filter  = awful.widget.taglist.filter.all,
        buttons = taglist_buttons
    }
    s.mytasklist = awful.widget.tasklist {
        screen  = s,
        filter  = awful.widget.tasklist.filter.currenttags,
        buttons = tasklist_buttons
    }

    s.mywibox = awful.wibar({ position = "top", screen = s})
    s.mywibox:setup {
        layout = wibox.layout.align.horizontal,
        {             -- Left widgets
            layout = wibox.layout.fixed.horizontal,
            s.mytaglist,
            s.mypromptbox
        },
        {
            layout = wibox.layout.fixed.horizontal,
            s.mytasklist
        }, -- Middle widget
        {             -- Right widgets
            layout = wibox.layout.fixed.horizontal,
            wibox.widget.systray(),
            mytextclock
        },
    }
end)

globalkeys = gears.table.join(
    awful.key({ modkey, }, "s", hotkeys_popup.show_help,
        { description = "show help", group = "awesome" }),

    awful.key({ modkey, }, "u", awful.client.urgent.jumpto,
        { description = "jump to urgent client", group = "client" }),

    awful.key({ modkey, }, "Left",
        function()
            awful.client.focus.byidx(-1)
        end,
        { description = "focus next by index", group = "client" }
    ),

    awful.key({ modkey, }, "Right",
        function()
            awful.client.focus.byidx(1)
        end,
        { description = "focus previous by index", group = "client" }
    ),

    awful.key({ modkey, "Shift" }, "Left",
        function()
            awful.client.swap.byidx(-1)
        end,
        { description = "swap with next client by index", group = "client" }),

    awful.key({ modkey, "Shift" }, "Right",
        function()
            awful.client.swap.byidx(1)
        end,
        { description = "swap with previous client by index", group = "client" }),

    awful.key({ modkey, }, "Tab",
        function()
            awful.screen.focus_relative(1)
        end,
        { description = "focus the next screen", group = "screen" }),

    -- Standard program
    awful.key({ modkey, }, "Return", function() awful.spawn(terminal) end,
        { description = "open a terminal", group = "launcher" }),

    awful.key({ modkey, "Shift" }, "r",
        awesome.restart,
        { description = "reload awesome", group = "awesome" }
    ),

    awful.key({ modkey, "Shift" }, "e", awesome.quit,
        { description = "quit awesome", group = "awesome" }),
    awful.key({ modkey, }, "w",
        function()
            awful.layout.inc(1)
        end,
        { description = "select next", group = "layout" }),

    awful.key({ modkey, }, "Up",
        function()
            local c = awful.client.restore()
            -- Focus restored client
            if c then
                c:emit_signal(
                    "request::activate", "key.unminimize", { raise = true }
                )
            end
        end,
        { description = "restore minimized", group = "client" }),

    -- Prompt
    awful.key({ modkey }, "r", function() awful.screen.focused().mypromptbox:run() end,
        { description = "run prompt", group = "launcher" }),

    awful.key({ modkey }, "d", function() menubar.show() end,
        { description = "show the menubar", group = "launcher" }),
    awful.key({ modkey, "Control" }, "Up", function() awful.tag.incnmaster(1, nil, true) end,
        { description = "increase the number of master clients", group = "layout" }),
    awful.key({ modkey, "Control" }, "Down", function() awful.tag.incnmaster(-1, nil, true) end,
        { description = "decrease the number of master clients", group = "layout" }),
    awful.key({}, "Print", function () awful.spawn("flameshot gui") end,
        { description = "take screenshots", group = "layout" }
    ),
    awful.key({}, "XF86AudioRaiseVolume",
        function ()
            awful.spawn.easy_async_with_shell("pactl get-sink-volume @DEFAULT_SINK@ | grep -Po '[0-9]{1,3}(?=%)' | head -1", function(stdout)
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
        { description = "Volume Up", group = "layout" }
    ),
    awful.key({}, "XF86AudioLowerVolume", function ()
        awful.spawn("pactl set-sink-volume @DEFAULT_SINK@ -10%")
        awful.spawn.easy_async_with_shell("pactl get-sink-volume @DEFAULT_SINK@ | grep -Po '[0-9]{1,3}(?=%)' | head -1", function(stdout)
            naughty.notify({
                preset = naughty.config.presets.normal,
                title = "Vol Icon",
                text = stdout
            })
        end)
    end,
        { description = "Volume Down", group = "layout" }
    )
)

clientkeys = gears.table.join(
    awful.key({ modkey, }, "x",
        function(c)
            c:move_to_screen()
        end,
        { description = "move to screen", group = "client" }
    ),

    awful.key({ modkey, }, "f",
        function(c)
            c.fullscreen = not c.fullscreen
            c:raise()
        end,
        { description = "toggle fullscreen", group = "client" }
    ),

    awful.key({ modkey, "Shift" }, "q",
        function(c)
            c:kill()
        end,
        { description = "close", group = "client" }),
    awful.key({ modkey, "Shift" }, "space", awful.client.floating.toggle,
        { description = "toggle floating", group = "client" }),

    awful.key({ modkey, }, "Down",
        function(c)
            -- The client currently has the input focus, so it cannot be
            -- minimized, since minimized clients can't have the focus.
            c.minimized = true
        end,
        { description = "minimize", group = "client" }
    ),
    awful.key({ modkey,           }, "m",
        function (c)
            c.maximized = not c.maximized
            c:raise()
        end ,
        {description = "(un)maximize", group = "client"})
)

for i = 1, 9 do
    globalkeys = gears.table.join(globalkeys,
        -- View tag only.
        awful.key({ modkey }, "#" .. i + 9,
            function()
                local screen = awful.screen.focused()
                local tag = screen.tags[i]
                if tag then
                    tag:view_only()
                end
            end,
            { description = "view tag #" .. i, group = "tag" }),
        -- Toggle tag display.
        awful.key({ modkey, "Control" }, "#" .. i + 9,
            function()
                local screen = awful.screen.focused()
                local tag = screen.tags[i]
                if tag then
                    awful.tag.viewtoggle(tag)
                end
            end,
            { description = "toggle tag #" .. i, group = "tag" }),
        -- Move client to tag.
        awful.key({ modkey, "Shift" }, "#" .. i + 9,
            function()
                if client.focus then
                    local tag = client.focus.screen.tags[i]
                    if tag then
                        client.focus:move_to_tag(tag)
                    end
                end
            end,
            { description = "move focused client to tag #" .. i, group = "tag" }),
        -- Toggle tag on focused client.
        awful.key({ modkey, "Control", "Shift" }, "#" .. i + 9,
            function()
                if client.focus then
                    local tag = client.focus.screen.tags[i]
                    if tag then
                        client.focus:toggle_tag(tag)
                    end
                end
            end,
            { description = "toggle focused client on tag #" .. i, group = "tag" })
    )
end

clientbuttons = gears.table.join(
    awful.button({}, 1, function(c)
        c:emit_signal("request::activate", "mouse_click", { raise = true })
    end),
    awful.button({ modkey }, 1, function(c)
        c:emit_signal("request::activate", "mouse_click", { raise = true })
        awful.mouse.client.move(c)
    end),
    awful.button({ modkey }, 3, function(c)
        c:emit_signal("request::activate", "mouse_click", { raise = true })
        awful.mouse.client.resize(c)
    end)
)

root.keys(globalkeys)

awful.rules.rules = {
    -- All clients will match this rule.
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
    },

    -- Floating clients.
    {
        rule_any = {
            instance = {
                "DTA", -- Firefox addon DownThemAll.
            },
            class = {
                "Arandr",
            },

            -- Note that the name property shown in xprop might be set slightly after creation of the client
            -- and the name shown there might not match defined rules here.
            name = {
                "Event Tester", -- xev.
            },
            role = {
                "pop-up",  -- e.g. Google Chrome's (detached) Developer Tools.
            }
        },
        properties = { floating = true }
    },
    -- Add titlebars to normal clients and dialogs
    { rule_any = {type = { "normal", "dialog" }
      }, properties = { titlebars_enabled = true }
    },

    -- Set Firefox to always map on the tag named "2" on screen 1.
    -- { rule = { class = "Firefox" },
    --   properties = { screen = 1, tag = "2" } },
}

-- Add a titlebar if titlebars_enabled is set to true in the rules.
client.connect_signal("request::titlebars", function(c)
    -- buttons for the titlebar
    local buttons = gears.table.join(
        awful.button({ }, 1, function()
            c:emit_signal("request::activate", "titlebar", {raise = true})
            awful.mouse.client.move(c)
        end),
        awful.button({ }, 3, function()
            c:emit_signal("request::activate", "titlebar", {raise = true})
            awful.mouse.client.resize(c)
        end)
    )

    awful.titlebar(c) : setup {
        { -- Left
            awful.titlebar.widget.iconwidget(c),
            buttons = buttons,
            layout  = wibox.layout.fixed.horizontal
        },
        { -- Middle
            { -- Title
                align  = "center",
                widget = awful.titlebar.widget.titlewidget(c)
            },
            buttons = buttons,
            layout  = wibox.layout.flex.horizontal
        },
        { -- Right
            awful.titlebar.widget.floatingbutton (c),
            awful.titlebar.widget.maximizedbutton(c),
            awful.titlebar.widget.stickybutton   (c),
            awful.titlebar.widget.ontopbutton    (c),
            awful.titlebar.widget.closebutton    (c),
            layout = wibox.layout.fixed.horizontal()
        },
        layout = wibox.layout.align.horizontal
    }
end)

-- {{{ Signals
-- Signal function to execute when a new client appears.
client.connect_signal("manage", function (c)
    awful.tag.incnmaster(1, nil, true)

    if awesome.startup
      and not c.size_hints.user_position
      and not c.size_hints.program_position then
        -- Prevent clients from being unreachable after screen count changes.
        awful.client.setslave(c)
    end
end)

client.connect_signal("mouse::enter", function(c)
    c:emit_signal("request::activate", "mouse_enter", { raise = false })
end)

client.connect_signal("focus", function(c) c.border_color = beautiful.border_focus end)
client.connect_signal("unfocus", function(c) c.border_color = beautiful.border_normal end)

client.connect_signal("manage", function(c)
    c.shape = function(cr, w, h)
        gears.shape.rounded_rect(cr, w, h, 18)
    end
end)

awful.spawn.with_shell("/home/marcus/.screenlayout/dual.sh")
awful.spawn.with_shell("nm-applet")
awful.spawn.with_shell("blueman-applet")
awful.spawn.easy_async_with_shell("pkill -f flameshot", function()
    awful.spawn("flameshot")
end)
