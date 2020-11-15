local Item = {
	image = nil,
	timerMax = 9.0,
	timer = 5,
}
items = {}

function CheckCollision(a, b)
	return a.x < b.x + b.img:getWidth() and b.x < a.x + a.img:getWidth()
		and a.y < b.y + b.img:getHeight() and b.y < a.y + a.img:getHeight()
end

function Item.load()
	Item.image = love.graphics.newImage('assets/item.png')
end

function Item.checkTimer(dt)
	Item.timer = Item.timer - dt
	if Item.timer < 0 then
		Item.timer = Item.timerMax

		randomNum = math.random(10, love.graphics.getWidth() - Item.image:getWidth() - 10)
		newItem = {x = randomNum, y = -10, img = Item.image}
		table.insert(items, newItem)
	end
end

function Item.collision(dt, player)
	for i, Item in ipairs(items) do
		if CheckCollision(Item, player) then
			table.remove(items, i)
			return true
		end
	end
	return false
end
			
function Item.move(dt)
	for i, Item in ipairs(items) do
		Item.y = Item.y + (200 * dt)

		if Item.y > 850 then
			table.remove(items, i)
		end
	end
end

function Item.draw(dt)
	for i, Item in ipairs(items) do
		love.graphics.draw(Item.img, Item.x, Item.y)
	end
end

return Item