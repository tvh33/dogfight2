require "keyControl"

function love.load()
	plane = {
		x = 20,
		y = 20,
		speed = 10,
		maxSpeed = 12,
		dx = 0,
		dy = 0,
		rotation = 0,
		turnRate = 6
	}
	
	bullet = {
		x = 0,
		y = 0,
		dx = 0,
		dy = 0,
		mode = 0
	}

	gravity = 0
	friction = 0.997
	lift = 1.005

	ting = 0
	frames = 0
	fps = 0

	planeImg = love.graphics.newImage("plane1.png")
	planeImg:setFilter("nearest", "nearest")
end

function love.update(dt)
	ting = ting + dt
	frames = frames + 1
	
	if ting >= 1 then
		fps = frames
		frames = 0
		ting = 0
	end
	if plane.dy > 0 then
		plane.speed = plane.speed + plane.dy*0.7*dt
	else
		plane.speed = plane.speed + plane.dy*0.7*dt
	end
	if plane.speed > 16 then
		plane.speed = 16
	end
	if love.keyboard.isDown("up") then
	else
		if plane.speed > 0 then
			plane.speed = plane.speed * friction
		end
		
	end
	if plane.speed < 7 or plane.y < -50 then
		local a = plane.rotation % 360
		if plane.dx > 0 and plane.dy >= 0 then
			if a < 90 then
				if a+(500*dt) < 90 then
					plane.rotation = plane.rotation + 500*dt
					plane.speed = 6.8
				else
					plane.rotation = 90
				end
			end
		else
			if a > 90 then
				if a-(500*dt) > 90 then
					plane.rotation = plane.rotation - 500*dt
					plane.speed = 6.8
				else
					plane.rotation = 90
				end
			end
		end
	end
	checkKeys(dt)
	flag = 0
	local a = math.rad(plane.rotation)
	plane.dy = plane.speed*math.sin(a)
	plane.dx = plane.speed*math.cos(a)

	plane.x = plane.x + plane.dx*dt*plane.speed
	plane.y = plane.y + plane.dy*dt*plane.speed + gravity*dt
	wrapPlane(plane)
	
	if bullet.mode == 1 then
		bullet.x = bullet.x + bullet.dx
		bullet.y = bullet.y + bullet.dy
		if bullet.x > 1024 or bullet.x < 0 then
			bullet.mode = 0
		end
	end
	
end

function wrapPlane(target)
	if target.x > 1024+16 then
		target.x = -16
	elseif target.x < -16 then
		target.x = 1024+16
	end
end

function love.draw()
	love.graphics.draw(planeImg, plane.x, plane.y, math.rad(plane.rotation), 1, 1, 20, 16)
	love.graphics.print("fps: "..fps, 40, 25)
	love.graphics.print("rotation: "..plane.rotation % 360, 40, 40)
	love.graphics.print("speed: "..plane.speed % 360, 40, 55)
	--love.graphics.line(plane.x+32, plane.y, plane.x+32+plane.dx, plane.y+plane.dy)
	if bullet.mode == 1 then
		love.graphics.point(bullet.x, bullet.y)
	end
end
