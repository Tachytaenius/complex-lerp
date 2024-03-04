local a = {r = -1, i = 1}
local b = {r = 2, i = 2}
local l = {r = 1, i = 0}
local lineSamples = 50
local scale = 75
local w, h = love.graphics.getDimensions()

local function addComplex(a, b)
	return {
		r = a.r + b.r,
		i = a.i + b.i
	}
end

local function subtractComplex(a, b)
	return {
		r = a.r - b.r,
		i = a.i - b.i
	}
end

local function multiplyComplex(a, b)
	-- (a+bi)(c+di) =
	-- ac+bci+adi+bdi^2 =
	-- (ac-bd)+i(bc+ad)
	return {
		r = a.r * b.r - a.i * b.i,
		i = a.i * b.r + a.r * b.i
	}
end

local function lerpA(a, b, l)
	-- (1-l)a+lb
	return addComplex(
		multiplyComplex(
			subtractComplex({r = 1, i = 0}, l), -- 1 - l
			a
		),
		multiplyComplex(l, b)
	)
end

local function lerpB(a, b, l)
	-- a+l(b-a)
	return addComplex(
		a,
		multiplyComplex(
			l,
			subtractComplex(b, a)
		)
	)
end

function love.update(dt)
	local mx, my = love.mouse.getPosition()
	local x, y = (mx - w / 2) / scale, -(my - h / 2) / scale
	if love.mouse.isDown(1) then
		a = {r = x, i = y}
	end
	if love.mouse.isDown(2) then
		b = {r = x, i = y}
	end
	if love.mouse.isDown(3) or love.keyboard.isDown("l") then
		l = {r = x, i = y}
	end
end

function love.draw()
	love.graphics.setBlendMode("add")

	love.graphics.translate(w / 2, h / 2)
	love.graphics.scale(1, -1)

	love.graphics.scale(scale)
	love.graphics.setLineWidth(1/scale)

	love.graphics.setPointSize(8)
	love.graphics.setColor(1, 0, 0)
	love.graphics.points(a.r, a.i)
	love.graphics.setColor(0, 1, 0)
	love.graphics.points(b.r, b.i)
	love.graphics.setColor(0, 0, 1)
	love.graphics.points(l.r, l.i)

	love.graphics.setPointSize(5)
	love.graphics.setColor(0.5, 0.5, 0.5)
	love.graphics.points(1, 0) -- 1
	love.graphics.points(0, 1) -- i
	love.graphics.points(-1, 0) -- -1
	love.graphics.points(0, -1) -- -i
	love.graphics.circle("line", 0, 0, 1)
	love.graphics.line(0, -h / 2, 0, h / 2)
	love.graphics.line(-w / 2, 0, w / 2, 0)

	love.graphics.setColor(0.5, 0.5, 0.5)
	local lerp = love.keyboard.isDown("space") and lerpA or lerpB
	love.graphics.setPointSize(10)
	local lerped = lerp(a, b, l)
	love.graphics.points(lerped.r, lerped.i)
	-- This draws a line when the blue dot (l) is on 1
	-- for iter = 0, lineSamples - 1 do
	-- 	local lerped = lerp(a, b, multiplyComplex(l, {r = iter / lineSamples, i = 0}))
	-- 	love.graphics.points(lerped.r, lerped.i)
	-- end
end
