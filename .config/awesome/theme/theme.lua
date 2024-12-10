local theme_assets = require("beautiful.theme_assets")
local xresources = require("beautiful.xresources")
local dpi = xresources.apply_dpi

local gfs = require("gears.filesystem")
local themes_path = gfs.get_themes_dir()

local theme = {}

theme.tasklist_disable_task_name = false

theme.font          = "Hack Nerd Font 8"
theme.useless_gap   = dpi(3)

theme.bg_normal     = "#333336"
theme.bg_focus      = "#656462"
theme.bg_urgent     = "#ff0000"
theme.bg_minimize   = "#444444"
theme.bg_systray    = "#383231"

theme.fg_normal     = "#ffffff"
theme.fg_focus      = "#ffffff"
theme.fg_urgent     = "#ffffff"
theme.fg_minimize   = "#ffffff"

theme.border_width  = dpi(1)
theme.border_normal = "#000000"
theme.border_focus  = "#b86b0c"
theme.border_marked = "#91231c"

local taglist_square_size = dpi(4)
theme.taglist_squares_sel = theme_assets.taglist_squares_sel(
    taglist_square_size, theme.fg_normal
)
theme.taglist_squares_unsel = theme_assets.taglist_squares_unsel(
    taglist_square_size, theme.fg_normal
)

theme.menu_submenu_icon = themes_path.."default/submenu.png"
theme.menu_height = dpi(15)
theme.menu_width  = dpi(50)

theme.wallpaper = "/home/marcus/.config/awesome/wall7.jpg"

theme.icon_theme = "/home/marcus/.icons/Papirus/"

return theme
