-- widgets/init.lua
local widgets = {}

widgets.cpu = require("widgets.cpu")
widgets.memory = require("widgets.memory")
widgets.network = require("widgets.network")
widgets.systray = require("widgets.systray")
widgets.calendar = require("widgets.calendar")

return widgets
