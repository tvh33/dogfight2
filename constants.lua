FRICTION = 0.997
WIDTH = love.graphics.getWidth()
HEIGHT = love.graphics.getHeight()

LANDING_HEIGHT = HEIGHT - 25
LANDING_ANGLE = 14

FLYING = 0
DRIVING = 1
IDLE = 2
CRASHED = 3

function get_state(target)
	if target.state == 0 then return "flying" end
	if target.state == 1 then return "driving" end
	if target.state == 2 then return "stopped" end
	if target.state == 3 then return "crashed" end
end