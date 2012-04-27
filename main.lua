require "constants"
require "keyControl"
require "plane"
require "ground"
require "bullet"

function love.load()
	plane = plane_class:new(20, 20)
	plane2 = plane_class:new(20, 100)
end

function love.update(dt)
	checkKeys(dt)
	if plane.state ~= CRASHED then
		plane:update(dt)
	end
	if plane2.state ~= CRASHED then 
		plane2:update(dt)
	end
	
	update_bullet()
end

function love.draw()
	plane:draw()
	plane2:draw()
	
	draw_ground()
	love.graphics.print("DogFight2 - v.0.2.2", 40, 25)
	love.graphics.print("by tvh33", 40, 40)
	love.graphics.print("fps: "..love.timer.getFPS(), 40, 60)
	draw_bullet()
end
