ground_stats = {
	amount = 15,
	height = 10,
	width = love.graphics.getWidth()/15,
	y_offset = love.graphics.getHeight()-10
}
ground_pieces = {}
for i=1,ground_stats.amount,1 do
	local tmp = {state = 0, gtype = 0}
	ground_pieces[i] = tmp
end

function draw_ground()
	for i=1,ground_stats.amount,1 do
		if ground_pieces[i].state == 0 then
			love.graphics.rectangle("line", (i-1)*ground_stats.width, ground_stats.y_offset, ground_stats.width, ground_stats.height)
		end
	end
end