local Enemy = {}

Enemy.__index = Enemy

function Enemy:load(x, y, w, h, speed, color)
	local this = {
		x = x,
		y = y,
		w = w,
		h = h,
		speed = speed,
		color = color,
		drawScale = love.math.random(100, 200) / 100,

		sprite = love.graphics.newImage("assets/images/enemy.png"),
		frameWidth = 30,
		frameHeight = 0,
		frameNumbers = 7,
		quads = {},

		animationSpeed = 0.1,
		animationTimer = 0,
		currentFrame = 1,
	}

	this.frameHeight = this.sprite:getHeight()
	this.h = this.frameHeight

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

function Enemy:update(dt)
	self.animationTimer = self.animationTimer + dt
	if self.animationTimer >= self.animationSpeed then
		self.animationTimer = self.animationTimer - self.animationSpeed
		self.currentFrame = self.currentFrame + 1
		if self.currentFrame > self.frameNumbers then
			self.currentFrame = 1
		end
	end

	self.x = self.x - self.speed * dt
end

function Enemy:draw()
	love.graphics.setColor(self.color, self.color, self.color, 1)

	local scaledHeight = self.frameHeight * self.drawScale
	local yOffset = scaledHeight - self.frameHeight

	love.graphics.draw(
		self.sprite,
		self.quads[self.currentFrame],
		self.x,
		self.y - yOffset,
		0,
		self.drawScale,
		self.drawScale
	)
end

return Enemy
