local Enemy = {}

Enemy.__index = Enemy

function Enemy:new(worldWidth, worldHeight, groundHeight, scrollSpeed)
	local this = {
		spriteSheet = love.graphics.newImage("assets/enemy-1.png"),
		frameWidth = 30,
		frameHeight = 0,
		numFrames = 7,
		quads = {},

		animationSpeed = 0.1,
		animationTimer = 0,
		currentFrame = 1,

		width = 30,
		height = 0,
		x = 0,
		y = 0,

		scrollSpeed = scrollSpeed,

		drawScale = love.math.random(100, 200) / 100,
	}

	this.frameHeight = this.spriteSheet:getHeight()
	this.height = this.frameHeight

	this.x = worldWidth
	this.y = groundHeight - (this.height * this.drawScale)

	for i = 1, this.numFrames do
		this.quads[i] = love.graphics.newQuad(
			(i - 1) * this.frameWidth,
			0,
			this.frameWidth,
			this.frameHeight,
			this.spriteSheet:getWidth(),
			this.spriteSheet:getHeight()
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
		if self.currentFrame > self.numFrames then
			self.currentFrame = 1
		end
	end

	self.x = self.x - self.scrollSpeed * dt
end

function Enemy:draw()
	love.graphics.draw(
		self.spriteSheet,
		self.quads[self.currentFrame],
		self.x,
		self.y,
		0,
		self.drawScale,
		self.drawScale
	)
end

return Enemy
