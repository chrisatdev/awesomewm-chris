-- widgets/memory.lua
local awful = require("awful")
local wibox = require("wibox")
local gears = require("gears")

local mem_widget = wibox.widget.textbox()

gears.timer {
    timeout = 5,
    call_now = true,
    autostart = true,
    callback = function()
        awful.spawn.easy_async("free -m | awk 'NR==2{printf \"%s/%sMB\", $3, $2}'", function(stdout)
            mem_widget:set_text("Mem: " .. stdout)
        end)
    end
}

return mem_widget
