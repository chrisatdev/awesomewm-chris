-- rc.lua
-- Cargar librerías de AwesomeWM
local awful = require("awful")
local beautiful = require("beautiful")
local gears = require("gears")

local HOME_DIR = os.getenv("HOME")
local AUTOSTART_DIR = HOME_DIR .. "/code/bash/awesomewm/"
local vi_focus = false

-- Cargar configuración de temas
beautiful.init(gears.filesystem.get_configuration_dir() .. "themes/default/theme.lua")

-- Cargar módulos
require("modules.keys")
require("modules.tags")
require("modules.rules")
require("modules.layouts")
require("modules.widgets").load_widgets()

-- Inicializar AwesomeWM
awful.screen.connect_for_each_screen(function(s)
    -- Configurar tags y layouts para cada pantalla
    require("modules.tags").setup(s)
    require("modules.layouts").setup(s)
end)

-- Aplicar reglas
require("modules.rules").apply()

-- No borders when rearranging only 1 non-floating or maximized client
screen.connect_signal("arrange", function(s)
	local only_one = #s.tiled_clients == 1
	for _, c in pairs(s.clients) do
		if only_one and not c.floating or c.maximized or c.fullscreen then
			c.border_width = 0
		else
			c.border_width = beautiful.border_width
		end
	end
end)

-- Enable sloppy focus, so that focus follows mouse.
client.connect_signal("mouse::enter", function(c)
	c:emit_signal("request::activate", "mouse_enter", { raise = vi_focus })
end)

client.connect_signal("focus", function(c)
	c.border_color = beautiful.border_focus
end)
client.connect_signal("unfocus", function(c)
	c.border_color = beautiful.border_normal
end)

-- switch to parent after closing child window
local function backham()
	local s = awful.screen.focused()
	local c = awful.client.focus.history.get(s, 0)
	if c then
		client.focus = c
		c:raise()
	end
end

-- attach to minimized state
client.connect_signal("property::minimized", backham)
-- attach to closed state
client.connect_signal("unmanage", backham)
-- ensure there is always a selected client during tag switching or logins
tag.connect_signal("property::selected", backham)

-- Autostart applications
awful.spawn.with_shell(AUTOSTART_DIR .. "autoconfigure_display.sh")
awful.spawn.with_shell(AUTOSTART_DIR .. "autorun.sh")
awful.spawn.with_shell(AUTOSTART_DIR .. "locker.sh")
