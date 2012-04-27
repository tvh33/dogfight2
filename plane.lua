require("AnAL")

plane_img = love.graphics.newImage("plane1.png")
plane_img:setFilter("nearest", "nearest")

plane_class = {
	x = 20,
	y = 20,
	dx = 0,
	dy = 0,
	speed = 10,
	max_speed = 15,
	rotation = 0,
	turn_rate = 4,
	state = FLYING
}

plane_class_mt = {__index = plane_class}

function plane_class:new(xpos, ypos)
	return setmetatable({x=xpos, y=ypos}, plane_class_mt)
end

function plane_class:draw()
	love.graphics.draw(plane_img, self.x, self.y, math.rad(self.rotation), 1, 1, 20, 16)
	love.graphics.print(""..get_state(self), self.x+40, self.y-40)
	love.graphics.print(""..math.floor(self.rotation%360).."°", self.x+40, self.y-25)
	love.graphics.print(""..math.floor(self.speed).."px/s", self.x+40, self.y-10)
end

function plane_class:update(dt)
	if self.state == FLYING then
		self.speed = self.speed + self.dy*0.7*dt
		-- enforce maximum speed
		if self.speed > 16 then
			self.speed = 16
		end
		
		if self.y > LANDING_HEIGHT then
			if self.rotation % 360 <= LANDING_ANGLE then
				self.y = LANDING_HEIGHT
				self.state = DRIVING
				self.rotation = 0
				return
			end
		end
		
		if self.y > ground_stats.y_offset then
			self.state = CRASHED
			return
		end
		
		if love.keyboard.isDown("up") then
		else --slow down if UP-key is not pressed
			if self.speed > 0 then
				self.speed = self.speed*FRICTION
			end
		end
		-- face downwards if speed too slow
		if self.speed < 7 or self.y < -50 then
			local angle = (self.rotation - 90) % 360
			if angle < 180 then
				if angle-(500*dt) > 0 then
					self.rotation = self.rotation - 500*dt
					self.speed = 6.9
				else
					self. rotation = 90
				end
			else
				if angle+(500*dt) > 180 then
					self.rotation = self.rotation + 500*dt
					self.speed = 6.9
				else
					self. rotation = 90
				end
			end
		end
		--checkKeys(dt) --problem <---
		
	elseif self.state == DRIVING then
		if love.keyboard.isDown("up") then
		else --slow down if UP-key is not pressed
			if self.speed > 0 then
				self.speed = self.speed*FRICTION
			end
		end
		if ground_pieces[math.floor((self.x-40) % WIDTH / ground_stats.width)+1].state == 1 then
			self.state = CRASHED
			return
		end
	elseif self.state == IDLE then
		if self.speed > 0 then
			self.state = DRIVING
		end
	end
	-- calculate dx and dy
	local angle = math.rad(self.rotation)
	self.dy = self.speed*math.sin(angle)
	self.dx = self.speed*math.cos(angle)
	-- update x and y values
	self.x = self.x + self.dx*dt*self.speed
	self.y = self.y + self.dy*dt*self.speed
	-- wrap sides
	if self.x > WIDTH+16 then
		self.x = -16
	elseif self.x < -16 then
		self.x = WIDTH+16
	end
end