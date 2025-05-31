local Menu = {}

Menu.__index = Menu

function Menu:load()
	local this = {}

	setmetatable(this, self)

	return this
end

function Menu:update(dt) end

function Menu:draw()
	love.graphics.setColor(1, 1, 1, 1)
	love.graphics.print("Menu", 0, 0)
end

return Menu
