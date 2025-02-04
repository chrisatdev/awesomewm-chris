-- widgets/calendar.lua
local wibox = require("wibox")

local calendar = wibox.widget.textclock("%Y-%m-%d %H:%M")

return calendar
