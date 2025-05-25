local Menu = {}

Menu.__index = Menu

function Menu:new()
	local this = {
		splash = love.graphics.newImage("assets/menu.png"),
	}

	setmetatable(this, self)

	return this
end

function Menu:draw()
	love.graphics.draw(self.splash, 0, 0)
end

return Menu
