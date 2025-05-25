local Ground = {}

Ground.__index = Ground

function Ground:new(virtualWidth, virtualHeight, sprite, speed)
	local this = {
		bg = love.graphics.newImage(sprite),
		virtualWidth = virtualWidth,
		virtualHeight = virtualHeight,

		bgScrollX = 0,
		bgScrollSpeed = speed,
	}

	setmetatable(this, self)

	return this
end

function Ground:update(dt)
	self.bgScrollX = self.bgScrollX - self.bgScrollSpeed * dt
	if self.bgScrollX <= -self.bg:getWidth() then
		self.bgScrollX = self.bgScrollX + self.bg:getWidth()
	end
end

function Ground:draw()
	local groundWidth = self.bg:getWidth()
	local groundHeight = self.bg:getHeight()
	local yPosition = self.virtualHeight - groundHeight

	local numGroundTiles = math.ceil(self.virtualWidth / groundWidth) + 1

	for i = 0, numGroundTiles do
		love.graphics.draw(self.bg, self.bgScrollX + (i * groundWidth), yPosition)
	end
end

return Ground
