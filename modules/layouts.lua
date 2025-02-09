-- modules/layouts.lua
local awful = require("awful")
local gears = require("gears")
local beautiful = require("beautiful")

-- Definir los layouts disponibles
local layouts = {
    awful.layout.suit.tile,        -- Mosaico (tiling)
    awful.layout.suit.floating,    -- Ventanas flotantes
    awful.layout.suit.max,         -- Maximizado
    -- awful.layout.suit.tile.left,   -- Mosaico a la izquierda
    -- awful.layout.suit.tile.bottom, -- Mosaico en la parte inferior
    -- awful.layout.suit.fair,        -- Distribución equitativa
    awful.layout.suit.spiral,      -- Espiral
    awful.layout.suit.magnifier    -- Magnificador
}

-- Cambiar el número de ventanas maestras en el layout de mosaico
awful.layout.layouts[1].nmaster = 2

-- Función para configurar los layouts en una pantalla
local function setup(s)
    -- Asignar los layouts a la pantalla
    s.layouts = layouts

   -- Establecer el layout predeterminado (tile)
    awful.layout.set(awful.layout.suit.tile, s)
end

-- Aplicar los layouts a todas las pantallas
awful.screen.connect_for_each_screen(function(s)
    setup(s)
end)

return {
    setup = setup
}
