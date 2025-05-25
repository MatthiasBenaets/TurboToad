local World = {}

World.__index = World

function World:new(virtualWidth, virtualHeight)
	local this = {
		groundHeight = virtualHeight * 0.8,
		player = {},
		background = {},
	}

	setmetatable(this, self)

	return this
end

function World:update(dt) end

function World:draw() end

return World
