local Menu = {}

Menu.__index = Menu

local Button = require("lib.button")

function Menu:new(virtualWidth, virtualHeight, setState)
	local this = {
		state = setState,
		splash = love.graphics.newImage("assets/menu.png"),
		buttons = {},
	}

	local startButton = Button:new(virtualWidth / 2 - 100, virtualHeight / 2 + 50, 200, 50, "Start Game", function()
		if this.state then
			this.state("game")
		end
	end)
	table.insert(this.buttons, startButton)

	setmetatable(this, self)

	return this
end

function Menu:update(dt)
	for _, button in ipairs(self.buttons) do
		button:update(dt)
	end
end

function Menu:draw()
	love.graphics.draw(self.splash, 0, 0)
	for _, button in ipairs(self.buttons) do
		button:draw()
	end
end

function Menu:mousepressed(x, y, button, istouch)
	for _, btn in ipairs(self.buttons) do
		if btn:mousepressed(x, y, button, istouch) then
			return true
		end
	end
	return false
end

return Menu
