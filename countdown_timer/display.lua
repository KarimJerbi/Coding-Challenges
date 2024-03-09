-- display.lua : creates a 7 segment display (@KarimJerbi)

-- n : 0:off 1:on order:abcdefg (see wikipedia)
-- example N = "1110111" display A
-- x,y: where to draw
-- s: Size
function newdisplay(n,x,y,s)
	local display = {}
	display.a = {}
	display.a.x = x + s
	display.a.y = y
	display.b = {}
	display.b.x = x + (4*s)
	display.b.y = y + s
	display.c = {}
	display.c.x = display.b.x 
	display.c.y = y + (5*s)
	display.d = {}
	display.d.x = display.a.x
	display.d.y = y + (8*s)
	display.e = {}
	display.e.x  = x
	display.e.y = display.c.y
	display.f = {}
	display.f.x = x
	display.f.y = display.b.y
	display.g = {}
	display.g.x = display.a.x
	display.g.y = y + (4*s)
	-- A
	love.graphics.setColor(1, 0, 0, string.sub(n, 1, 1))
	love.graphics.rectangle('fill',display.a.x,display.a.y,s*3, s,s/2,s/2)
	-- B
	love.graphics.setColor(1, 0, 0, string.sub(n, 2, 2))
	love.graphics.rectangle('fill',display.b.x,display.b.y,s, 3*s, s,s/2,s/2)
	-- C
	love.graphics.setColor(1, 0, 0, string.sub(n, 3, 3))
	love.graphics.rectangle('fill',display.c.x,display.c.y,s, 3*s, s,s/2,s/2)
	-- D
	love.graphics.setColor(1, 0, 0, string.sub(n, 4, 4))
	love.graphics.rectangle('fill',display.d.x,display.d.y,s*3, s, s,s/2,s/2)
	-- E
	love.graphics.setColor(1, 0, 0, string.sub(n, 5, 5))
	love.graphics.rectangle('fill',display.e.x,display.e.y,s, 3*s, s,s/2,s/2)
	-- F
	love.graphics.setColor(1, 0, 0, string.sub(n, 6, 6))
	love.graphics.rectangle('fill',display.f.x,display.f.y,s, 3*s, s,s/2,s/2)
	-- G
	love.graphics.setColor(1, 0, 0, string.sub(n, 7, 7))
	love.graphics.rectangle('fill',display.g.x,display.g.y,s*3, s, s,s/2,s/2)

end
function encoder(n)
	local r = "0000000"
	if n == 0 then
		r = "1111110"
	elseif n == 1 then
		r = "0110000"
	elseif n == 2 then
		r = "1101101"
	elseif n == 3 then
		r = "1111001"
	elseif n == 4 then
		r = "0110011"
	elseif n == 5 then
		r = "1011011"
	elseif n == 6 then
		r = "1011111"
	elseif n == 7 then
		r = "1110000"
	elseif n == 8 then
		r = "1111111"
	elseif n == 9 then
		r = "1111011"
	end
	return r
end
