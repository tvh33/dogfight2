function love.keypressed(key)
end

function checkKeys(dt)
	if love.keyboard.isDown("up") then
		
		if plane.speed < plane.maxSpeed then
			plane.speed = plane.speed + 10*dt			
		end
	elseif love.keyboard.isDown("down") then
		plane.speed = plane.speed-8*dt
		if plane.speed < 4 then		
			plane.speed = 4
		end
	end
	if love.keyboard.isDown("right") then
		plane.rotation = plane.rotation + plane.turnRate*plane.speed*dt
	elseif love.keyboard.isDown("left") then
		plane.rotation = plane.rotation - plane.turnRate*plane.speed*dt
	end
	if love.keyboard.isDown("escape") then
		os.exit()
	end
end

function love.keypressed(key)
	if key == " " then
		bullet.x = plane.x
		bullet.y = plane.y
		bullet.dx = plane.dx / plane.speed * 5
		bullet.dy = plane.dy / plane.speed * 5
		bullet.mode = 1
	end
end
