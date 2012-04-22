require "keyControl"

function love.load()
	plane = {}
	plane.x = 20
	plane.y = 20
	plane.speed = 10
	plane.maxSpeed = 15
	plane.dx = 0
	plane.dy = 0
	plane.rotation = 0
	plane.turnRate = 60

	ting = 0
	frames = 0
	fps = 0

	planeImg = love.graphics.newImage("plane1.png")
	planeImg:setFilter("nearest", "nearest")
end

function love.update(dt)
	ting = ting + dt
	frames = frames + 1
	checkKeys(dt)
	if ting >= 1 then
		fps = frames
		frames = 0
		ting = 0
	end
	local a = math.rad(plane.rotation)
	plane.dy = plane.speed*math.sin(a)
	plane.dx = plane.speed*math.cos(a)
	plane.x = plane.x + plane.dx*dt*plane.speed
	plane.y = plane.y + plane.dy*dt*plane.speed

	if plane.x > 1008 then
		plane.x = 16
	elseif plane.x < 16 then
		plane.x = 1008
	end
end

function love.draw()
	love.graphics.draw(planeImg, plane.x, plane.y, math.rad(plane.rotation), 2, 2, 20, 16)
	love.graphics.print("fps: "..fps, 40, 25)
end