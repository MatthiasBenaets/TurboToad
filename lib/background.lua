local Background = {}

Background.__index = Background

function Background:new(sprite, speed)
	local this = {
		bg = love.graphics.newImage(sprite),

		bgScrollX = 0,
		bgScrollSpeed = speed,
	}

	this.bgWidth = this.bg:getWidth()

	setmetatable(this, self)

	return this
end

function Background:update(dt)
	self.bgScrollX = self.bgScrollX - self.bgScrollSpeed * dt
	if self.bgScrollX <= -self.bgWidth then
		self.bgScrollX = 0
	end
end

function Background:draw()
	love.graphics.draw(self.bg, self.bgScrollX, 0)
	love.graphics.draw(self.bg, self.bgScrollX + self.bgWidth, 0)
end

return Background
