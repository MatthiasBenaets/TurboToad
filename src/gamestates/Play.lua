local Play = {}

Play.__index = Play

function Play:load()
	local this = {}

	setmetatable(this, self)

	return this
end

function Play:update(dt) end

function Play:draw()
	love.graphics.setColor(1, 1, 1, 1)
	love.graphics.print("Play", 0, 0)
end

return Play
