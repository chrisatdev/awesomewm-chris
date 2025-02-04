-- modules/tags.lua
local awful = require("awful")
local beautiful = require("beautiful")

local tags = {}

function tags.setup(s)
    -- Definir tags
    s.tags = {
        awful.tag({ " 1 ", " 2 ", " 3 ", " 4 ", " 5 " }, s, awful.layout.layouts[1])
    }
end

return tags
