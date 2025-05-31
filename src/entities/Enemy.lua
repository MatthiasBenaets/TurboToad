local Enemy = {}

Enemy.__index = Enemy

function Enemy:load(x, y, w, h, speed)
	local this = {
		x = x,
		y = y,
		w = w,
		h = h,
		speed = speed,
	}

	setmetatable(this, self)

	return this
end

function Enemy:update(dt)
	self.x = self.x - self.speed * dt
end

function Enemy:draw()
	love.graphics.setColor(0, 0, 1, 1)
	love.graphics.rectangle("fill", self.x, self.y, self.w, self.h)
end

return Enemy
