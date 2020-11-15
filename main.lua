debug = true
local player = require('player')
local bullet = require('bullet')
local enemy = require('enemy')
local item = require('item')

isAlive = true
score = 0

function love.load(arg)
	player.load()
	bullet.load()
	enemy.load()
	item.load()
end

function love.update(dt)
	--- Timers
	bullet.checkTimer(dt)
	enemy.checkTimer(dt)
	item.checkTimer(dt)

	--- Keyboard
	if love.keyboard.isDown('escape') then
		love.event.push('quit')
	elseif love.keyboard.isDown('left', 'a') then
		if player.x > 0 then
			player.x = player.x - (player.speed * dt)
		end
	elseif love.keyboard.isDown('right', 'd') then
		if player.x < (love.graphics.getWidth() - player.img:getWidth()) then
			player.x = player.x + (player.speed * dt)
		end
	elseif love.keyboard.isDown('up', 'w') then
		if player.y > 0 then
			player.y = player.y - (player.speed * dt)
		end
	elseif love.keyboard.isDown('down', 's') then
		if player.x < (love.graphics.getHeight() - player.img:getHeight()) then
			player.y = player.y + (player.speed * dt)
		end
	end

	if bullet.canShoot and love.keyboard.isDown('space', 'rctrl', 'lctrl') then
		bullet.fire(player)
	end

	if not isAlive and love.keyboard.isDown('r') then
		bullets = {}
		enemies = {}

		canShootTimer = canShootTimerMax
		createEnemyTimer = createEnemyTimerMax

		player.x = 50
		player.y = 710

		score = 0
		isAlive = true
	end

	bullet.move(dt)
	if isAlive then
		enemy.collision(dt, player )
	end
	enemy.move(dt)
	
	if isAlive then
		if item.collision(dt, player) then
			bullet.setRocketMode()
		end
	end
	item.move(dt)
end

function love.draw(dt)
	bullet.draw(dt)
	enemy.draw(dt)
	item.draw(dt)

	if isAlive then
		player.draw()
	else
		love.graphics.print("Press 'R' to restart", love.graphics:getWidth() / 2 - 50, love.graphics.getHeight() / 2 - 10)
	end

	love.graphics.print("Score :" .. score, love.graphics:getWidth() / 2 - 20, 100)
end


