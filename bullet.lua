local Bullet = {
	canShoot = true,
	image = nil,
	rocketImg = nil,
	timerMax = 0.2,
	timer = 0,
	sound = love.audio.newSource('assets/gun-sound.wav', 'static'),
	rocketMode = false,
	rocketTimerMax = 1,
	rocketTimer = 0
}
bullets = {}

function Bullet.load()
	Bullet.image = love.graphics.newImage('assets/bullet.png')
	Bullet.rocketImg = love.graphics.newImage('assets/rocket.png')
end

function Bullet.setRocketMode()
	Bullet.rocketMode = true
	Bullet.rocketTimer = Bullet.rocketTimerMax
end

function Bullet.checkTimer(dt)
	Bullet.timer = Bullet.timer - dt
	if Bullet.timer < 0 then
		Bullet.canShoot = true
	end

	Bullet.rocketTimer = Bullet.rocketTimer - dt
	if Bullet.rocketTimer < 0 then
		Bullet.rocketMode = false
	end
end

function Bullet.move(dt)
	for i, bullet in ipairs(bullets) do
		bullet.y = bullet.y - (250 * dt)

		if bullet.y < 0 then
			table.remove(bullets, i)
		end
	end
end

function Bullet.fire(player)
	img = Bullet.rocketMode and Bullet.rocketImg or Bullet.image
	newBullet = {
					x = player.x + (player.img:getWidth()/2) - 5,
					y = player.y,
					img = img,
					isRocket = Bullet.rocketMode
				}
	table.insert(bullets, newBullet)
	Bullet.timer = Bullet.timerMax
	Bullet.canShoot = false
	Bullet.sound:play()
end

function Bullet.draw(dt)
	for i, bullet in ipairs(bullets) do
		love.graphics.draw(bullet.img, bullet.x, bullet.y)
	end
end

return Bullet