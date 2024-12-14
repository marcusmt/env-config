local theme_assets = require("beautiful.theme_assets")
local xresources = require("beautiful.xresources")
local dpi = xresources.apply_dpi

local gfs = require("gears.filesystem")
local themes_path = gfs.get_themes_dir()

local theme = {}

theme.font          = "Hack Nerd Font 8"
theme.useless_gap   = dpi(3)

theme.bg_normal     = "#a89984"
theme.bg_focus      = "#d5c4a1"
theme.bg_urgent     = "#cc241d"
theme.bg_minimize   = "#444444"
theme.bg_systray    = "#a89984"

theme.fg_normal     = "#504945"
theme.fg_focus      = "#1d2021"
theme.fg_urgent     = "#1d2021"
theme.fg_minimize   = "#1d2021"

theme.border_width  = dpi(2)
theme.border_normal = "#504945"
theme.border_focus  = "#a89984"
theme.border_marked = "#cc241d"
theme.wibar_height = 30

local taglist_square_size = dpi(4)
theme.taglist_squares_sel = theme_assets.taglist_squares_sel(
    taglist_square_size, theme.fg_normal
)
theme.taglist_squares_unsel = theme_assets.taglist_squares_unsel(
    taglist_square_size, theme.fg_normal
)

theme.wallpaper = "/home/marcus/.config/awesome/wall7.jpg"

theme.icon_theme = "/home/marcus/.icons/Papirus/"

return theme