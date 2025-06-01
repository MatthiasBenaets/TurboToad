local Ground = {}

Ground.__index = Ground

function Ground:load(w, h, color, sprite, speed)
	local this = {
		sprite = love.graphics.newImage(sprite),
		w = w,
		h = h,
		color = color,
		x = 0,
		speed = speed,
	}

	setmetatable(this, self)

	return this
end

function Ground:update(dt)
	self.x = self.x - self.speed * dt
	if self.x <= -self.sprite:getWidth() then
		self.x = self.x + self.sprite:getWidth()
	end
end

function Ground:draw()
	love.graphics.setColor(1, 1, 1, 1)
	local width = self.sprite:getWidth()
	local y = love.graphics.getHeight() - self.h

	local totalTiles = math.ceil(love.graphics.getWidth() / width) + 1
	for i = 0, totalTiles do
		love.graphics.draw(self.sprite, self.x + (i * width), y)
	end
end

return Ground
