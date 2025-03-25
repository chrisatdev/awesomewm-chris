local math = math
local screen = screen
local tonumber = tonumber

local zigcolumn = { name = "zigcolumn" }

function zigcolumn.arrange(p)
	local t = p.tag or screen[p.screen].selected_tag
	local wa = p.workarea
	local cls = p.clients

	if #cls == 0 then
		return
	end

	-- Inicializar la tabla de geometrías
	p.geometries = p.geometries or {}

	local num_x = t.master_count or 3 -- Número de columnas (default: 3)
	if num_x <= 1 then
		num_x = 3
	end -- Asegurar que tenemos al menos 3 columnas

	if #cls == 1 then
		-- Una ventana ocupa todo el espacio
		p.geometries[cls[1]] = {
			x = wa.x,
			y = wa.y,
			width = wa.width,
			height = wa.height,
		}
	elseif #cls == 2 then
		-- Dos columnas iguales
		local width = math.floor(wa.width / 2)

		for i = 1, 2 do
			local g = {}
			g.x = wa.x + (i - 1) * width
			g.y = wa.y

			if i == 2 then
				g.width = wa.width - width -- Ajustar para evitar problemas de redondeo
			else
				g.width = width
			end

			g.height = wa.height

			if g.width < 1 then
				g.width = 1
			end
			if g.height < 1 then
				g.height = 1
			end

			p.geometries[cls[i]] = g
		end
	elseif #cls == 3 then
		-- Tres columnas iguales
		local width = math.floor(wa.width / 3)

		for i = 1, 3 do
			local g = {}
			g.x = wa.x + (i - 1) * width
			g.y = wa.y

			if i == 3 then
				g.width = wa.width - 2 * width -- Ajustar para evitar problemas de redondeo
			else
				g.width = width
			end

			g.height = wa.height

			if g.width < 1 then
				g.width = 1
			end
			if g.height < 1 then
				g.height = 1
			end

			p.geometries[cls[i]] = g
		end
	elseif #cls == 4 then
		-- 2x2 grid
		local width = math.floor(wa.width / 2)
		local height = math.floor(wa.height / 2)

		for i = 1, 4 do
			local g = {}
			local row = math.floor((i - 1) / 2)
			local col = (i - 1) % 2

			g.x = wa.x + col * width
			g.y = wa.y + row * height

			if col == 1 then
				g.width = wa.width - width -- Ajustar para evitar problemas de redondeo
			else
				g.width = width
			end

			if row == 1 then
				g.height = wa.height - height -- Ajustar para evitar problemas de redondeo
			else
				g.height = height
			end

			if g.width < 1 then
				g.width = 1
			end
			if g.height < 1 then
				g.height = 1
			end

			p.geometries[cls[i]] = g
		end
	elseif #cls == 5 then
		-- 2 arriba, 3 abajo
		local width_top = math.floor(wa.width / 2)
		local width_bottom = math.floor(wa.width / 3)
		local height = math.floor(wa.height / 2)

		-- Fila superior: 2 ventanas
		for i = 1, 2 do
			local g = {}
			g.x = wa.x + (i - 1) * width_top
			g.y = wa.y

			if i == 2 then
				g.width = wa.width - width_top -- Ajustar para evitar problemas de redondeo
			else
				g.width = width_top
			end

			g.height = height

			if g.width < 1 then
				g.width = 1
			end
			if g.height < 1 then
				g.height = 1
			end

			p.geometries[cls[i]] = g
		end

		-- Fila inferior: 3 ventanas
		for i = 1, 3 do
			local g = {}
			g.x = wa.x + (i - 1) * width_bottom
			g.y = wa.y + height

			if i == 3 then
				g.width = wa.width - 2 * width_bottom -- Ajustar para evitar problemas de redondeo
			else
				g.width = width_bottom
			end

			g.height = wa.height - height

			if g.width < 1 then
				g.width = 1
			end
			if g.height < 1 then
				g.height = 1
			end

			p.geometries[cls[i + 2]] = g
		end
	else
		-- 6 o más ventanas: zigzag (1,3,5 arriba - 2,4,6 abajo)
		local width = math.floor(wa.width / 3)
		local height = math.floor(wa.height / 2)

		-- Primero, maneja las 6 ventanas principales
		local n = math.min(6, #cls)
		for i = 1, n do
			local g = {}
			local row = (i % 2 == 0) and 1 or 0 -- Alternamos: pares abajo, impares arriba
			local col = math.floor((i - 1) / 2) -- 0,0,1,1,2,2

			g.x = wa.x + col * width
			g.y = wa.y + row * height

			if col == 2 then
				g.width = wa.width - 2 * width -- Ajustar para evitar problemas de redondeo
			else
				g.width = width
			end

			if row == 1 then
				g.height = wa.height - height -- Ajustar para evitar problemas de redondeo
			else
				g.height = height
			end

			if g.width < 1 then
				g.width = 1
			end
			if g.height < 1 then
				g.height = 1
			end

			p.geometries[cls[i]] = g
		end

		-- Manejar ventanas adicionales si las hay (más de 6)
		if #cls > 6 then
			local remaining_height = math.floor((wa.height - 2 * height) / math.ceil((#cls - 6) / 3))

			for i = 7, #cls do
				local g = {}
				local row = 2 + math.floor((i - 7) / 3)
				local col = (i - 7) % 3

				g.x = wa.x + col * width
				g.y = wa.y + 2 * height + (row - 2) * remaining_height

				if col == 2 then
					g.width = wa.width - 2 * width -- Ajustar para evitar problemas de redondeo
				else
					g.width = width
				end

				if i >= #cls - ((#cls - 7) % 3) then
					g.height = wa.height - (2 * height + (row - 2) * remaining_height)
				else
					g.height = remaining_height
				end

				if g.width < 1 then
					g.width = 1
				end
				if g.height < 1 then
					g.height = 1
				end

				p.geometries[cls[i]] = g
			end
		end
	end
end

return zigcolumn
