-- notification_tray.lua

local naughty = require("naughty")
local awful = require("awful")
local wibox = require("wibox")
local gears = require("gears")

-- Mensaje de depuración
naughty.notify({ title = "Debug", text = "Cargando notification_tray.lua" })

-- Tabla para almacenar las notificaciones
local notifications = {}

-- Función para actualizar la bandeja de notificaciones
local function update_tray(tray_widget)
    tray_widget:reset()
    for i, notification in ipairs(notifications) do
        local notification_widget = wibox.widget {
            {
                {
                    text = notification.title or "Notificación",
                    widget = wibox.widget.textbox,
                },
                {
                    text = notification.message or "",
                    widget = wibox.widget.textbox,
                },
                layout = wibox.layout.fixed.vertical,
            },
            margins = 5,
            widget = wibox.container.margin,
        }

        -- Marcar como leída al hacer clic
        notification_widget:connect_signal("button::press", function()
            table.remove(notifications, i)
            update_tray(tray_widget)
        end)

        tray_widget:add(notification_widget)
    end
end

-- Función para limpiar todas las notificaciones
local function clear_notifications(tray_widget)
    notifications = {}
    update_tray(tray_widget)
end

-- Función para agregar una notificación a la bandeja
local function add_notification(title, message, tray_widget)
    table.insert(notifications, { title = title, message = message })
    update_tray(tray_widget)
end

-- Crear un widget de bandeja de notificaciones
local notification_tray = wibox.widget {
    layout = wibox.layout.fixed.vertical,
}

-- Crear un botón para limpiar notificaciones
local clear_button = wibox.widget {
    text = "Limpiar notificaciones",
    widget = wibox.widget.textbox,
}

clear_button:connect_signal("button::press", function()
    clear_notifications(notification_tray)
end)

-- Crear un contenedor para la bandeja y el botón
local notification_tray_container = wibox.widget {
    {
        notification_tray,
        layout = wibox.layout.fixed.vertical,
    },
    {
        clear_button,
        widget = wibox.container.margin,
    },
    layout = wibox.layout.fixed.vertical,
}

-- Interceptar nuevas notificaciones y agregarlas a la bandeja
naughty.connect_signal("request::display", function(n)
    add_notification(n.title, n.message, notification_tray)
end)

-- Mensaje de depuración
naughty.notify({ title = "Debug", text = "Widget de notificaciones cargado correctamente" })

-- Exportar el widget para que pueda ser usado en rc.lua
return notification_tray_container
