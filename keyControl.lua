function checkKeys(dt)
	if love.keyboard.isDown("up") then
		if plane.speed < plane.max_speed then
			plane.speed = plane.speed + 10*dt			
		end
	elseif love.keyboard.isDown("down") then
		
		if plane.state == FLYING then
			plane.speed = plane.speed-8*dt
			if plane.speed < 4 then		
				plane.speed = 4
			end
		elseif plane.state == DRIVING then
			plane.speed = plane.speed-8*dt
			if plane.speed < 2.5 then
				plane.speed = 0
				plane.state = IDLE
			end
		end
	end
	if love.keyboard.isDown("right") then
		if plane.state == FLYING then
			plane.rotation = plane.rotation + plane.turn_rate*plane.speed*dt
		end
	elseif love.keyboard.isDown("left") then
		if plane.state == FLYING then
			plane.rotation = plane.rotation - plane.turn_rate*plane.speed*dt
		elseif plane.state == DRIVING then
			if plane.speed > 11 then
				plane.rotation = plane.rotation - plane.turn_rate*plane.speed*dt
				plane.state = FLYING
			end
		end
	end
	if love.keyboard.isDown("escape") then
		os.exit()
	end
end

function love.keypressed(key)
	if key == " " then
		shoot_bullet()
	end
end
