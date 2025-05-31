local Player = {}

Player.__index = Player

function Player:load(w, h, offset, ground)
	local this = {
		x = love.graphics.getWidth() / offset,
		y = love.graphics.getHeight() - ground - h,
		w = w,
		h = h,
	}

	setmetatable(this, self)

	return this
end

function Player:update(dt) end

function Player:draw()
	love.graphics.setColor(1, 0, 0, 1)
	love.graphics.rectangle("fill", self.x, self.y, self.w, self.h)
end

return Player
