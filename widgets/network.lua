-- widgets/network.lua
local awful = require("awful")
local wibox = require("wibox")
local gears = require("gears")

local net_widget = wibox.widget.textbox()

gears.timer {
    timeout = 10,
    call_now = true,
    autostart = true,
    callback = function()
        awful.spawn.easy_async("vnstat -i wlp2s0 --oneline | awk '{print $6, $7}'", function(stdout)
            net_widget:set_text("Net: " .. stdout:gsub("\n", ""))
        end)
    end
}

return net_widget
