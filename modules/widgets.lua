-- modules/widgets.lua
local awful = require("awful")
local wibox = require("wibox")
local gears = require("gears")
local beautiful = require("beautiful")
local dpi = require("beautiful.xresources").apply_dpi

-- Cargar widgets desde la carpeta widgets/
local widgets = require("widgets")

-- Textos personalizados para los layouts
local layout_texts = {
    tile = beautiful.layout_txt_tile or "[t]",
    spiral = beautiful.layout_txt_spiral or "[s]",
    max = beautiful.layout_txt_max or "[m]",
    magnifier = beautiful.layout_txt_magnifier or "[M]",
    floating = beautiful.layout_txt_floating or "[*]",
}

-- Widget de texto para mostrar el layout activo
local layout_text_widget = wibox.widget.textbox()
layout_text_widget:set_font(beautiful.font)  -- Usar la fuente definida en el tema

-- Función para actualizar el texto del layout activo
local function update_layout_text(s)
    local layout_name = awful.layout.getname(awful.layout.get(s))
    layout_text_widget:set_text(layout_texts[layout_name] or "[?]")
end

-- Actualizar el texto del layout activo cuando cambie
awful.tag.attached_connect_signal(nil, "property::selected", function()
    update_layout_text(awful.screen.focused())
end)

-- -- Cambiar de layout al hacer clic en el widget
layout_text_widget:buttons(gears.table.join(
    awful.button({}, 1, function() awful.layout.inc(1) end),  -- Click izquierdo: siguiente layout
    awful.button({}, 3, function() awful.layout.inc(-1) end)  -- Click derecho: layout anterior
))

-- Separador entre texto o widgets
local spr = wibox.widget.textbox(" ")

-- Función para cargar los widgets en la barra
local function load_widgets(s)
    -- Crear una barra en cada pantalla
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
			      spr,
            layout_text_widget,  -- Mostrar el texto del layout activo
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
end

-- Exportar la función load_widgets
return {
    load_widgets = load_widgets
}
