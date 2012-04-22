function love.keypressed(key)
end

function checkKeys(dt)
	if love.keyboard.isDown("up") then
		if plane.speed < plane.maxSpeed then
			plane.speed = plane.speed + 10*dt
		end
	elseif love.keyboard.isDown("down") then
		if plane.speed > 0 then		
			plane.speed = plane.speed - 10*dt
		end
	end
	if love.keyboard.isDown("right") then
		plane.rotation = plane.rotation + plane.turnRate*dt
	elseif love.keyboard.isDown("left") then
		plane.rotation = plane.rotation - plane.turnRate*dt
	end
end

