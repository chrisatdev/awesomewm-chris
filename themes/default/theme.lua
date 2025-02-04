local dpi = require("beautiful.xresources").apply_dpi

-- themes/default/theme.lua
local theme = {}

theme.font = "Fira Nerd Font 10.5"

theme.bg_normal = "#1f2024"
theme.bg_focus = "#31353f"
theme.bg_subtle = "#2b2b33"
theme.bg_urgent = theme.bg_focus
theme.bg_minimize = theme.bg_normal
theme.bg_dark = theme.bg_normal
theme.bg_systray = theme.bg_normal

theme.fg_normal = "#c6c6c6"
theme.fg_focus = "#ededed"
theme.fg_urgent = "#e1c1ee"
theme.fg_minimize = "#4c4f59"

theme.border_width = dpi(0)
theme.border_color_normal = theme.bg_normal
theme.border_color_active = theme.bg_focus
theme.border_color_marked = theme.bg_normal

theme.blue = "#819cd6"
theme.purple = "#b0a2e7"
theme.green = "#8ca378"
theme.red = "#ef7789"
theme.yellow = "#cfcf9c"
theme.warn = theme.yellow
theme.critical = theme.red

theme.titlebar_bg_focus = theme.bg_focus
theme.titlebar_bg_normal = theme.bg_subtle

theme.taglist_bg_empty = theme.bg_subtle
theme.taglist_bg_focus = theme.purple
theme.taglist_bg_occupied = theme.bg_focus

theme.useless_gap = dpi(4)

theme.ocol = "<span color='" .. theme.fg_normal .. "'>"
theme.tasklist_sticky = theme.ocol .. "[S]</span>"
theme.tasklist_ontop = theme.ocol .. "[T]</span>"
theme.tasklist_floating = theme.ocol .. "[F]</span>"
theme.tasklist_maximized_horizontal = theme.ocol .. "[M] </span>"
theme.tasklist_maximized_vertical = ""
theme.tasklist_disable_icon = true

theme.layout_txt_tile = "[t]"
theme.layout_txt_tileleft = "[l]"
theme.layout_txt_tilebottom = "[b]"
theme.layout_txt_tiletop = "[tt]"
theme.layout_txt_fairv = "[fv]"
theme.layout_txt_fairh = "[fh]"
theme.layout_txt_spiral = "[s]"
theme.layout_txt_dwindle = "[d]"
theme.layout_txt_max = "[m]"
theme.layout_txt_fullscreen = "[F]"
theme.layout_txt_magnifier = "[M]"
theme.layout_txt_floating = "[*]"

theme.notification_max_height = 160
theme.notification_max_width = 400
theme.notification_icon_size = 75

return theme
