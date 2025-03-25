--[[

  Awesome WM theme 1.0
  Author: chrisdev

--]]

local gears = require("gears")
local lain = require("lain")
local awful = require("awful")
local wibox = require("wibox")
local dpi = require("beautiful.xresources").apply_dpi
local spotify_widget = require("widgets.spotify")
local toggle_notifications = require("widgets.toggle_notifications")
-- Cargar el widget de la bandeja de notificaciones
-- local notification_tray = require("widgets.notification_tray")

-- Crear un popup para mostrar la bandeja de notificaciones
-- local notification_popup = awful.popup {
--     widget = notification_tray,
--     visible = false,
--     ontop = true,
--     placement = awful.placement.centered,
--     shape = gears.shape.rounded_rect,
--     border_width = 1,
--     border_color = "#777777",
--     bg = "#222222",
-- }

-- Crear un widget de texto para abrir/cerrar la bandeja
-- local tray_toggle = wibox.widget.textbox()
-- tray_toggle:set_text("📥 Notificaciones")
--
-- tray_toggle:connect_signal("button::press", function()
--     notification_popup.visible = not notification_popup.visible
-- end)

local os = os
local my_table = awful.util.table or gears.table -- 4.{0,1} compatibility

local theme = {}
theme.default_dir = require("awful.util").get_themes_dir() .. "default"
theme.dir = os.getenv("HOME") .. "/.config/awesome/themes/awsdark"
local font = "Droid Sans"
local iconsFont = "Material Icons 15"
theme.font = font .. " Regular 11"
theme.bg_normal = "#161D26"
theme.bg_focus = "#42b4ff"
theme.bg_urgent = "#FF0000"
theme.fg_normal = "#dedee3"
theme.fg_focus = "#ff9900"
theme.fg_urgent = "#dedee3"

theme.border_width = dpi(1)
theme.border_normal = "#42b4ff"
theme.border_focus = "#ff9900"
theme.border_marked = "#CC3333"

-- | Tag List | --
theme.taglist_font = font .. " Regular 10"
theme.taglist_spacing = 4
theme.taglist_bg_empty = theme.bg_normal
theme.taglist_fg_focus = "#0f141a"
theme.taglist_bg_focus = "#ff9900"
theme.taglist_fg_occupied = "#0f141a"
theme.taglist_bg_occupied = theme.bg_focus
theme.taglist_shape = function(cr, width, height)
	gears.shape.rounded_rect(cr, width, height, dpi(4))
end
theme.taglist_squares_sel = theme.dir .. "/icons/square_sel.png"
theme.taglist_squares_unsel = theme.dir .. "/icons/square_unsel.png"

-- | Menu | --
theme.menu_height = dpi(16)
theme.menu_width = dpi(140)
theme.awesome_icon = theme.dir .. "/icons/awesome.png"
theme.menu_submenu_icon = theme.dir .. "/icons/submenu.png"

-- | Task List | --
theme.ocol = "<span color='" .. theme.fg_normal .. "'>"
theme.tasklist_sticky = theme.ocol .. "[S]</span>"
theme.tasklist_ontop = theme.ocol .. "[T]</span>"
theme.tasklist_floating = theme.ocol .. "[F]</span>"
theme.tasklist_maximized_horizontal = theme.ocol .. "[M] </span>"
theme.tasklist_maximized_vertical = ""
theme.tasklist_disable_icon = true

-- | Tooltip | --
theme.tooltip_fg = "#0f141a"

-- | Layout | --
theme.useless_gap = dpi(4)
theme.layout_txt_tile = "[t]"
theme.layout_txt_zigcolumn = "[z]"
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

-- lain related
theme.layout_txt_cascade = "[cascade]"
theme.layout_txt_cascadetile = "[cascadetile]"
theme.layout_txt_centerwork = "[centerwork]"
theme.layout_txt_termfair = "[termfair]"
theme.layout_txt_centerfair = "[centerfair]"

-- | Notifications | --
theme.notification_max_width = dpi(400)
theme.notification_max_height = dpi(160)
theme.notification_font = theme.font
theme.notification_bg = theme.bg_normal
theme.notification_fg = theme.fg_normal
theme.notification_border_width = dpi(1)
theme.notification_border_color = theme.border_focus
theme.notification_opacity = 0.8
theme.notification_icon_size = dpi(48)
theme.notification_shape = function(cr, width, height)
	gears.shape.rounded_rect(cr, width, height, 3)
end

local markup = lain.util.markup

-- | Textclock | --
local clockIcon = wibox.widget.textbox()
clockIcon:set_text("󰥔")
clockIcon:set_font(iconsFont)
local clockIconWithMargin = wibox.container.margin(clockIcon, 5, 5, 0, 0)

local mytextclock = wibox.widget.textclock(markup(theme.fg_normal, "%H:%M"))
mytextclock.font = theme.font

local mytextdate = wibox.widget.textclock(markup(theme.fg_normal, "%d/%m/%Y"))
mytextdate.font = theme.font

-- | Calendar | --
local calIcon = wibox.widget.textbox()
calIcon:set_text("󰸗")
calIcon:set_font(iconsFont)
local calIconWithMargin = wibox.container.margin(calIcon, 5, 5, 0, 0)
theme.cal = lain.widget.cal({
	attach_to = { mytextdate },
	notification_preset = {
		font = "Terminus 11",
		fg = theme.fg_normal,
		bg = theme.bg_normal,
	},
})

