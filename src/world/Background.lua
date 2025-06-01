local Background = {}

Background.__index = Background

function Background:new(sprite, speed)
	local this = {
		bg = love.graphics.newImage(sprite),
		x = 0,
		speed = speed,
	}

	this.w = this.bg:getWidth()

	setmetatable(this, self)

	return this
end

function Background:update(dt)
	self.x = self.x - self.speed * dt
	if self.x <= -self.w then
		self.x = 0
	end
end

function Background:draw()
	love.graphics.setColor(1, 1, 1, 1)
	love.graphics.draw(self.bg, self.x, 0)
	love.graphics.draw(self.bg, self.x + self.w, 0)
end

return Background
