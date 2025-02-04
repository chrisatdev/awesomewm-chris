-- widgets/cpu.lua
local awful = require("awful")
local wibox = require("wibox")
local gears = require("gears")

local cpu_widget = wibox.widget.textbox()

gears.timer {
    timeout = 5,
    call_now = true,
    autostart = true,
    callback = function()
        awful.spawn.easy_async("top -bn1 | grep 'Cpu(s)' | awk '{print $2 + $4}'", function(stdout)
            cpu_widget:set_text("CPU: " .. stdout:gsub("\n", "") .. "%")
        end)
    end
}

return cpu_widget
