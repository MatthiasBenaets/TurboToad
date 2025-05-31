local Play = {}

Play.__index = Play

local ground = {
	class = require("src/world/Ground"),
	instance = {},
}

function Play:load()
	local this = {
		ground = {
			width = 32,
			height = 32,
		},
	}

	ground.instance = ground.class:load(this.ground.width, this.ground.height)

	setmetatable(this, self)

	return this
end

function Play:update(dt) end

function Play:draw()
	love.graphics.setColor(1, 1, 1, 1)
	love.graphics.print("Play", 0, 0)

	ground.instance:draw()
end

return Play
