local Player = {}

Player.__index = Player

function Player:new(worldWidth, worldHeight, groundHeight)
	local this = {
		spriteSheet = love.graphics.newImage("assets/toad.png"),
		frameWidth = 150,
		frameHeight = 0,
		numFrames = 8,
		quads = {},

		animationSpeed = 0.1,
		animationTimer = 0,
		currentFrame = 1,

		width = 120,
		height = 0,
		x = 0,
		y = 0,
		marginLeft = 0.2,

		isJumping = false,
		velocityY = 0,
		gravity = 800,
		jumpStrength = -400,
		groundY = groundHeight,
	}

	this.frameHeight = this.spriteSheet:getHeight()
	this.height = this.frameHeight

	this.x = worldWidth * this.marginLeft - this.width
	this.y = this.groundY - this.height

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

function Player:update(dt)
	self.animationTimer = self.animationTimer + dt
	if self.animationTimer >= self.animationSpeed then
		self.animationTimer = self.animationTimer - self.animationSpeed
		self.currentFrame = self.currentFrame + 1
		if self.currentFrame > self.numFrames then
			self.currentFrame = 1
		end
	end

	if self.isJumping then
		self.velocityY = self.velocityY + self.gravity * dt
		self.y = self.y + self.velocityY * dt

		if self.y + self.height >= self.groundY then
			self.y = self.groundY - self.height
			self.isJumping = false
			self.velocityY = 0
		end
	end
end

function Player:draw()
	if self.isJumping then
		self.currentFrame = 4
	end
	love.graphics.draw(self.spriteSheet, self.quads[self.currentFrame], self.x, self.y)
end

function Player:jump()
	if not self.isJumping then
		self.isJumping = true
		self.velocityY = self.jumpStrength
	end
end

return Player
