-- modules/widgets.lua
local awful = require("awful")
local wibox = require("wibox")
local gears = require("gears")
local beautiful = require("beautiful")
local dpi = require("beautiful.xresources").apply_dpi

-- Cargar widgets desde la carpeta widgets/
local widgets = require("widgets")

-- Función para cargar los widgets en la barra
local function load_widgets()
    -- Crear una barra en cada pantalla
    awful.screen.connect_for_each_screen(function(s)
        local mywibox = awful.wibar({ position = "top", screen = s , height = dpi(20)})

        -- Widget de tags
        local taglist = awful.widget.taglist {
            screen = s,
            filter = awful.widget.taglist.filter.all,
            buttons = {
                awful.button({}, 1, function(t) t:view_only() end),  -- Click izquierdo: ver solo el tag
                awful.button({ modkey }, 1, function(t) if client.focus then client.focus:move_to_tag(t) end end),  -- Mod + Click: mover ventana al tag
            }
        }

        mywibox:setup {
            layout = wibox.layout.align.horizontal,
            { -- Widgets de la izquierda (tags)
                layout = wibox.layout.fixed.horizontal,
                taglist,  -- Mostrar tags aquí
            },
            { -- Widgets del centro (opcional)
                layout = wibox.layout.fixed.horizontal,
            },
            { -- Widgets de la derecha
                layout = wibox.layout.fixed.horizontal,
                -- widgets.cpu,
                -- widgets.memory,
                -- widgets.network,
                -- layoutbox,  -- Mostrar el layout activo
                widgets.systray,
                widgets.calendar,
            },
        }
    end)
end

-- Exportar la función load_widgets
return {
    load_widgets = load_widgets
}
