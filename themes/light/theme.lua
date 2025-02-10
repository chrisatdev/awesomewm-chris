local dpi = require("beautiful.xresources").apply_dpi

local theme = {}

theme.font = "Fira Nerd Font 10.5"

-- Paleta de colores inspirada en Windows XP
theme.bg_normal   = "#3A6EA5"
theme.bg_focus    = "#1C4C89"
theme.bg_urgent   = "#FF0000"
theme.fg_normal   = "#FFFFFF"
theme.fg_focus    = "#FFFF00"
theme.fg_urgent   = "#FFFFFF"

theme.border_width  = 2
theme.border_normal = "#1C4C89"
theme.border_focus  = "#FFCC00"
theme.border_marked = "#CC3333"

theme.border_width = dpi(1)
theme.border_color_normal = theme.bg_normal
theme.border_color_active = theme.bg_focus
theme.border_color_marked = theme.bg_normal

theme.taglist_bg_empty = theme.bg_normal
theme.taglist_bg_focus = theme.bg_focus
theme.taglist_bg_occupied = theme.bg_focus

theme.useless_gap = dpi(4)

theme.notification_max_height = 160
theme.notification_max_width = 400
theme.notification_icon_size = 75

return theme
