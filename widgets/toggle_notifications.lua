-- toggle_notifications.lua

local naughty = require("naughty")
local awful = require("awful")
local wibox = require("wibox")

local notifications_enabled = true
local notification_position = "top_right" -- Puede ser "top_right" o "top_center"

-- Función para cambiar la posición de las notificaciones
local function set_notification_position(position)
    if position == "top_right" then
        naughty.config.presets.normal.position = "top_right"
    elseif position == "top_center" then
        naughty.config.presets.normal.position = "top_middle"
    end
end

-- Función para encender/apagar las notificaciones
local function toggle_notifications()
    notifications_enabled = not notifications_enabled
    if notifications_enabled then
        set_notification_position(notification_position)
        naughty.config.notify_callback = nil
    else
        naughty.config.notify_callback = function() return false end
    end
end

-- Crear un widget de texto para mostrar el estado de las notificaciones
local notification_widget = wibox.widget.textbox()
notification_widget:set_text("󰂚")

-- Actualizar el texto del widget cuando se cambie el estado
local function update_widget_text()
  if notifications_enabled then
    notification_widget:set_text("󰂚")
  else
    notification_widget:set_text("󰂛")
  end
end

notification_widget:set_font("Material Icons 14")

-- Conectar el widget a un clic para alternar las notificaciones
notification_widget:connect_signal("button::press", function()
    toggle_notifications()
    update_widget_text()
end)

-- Exportar el widget para que pueda ser usado en rc.lua
return notification_widget
