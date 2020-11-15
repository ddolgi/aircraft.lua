local Enemy = {
	image = nil,
	timerMax = 0.4,
	timer = 0,
}
enemies = {}

function CheckCollision(a, b)
	return a.x < b.x + b.img:getWidth() and b.x < a.x + a.img:getWidth()
		and a.y < b.y + b.img:getHeight() and b.y < a.y + a.img:getHeight()
end

function Enemy.load()
	Enemy.image = love.graphics.newImage('assets/enemy.png')
end

function Enemy.checkTimer(dt)
	Enemy.timer = Enemy.timer - dt
	if Enemy.timer < 0 then
		Enemy.timer = Enemy.timerMax

		randomNum = math.random(10, love.graphics.getWidth() - Enemy.image:getWidth() - 10)
		newEnemy = {x = randomNum, y = -10, img = Enemy.image}
		table.insert(enemies, newEnemy)
	end
end

function Enemy.collision(dt, player)--- Enemy
	for i, enemy in ipairs(enemies) do
		for j, bullet in ipairs(bullets) do
			if CheckCollision(enemy, bullet) then
				if not bullet.isRocket then
					table.remove(bullets, j)
				end
				table.remove(enemies, i)
				score = score + 1
			end
		end

		if isAlive then
			if CheckCollision(enemy, player) then
				table.remove(enemies, i)
				isAlive = false
			end
		end
	end
end
			
function Enemy.move(dt)
	for i, enemy in ipairs(enemies) do
		enemy.y = enemy.y + (200 * dt)

		if enemy.y > 850 then
			table.remove(enemies, i)
		end
	end
end

function Enemy.draw(dt)
	for i, enemy in ipairs(enemies) do
		love.graphics.draw(enemy.img, enemy.x, enemy.y)
	end
end

return Enemy