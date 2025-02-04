-- rc.lua
-- Cargar librerías de AwesomeWM
local awful = require("awful")
local beautiful = require("beautiful")
local gears = require("gears")

local HOME_DIR = os.getenv("HOME")
local AUTOSTART_DIR = HOME_DIR .. "/code/bash/awesomewm/"
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

-- Autostart applications
awful.spawn.with_shell(AUTOSTART_DIR .. "autoconfigure_display.sh")
awful.spawn.with_shell(AUTOSTART_DIR .. "autorun.sh")
awful.spawn.with_shell(AUTOSTART_DIR .. "locker.sh")
