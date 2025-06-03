local menu = {}

menu.__index = menu

local Button = require("src/components/button")

function menu:load(setGame)
	local this = {
		state = "main",
		background = love.graphics.newImage("assets/images/menu.png"),
		players = 1,
		maxplayers = 2,
		buttons = {},
		width = love.graphics.getWidth(),
		height = love.graphics.getHeight(),
	}

	this.buttons = {
		{
			obj = Button:load(
				"play",
				this.width * 0.5 - love.graphics.getFont():getWidth("play"),
				this.height * 0.8,
				100,
				50,
				function()
					this.state = "select"
				end
			),
			visible = "main",
		},
		{
			obj = Button:load(
				"-",
				this.width * 0.3 - love.graphics.getFont():getWidth("-"),
				this.height * 0.8,
				100,
				50,
				function()
					if this.players > 1 then
						this.players = this.players - 1
					end
				end
			),
			visible = "select",
		},
		{
			obj = Button:load(
				"+",
				this.width * 0.7 - love.graphics.getFont():getWidth("+") - 50,
				this.height * 0.8,
				100,
				50,
				function()
					if this.players < this.maxplayers then
						this.players = this.players + 1
					end
				end
			),
			visible = "select",
		},
		{
			obj = Button:load(
				"start",
				this.width * 0.5 - love.graphics.getFont():getWidth("start"),
				this.height * 0.8,
				100,
				50,
				function()
					setGame("play", this.players)
				end
			),
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
	love.graphics.draw(self.background, 0, 0)

	love.graphics.setColor(0.92, 0.51, 0.14, 1)
	if self.state == "select" then
		love.graphics.print(
			"players: " .. self.players,
			self.width * 0.5 - love.graphics.getFont():getWidth("start") + 25,
			self.height * 0.9
		)
	end

	love.graphics.setColor(1, 1, 1, 1)
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