-- | CPU | --
local cpuicon = wibox.widget.textbox()
cpuicon:set_text("󰻠")
cpuicon:set_font(iconsFont)
local cpuIconWithMargin = wibox.container.margin(cpuicon, 5, 5, 0, 0)
local cpu = lain.widget.cpu({
	settings = function()
		widget:set_markup(markup.fontfg(theme.font, theme.fg_normal, cpu_now.usage .. "% "))
	end,
})

-- | Net | --
local netdownicon = wibox.widget.textbox()
netdownicon:set_text("󰜮")
netdownicon:set_font(iconsFont)
local netDownIconWithMargin = wibox.container.margin(netdownicon, 5, 5, 0, 0)
local netdowninfo = wibox.widget.textbox()

local netupicon = wibox.widget.textbox()
netupicon:set_text("󰜷")
netupicon:set_font(iconsFont)
local netUpIconWithMargin = wibox.container.margin(netupicon, 5, 5, 0, 0)
local netupinfo = lain.widget.net({
	settings = function()
		widget:set_markup(markup.fontfg(theme.font, theme.fg_normal, net_now.sent .. " "))
		netdowninfo:set_markup(markup.fontfg(theme.font, theme.fg_normal, net_now.received .. " "))
	end,
})

-- | MEM | --
local memicon = wibox.widget.textbox()
memicon:set_text("󰍛")
memicon:set_font(iconsFont)
local memIconWithMargin = wibox.container.margin(memicon, 5, 5, 0, 0)
local memory = lain.widget.mem({
	settings = function()
		widget:set_markup(markup.fontfg(theme.font, theme.fg_normal, mem_now.used .. "MB "))
	end,
})

-- Separators
local spr = wibox.widget.textbox(" ")

local function update_txt_layoutbox(s)
	-- Writes a string representation of the current layout in a textbox widget
	local txt_l = theme["layout_txt_" .. awful.layout.getname(awful.layout.get(s))] or ""
	s.mytxtlayoutbox:set_text(txt_l)
end

function theme.at_screen_connect(s)
	-- Tags
	awful.tag(awful.util.tagnames, s, awful.layout.layouts[1])

	-- Create a promptbox for each screen
	s.mypromptbox = awful.widget.prompt()

	-- Textual layoutbox
	s.mytxtlayoutbox = wibox.widget.textbox(theme["layout_txt_" .. awful.layout.getname(awful.layout.get(s))])
	awful.tag.attached_connect_signal(s, "property::selected", function()
		update_txt_layoutbox(s)
	end)
	awful.tag.attached_connect_signal(s, "property::layout", function()
		update_txt_layoutbox(s)
	end)
	s.mytxtlayoutbox:buttons(my_table.join(
		awful.button({}, 1, function()
			awful.layout.inc(1)
		end),
		awful.button({}, 2, function()
			awful.layout.set(awful.layout.layouts[1])
		end),
		awful.button({}, 3, function()
			awful.layout.inc(-1)
		end),
		awful.button({}, 4, function()
			awful.layout.inc(1)
		end),
		awful.button({}, 5, function()
			awful.layout.inc(-1)
		end)
	))

	-- Create a taglist widget
	s.mytaglist = awful.widget.taglist({
		screen = s,
		filter = awful.widget.taglist.filter.all,
		buttons = awful.util.taglist_buttons,
		widget_template = {
			{
				{
					id = "text_role",
					widget = wibox.widget.textbox,
					font = theme.font, -- Usar la fuente definida en el tema
				},
				margins = 4, -- Ajustar el margen alrededor del texto
				widget = wibox.container.margin,
			},
			id = "background_role",
			widget = wibox.container.background,
		},
	})

	-- Create a tasklist widget
	-- s.mytasklist = awful.widget.tasklist(s, awful.widget.tasklist.filter.currenttags, awful.util.tasklist_buttons)

	-- Create the wibox
	s.mywibox =
	    awful.wibar({ position = "top", screen = s, height = dpi(20), bg = theme.bg_normal, fg = theme.fg_normal })

	-- Add widgets to the wibox
	s.mywibox:setup({
		layout = wibox.layout.align.horizontal,
		{ -- Left widgets
			layout = wibox.layout.fixed.horizontal,
			spr,
			s.mytaglist,
			spr,
			s.mytxtlayoutbox,
			s.mypromptbox,
			spr,
			spotify_widget(),
			spr,
		},
		{ -- Centered widgets
			layout = wibox.container.place,
			{
				layout = wibox.layout.fixed.horizontal,
				calIconWithMargin,
				mytextdate,
				spr,
				clockIconWithMargin,
				mytextclock,
				spr,
				spr,
				spr,
				spr,
				toggle_notifications,
			},
		},
		{ -- Right widgets
			layout = wibox.layout.fixed.horizontal,
			wibox.widget.systray(),
			spr,
			netDownIconWithMargin,
			netdowninfo,
			netUpIconWithMargin,
			netupinfo.widget,
			memIconWithMargin,
			memory.widget,
			cpuIconWithMargin,
			cpu.widget,
			spr,
		},
	})
end

return theme
