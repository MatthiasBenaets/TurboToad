local World = {}

World.__index = World

local Player = {
	load = require("lib.player"),
	active = function() end,
}

function World:new(virtualWidth, virtualHeight)
	local this = {
		groundHeight = virtualHeight * 0.8,
		player = {},
		background = {},
	}

	Player.active = Player.load:new(virtualWidth, virtualHeight, this.groundHeight)

	setmetatable(this, self)

	return this
end

function World:update(dt)
	Player.active:update(dt)
end

function World:draw()
	Player.active:draw()
end

return World
