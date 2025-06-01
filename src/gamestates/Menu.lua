local menu = {}

menu.__index = menu

local Button = require("src/components/button")

function menu:load(setGame)
	local this = {
		state = "main",
		players = 1,
		maxplayers = 2,
		buttons = {},
	}

	this.buttons = {
		{
			obj = Button:load("play", 0, 50, 100, 50, function()
				this.state = "select"
			end),
			visible = "main",
		},
		{
			obj = Button:load("-", 0, 50, 100, 50, function()
				if this.players > 1 then
					this.players = this.players - 1
				end
			end),
			visible = "select",
		},
		{
			obj = Button:load("+", 300, 50, 100, 50, function()
				if this.players < this.maxplayers then
					this.players = this.players + 1
				end
			end),
			visible = "select",
		},
		{
			obj = Button:load("start", 150, 100, 100, 50, function()
				setGame("play", this.players)
			end),
			visible = "select",
		},
	}

	setmetatable(this, self)

	return this
end

function menu:update(dt)
	for _, btn in ipairs(self.buttons) do
		if btn.visible == self.state then
			btn.obj:update(dt)
		end
	end
end

function menu:draw()
	love.graphics.setColor(1, 1, 1, 1)

	if self.state == "main" then
		love.graphics.print("main", 0, 0)
	elseif self.state == "select" then
		love.graphics.print("select", 0, 0)
		love.graphics.print("players: " .. self.players, 150, 50)
	end

	for _, btn in ipairs(self.buttons) do
		if btn.visible == self.state then
			btn.obj:draw()
		end
	end
end

function menu:mousepressed(x, y, button)
	for _, btn in ipairs(self.buttons) do
		if btn.visible == self.state then
			btn.obj:mousepressed(x, y, button)
		end
	end
end

return menu
