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
	}

	this.frameHeight = this.spriteSheet:getHeight()
	this.height = this.frameHeight

	this.x = worldWidth * this.marginLeft - this.width
	this.y = groundHeight - this.height

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
end

function Player:draw()
	love.graphics.draw(self.spriteSheet, self.quads[self.currentFrame], self.x, self.y)
end

return Player
