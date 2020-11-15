local player = { x = 200, y = 710, speed = 150, img = nil }

function player.load()
	player.img = love.graphics.newImage('assets/plane.png')
end

function player.draw(dt) 
	love.graphics.draw(player.img, player.x, player.y)
 end

return player