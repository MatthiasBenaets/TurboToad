local Play = {}

Play.__index = Play

local ground = {
	class = require("src/world/Ground"),
	instance = {},
}

local player = {
	class = require("src/entities/Player"),
	instance = {},
}

function Play:load()
	local this = {
		ground = {
			width = 32,
			height = 32,
		},
		player = {
			width = 32,
			height = 32,
			offset = 10,
		},
	}

	ground.instance = ground.class:load(this.ground.width, this.ground.height)
	player.instance = player.class:load(this.player.width, this.player.height, this.player.offset, this.ground.height)

	setmetatable(this, self)

	return this
end

function Play:update(dt)
	player.instance:update(dt)
end

function Play:draw()
	love.graphics.setColor(1, 1, 1, 1)
	love.graphics.print("Play", 0, 0)

	ground.instance:draw()
	player.instance:draw()
end

function Play:keypressed(key)
	if key == "space" then
		player.instance:jump()
	end
end

return Play
