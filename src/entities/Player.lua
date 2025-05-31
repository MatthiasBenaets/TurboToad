local Player = {}

Player.__index = Player

function Player:load(w, h, offset, ground)
	local this = {
		x = love.graphics.getWidth() / offset,
		y = love.graphics.getHeight() - ground - h,
		w = w,
		h = h,

		jumping = false,
		velocity = 0,
		gravity = 600,
		jumpHeight = 400,
		ground = ground,
	}

	setmetatable(this, self)

	return this
end

function Player:update(dt)
	if self.jumping then
		self.velocity = self.velocity + self.gravity * dt
		self.y = self.y + self.velocity * dt
		local groundY = love.graphics.getHeight() - self.ground

		if self.y + self.h >= groundY then
			self.y = groundY - self.h
			self.velocity = 0
			self.jumping = false
		end
	end
end

function Player:draw()
	love.graphics.setColor(1, 0, 0, 1)
	love.graphics.rectangle("fill", self.x, self.y, self.w, self.h)
end

function Player:jump()
	if not self.jumping then
		self.jumping = true
		self.velocity = -self.jumpHeight
	end
end

return Player
