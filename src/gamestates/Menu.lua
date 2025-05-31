local Menu = {}

Menu.__index = Menu

local Button = require("src/components/Button")

function Menu:load(setState)
	local this = {
		buttons = {
			Button:load("Play", 0, 50, 100, 50, function()
				setState("play")
			end),
		},
	}

	setmetatable(this, self)

	return this
end

function Menu:update(dt)
	for _, btn in ipairs(self.buttons) do
		btn:update(dt)
	end
end

function Menu:draw()
	love.graphics.setColor(1, 1, 1, 1)
	love.graphics.print("Menu", 0, 0)

	for _, btn in ipairs(self.buttons) do
		btn:draw()
	end
end

function Menu:mousepressed(x, y, button)
	for _, btn in ipairs(self.buttons) do
		btn:mousepressed(x, y, button)
	end
end

return Menu
