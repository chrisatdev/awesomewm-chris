-- modules/keys.lua
local awful = require("awful")
local gears = require("gears")
local beautiful = require("beautiful")

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

  -- ALSA volume control
	awful.key({ modkey }, "=", function()
		os.execute("amixer -q sset Master 5%+")
	end, { description = "volume up", group = "hotkeys" }),
	awful.key({ modkey }, "-", function()
		os.execute("amixer -q sset Master 5%-")
	end, { description = "volume down", group = "hotkeys" }),
	awful.key({ modkey }, "\\", function()
		os.execute("amixer -q set Master toggle")
	end, { description = "toggle mute", group = "hotkeys" }),
	awful.key({ altkey, ctrlkey }, "m", function()
		os.execute(string.format("amixer -q set %s 100%%", beautiful.volume.channel))
		beautiful.volume.update()
	end, { description = "volume 100%", group = "hotkeys" }),
	awful.key({ altkey, ctrlkey }, "0", function()
		os.execute(string.format("amixer -q set %s 0%%", beautiful.volume.channel))
		beautiful.volume.update()
	end, { description = "volume 0%", group = "hotkeys" }),

	-- Spotify
	awful.key({ modkey }, "'", function()
		os.execute("sp play")
	end, { description = "Play/Mute", group = "spotify" }),
	awful.key({ modkey }, "]", function()
		os.execute("sp next")
	end, { description = "Siguiente cancion", group = "spotify" }),
	awful.key({ modkey }, "[", function()
		os.execute("sp prev")
	end, { description = "Cancion anterior", group = "spotify" }),

  -- Tag browsing
	awful.key({ modkey }, "Left", awful.tag.viewprev,
    { description = "view previous", group = "tag" }),

	awful.key({ modkey }, "Right", awful.tag.viewnext,
    { description = "view next", group = "tag" }),

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

  -- Layout and Columns manipulation
  awful.key({ modkey, altkey }, "l", function()
		awful.tag.incmwfact(0.05)
	end, { description = "increase master width factor", group = "layout" }),

  awful.key({ modkey, altkey }, "h", function()
		awful.tag.incmwfact(-0.05)
	end, { description = "decrease master width factor", group = "layout" }),

  awful.key({ modkey, shiftkey }, "h", function()
		awful.tag.incnmaster(1, nil, true)
	end, { description = "increase the number of master clients", group = "layout" }),

  awful.key({ modkey, shiftkey }, "l", function()
		awful.tag.incnmaster(-1, nil, true)
	end, { description = "decrease the number of master clients", group = "layout" }),

  awful.key({ modkey, ctrlkey }, "h", function()
		awful.tag.incncol(1, nil, true)
	end, { description = "increase the number of columns", group = "layout" }),

  awful.key({ modkey, ctrlkey }, "l", function()
		awful.tag.incncol(-1, nil, true)
	end, { description = "decrease the number of columns", group = "layout" }),

  -- Menu
	awful.key({ modkey }, "w", function()
		awful.util.mymainmenu:show()
	end, { description = "Mostrar Menu", group = "system" }),

  -- Recargar AwesomeWM
  awful.key({ modkey, ctrlkey }, "r", awesome.restart,
    { description = "Recargar AwesomeWM", group = "system" }),

  -- Salir de AwesomeWM
  awful.key({ modkey, shiftkey }, "q", awesome.quit,
    { description = "Salir de AwesomeWM", group = "system" })
)

-- Key bindings de cliente
local clientkeys = gears.table.join(
  -- Mover ventana a otra pantalla
  awful.key({ modkey }, "o", function(c) c:move_to_screen() end,
    { description = "Mover ventana a otra pantalla", group = "client" }),

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

for i = 1, 9 do
	globalkeys = gears.table.join(
		globalkeys,
		-- View tag only.
		awful.key({ modkey }, "#" .. i + 9, function()
			local screen = awful.screen.focused()
			local tag = screen.tags[i]
			if tag then
				tag:view_only()
			end
		end, { description = "view tag #" .. i, group = "tag" }),

		-- Move client to tag.
		awful.key({ modkey, shiftkey }, "#" .. i + 9, function()
			if client.focus then
				local tag = client.focus.screen.tags[i]
				if tag then
					client.focus:move_to_tag(tag)
				end
			end
		end, { description = "move focused client to tag #" .. i, group = "tag" })

	)
end

local clientbuttons = gears.table.join(
	awful.button({}, 1, function(c)
		c:emit_signal("request::activate", "mouse_click", { raise = true })
	end),
	awful.button({ modkey }, 1, function(c)
		c:emit_signal("request::activate", "mouse_click", { raise = true })
		awful.mouse.client.move(c)
	end),
	awful.button({ modkey }, 3, function(c)
		c:emit_signal("request::activate", "mouse_click", { raise = true })
		awful.mouse.client.resize(c)
	end)
)

-- Asignar key bindings globales
root.keys(globalkeys)

-- Devolver key bindings para su uso en otros módulos
return {
    globalkeys = globalkeys,
    clientkeys = clientkeys,
    clientbuttons = clientbuttons
}
