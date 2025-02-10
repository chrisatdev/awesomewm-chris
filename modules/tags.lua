-- modules/tags.lua
local awful = require("awful")
local beautiful = require("beautiful")

local tags = {}

awful.util.tagnames = { "", "", "", "", "" } -- Navegador, Código, Terminal, Sistema, Media

function tags.setup(s)
	awful.tag(awful.util.tagnames, s, awful.layout.layouts[1])

    -- Hacer los tags clickeables
	s.mytaglist = awful.widget.taglist(s, awful.widget.taglist.filter.all, awful.util.taglist_buttons)
end

return tags
