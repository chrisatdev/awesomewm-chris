-- modules/keys.lua
local awful = require("awful")
local gears = require("gears")

local modkey   = "Mod4" -- Tecla Super/Windows
local altkey   = "Mod1"
local ctrlkey  = "Control"
local shiftkey = "Shift"
local space    = "space"

-- Variables de aplicaciones
local browser = "thorium-browser"
local screenshot = "flameshot"
local terminal = "alacritty"
local file_manager = terminal .. " -e ranger"
local editor = "nvim"
local music_player = "spotify"
local launcher = "rofi -show drun"

-- Key bindings globales
local globalkeys = gears.table.join(
    -- Abrir terminal
    awful.key({ modkey }, "Return", function() awful.spawn(terminal) end,
              { description = "Abrir terminal", group = "launcher" }),

    -- Abrir navegador
    awful.key({ modkey }, "b", function() awful.spawn(browser) end,
              { description = "Abrir navegador", group = "launcher" }),

    -- Captura de pantalla
    awful.key({ modkey, shiftkey }, "s", function() awful.spawn(screenshot) end,
              { description = "Captura de pantalla", group = "utils" }),

    -- Abrir gestor de archivos
    awful.key({ modkey }, "e", function() awful.spawn(file_manager) end,
              { description = "Abrir gestor de archivos", group = "launcher" }),

    -- Abrir editor de código
    awful.key({ modkey, ctrlkey }, "e", function() awful.spawn(editor) end,
              { description = "Abrir editor de código", group = "launcher" }),

    -- Abrir reproductor de música
    awful.key({ modkey }, "p", function() awful.spawn(music_player) end,
              { description = "Abrir reproductor de música", group = "launcher" }),

    -- Abrir lanzador
    awful.key({ ctrlkey }, space, function() awful.spawn(launcher) end,
              { description = "Abrir lanzador", group = "launcher" }),


  -- Key bindings para cambiar entre layouts
  awful.key({ modkey }, "space", function() awful.layout.inc(1) end,
          { description = "Cambiar al siguiente layout", group = "layout" }),

  awful.key({ modkey, "Shift" }, "space", function() awful.layout.inc(-1) end,
          { description = "Cambiar al layout anterior", group = "layout" }),

  -- Tag browsing
	awful.key({ modkey }, "Left", awful.tag.viewprev, { description = "view previous", group = "tag" }),
	awful.key({ modkey }, "Right", awful.tag.viewnext, { description = "view next", group = "tag" }),

  -- By-direction client focus
	awful.key({ modkey }, "j", function()
		awful.client.focus.global_bydirection("down")
		if client.focus then
			client.focus:raise()
		end
	end, { description = "focus down", group = "client" }),
	awful.key({ modkey }, "k", function()
		awful.client.focus.global_bydirection("up")
		if client.focus then
			client.focus:raise()
		end
	end, { description = "focus up", group = "client" }),
	awful.key({ modkey }, "h", function()
		awful.client.focus.global_bydirection("left")
		if client.focus then
			client.focus:raise()
		end
	end, { description = "focus left", group = "client" }),
	awful.key({ modkey }, "l", function()
		awful.client.focus.global_bydirection("right")
		if client.focus then
			client.focus:raise()
		end
	end, { description = "focus right", group = "client" }),

  -- Menu
	awful.key({ modkey }, "w", function()
		awful.util.mymainmenu:show()
	end, { description = "show main menu", group = "system" }),

  -- Recargar AwesomeWM
    awful.key({ modkey, ctrlkey }, "r", awesome.restart,
              { description = "Recargar AwesomeWM", group = "system" }),

    -- Salir de AwesomeWM
    awful.key({ modkey, shiftkey }, "q", awesome.quit,
              { description = "Salir de AwesomeWM", group = "system" })
)

-- Key bindings de cliente
local clientkeys = gears.table.join(
  awful.key({ modkey }, "o", function(c)
		c:move_to_screen()
	end, { description = "move to screen", group = "client" }),

    -- Cerrar ventana
    awful.key({ modkey, shiftkey }, "c", function(c) c:kill() end,
              { description = "Cerrar ventana", group = "client" }),

    -- Pantalla completa
    awful.key({ modkey }, "f", function(c)
        c.fullscreen = not c.fullscreen
        c:raise()
    end, { description = "Pantalla completa", group = "client" }),

    -- Minimizar ventana
    awful.key({ modkey }, "n", function(c) c.minimized = true end,
              { description = "Minimizar ventana", group = "client" }),

    -- Maximizar ventana
    awful.key({ modkey }, "m", function(c)
    c.maximized = not c.maximized
		c:raise()
    end,{ description = "Maximizar ventana", group = "client" })
)

-- Asignar key bindings globales
root.keys(globalkeys)

-- Devolver key bindings para su uso en otros módulos
return {
    globalkeys = globalkeys,
    clientkeys = clientkeys
}
