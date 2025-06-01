local Player = {}

Player.__index = Player

function Player:load(w, h, offset, ground, key, color)
	local this = {
		x = love.graphics.getWidth() / offset,
		y = love.graphics.getHeight() - ground - h,
		w = w,
		h = h,
		key = key,
		color = color,

		jumping = false,
		velocity = 0,
		gravity = 600,
		jumpHeight = 400,
		ground = ground,

		sprite = love.graphics.newImage("assets/images/player.png"),
		frameWidth = 150,
		frameHeight = 0,
		frameNumbers = 8,
		quads = {},

		animationSpeed = 0.1,
		animationTimer = 0,
		currentFrame = 1,
	}

	this.frameHeight = this.sprite:getHeight()
	this.h = this.frameHeight

	this.x = love.graphics.getWidth() / offset - this.w / 2
	this.y = love.graphics.getHeight() - this.ground - this.h

	for i = 1, this.frameNumbers do
		this.quads[i] = love.graphics.newQuad(
			(i - 1) * this.frameWidth,
			0,
			this.frameWidth,
			this.frameHeight,
			this.sprite:getWidth(),
			this.sprite:getHeight()
		)
	end

	setmetatable(this, self)

	return this
end

function Player:update(dt)
	self.animationTimer = self.animationTimer + dt
	if self.animationTimer >= self.animationSpeed then
		self.animationTimer = self.animationTimer - self.animationSpeed
		self.currentFrame = self.currentFrame + 1
		if self.currentFrame > self.frameNumbers then
			self.currentFrame = 1
		end
	end

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
	love.graphics.setColor(self.color, self.color, self.color, 1)
	if self.jumping then
		self.currentFrame = 4
	end
	love.graphics.draw(self.sprite, self.quads[self.currentFrame], self.x, self.y)
end

function Player:jump()
	if not self.jumping then
		self.jumping = true
		self.velocity = -self.jumpHeight
	end
end

return Player
