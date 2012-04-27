bullet = {
	x = 0,
	y = 0,
	dx = 0,
	dy = 0,
	mode = 0,
	size = 6,
	speed = 30
}

function shoot_bullet(dt)
	if bullet.mode == 0 then
		bullet.x = plane.x
		bullet.y = plane.y
		bullet.dx = plane.dx * bullet.speed * love.timer.getDelta()
		bullet.dy = plane.dy * bullet.speed * love.timer.getDelta()
		bullet.mode = 1
	end
end

function update_bullet()
	if bullet.mode == 1 then
		bullet.x = bullet.x + bullet.dx
		bullet.y = bullet.y + bullet.dy
		if bullet.x > WIDTH or bullet.x < 0 or bullet.y < -50 then
			bullet.mode = 0
		end
		if bullet.y >= ground_stats.y_offset then
			bullet.mode = 0
			ground_pieces[math.floor(bullet.x / ground_stats.width)+1].state = 1
		end
	end
end

function draw_bullet()
	if bullet.mode == 1 then
		love.graphics.circle("fill", bullet.x, bullet.y, bullet.size, 6)
	end
end