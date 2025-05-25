local Button = {}

Button.__index = Button

local Push = require("lib.push")

function Button:new(x, y, width, height, text, callback)
	local this = {
		x = x,
		y = y,
		width = width,
		height = height,
		text = text,
		callback = callback,
		hover = false,
	}

	setmetatable(this, self)

	return this
end

function Button:update(dt)
	local mouseX, mouseY = love.mouse.getPosition()
	local virtualMouseX, virtualMouseY = Push:toGame(mouseX, mouseY)

	if virtualMouseX and virtualMouseY then
		self.hover = (
			virtualMouseX >= self.x
			and virtualMouseX <= self.x + self.width
			and virtualMouseY >= self.y
			and virtualMouseY <= self.y + self.height
		)
	else
		self.hover = false
	end
end

function Button:draw()
	local r, g, b, a = love.graphics.getColor()

	if self.hover then
		love.graphics.setColor(0.05, 0.17, 0.22, 1)
	else
		love.graphics.setColor(0.10, 0.26, 0.34, 1)
	end
	love.graphics.rectangle("fill", self.x, self.y, self.width, self.height)

	love.graphics.setColor(0.92, 0.51, 0.14, 1)
	love.graphics.setLineWidth(4)
	love.graphics.rectangle("line", self.x, self.y, self.width, self.height)

	love.graphics.setColor(0.92, 0.51, 0.14, 1)
	local textHeight = love.graphics.getFont():getHeight(self.text)
	love.graphics.printf(self.text, self.x, self.y + (self.height - textHeight) / 2, self.width, "center")

	love.graphics.setColor(r, g, b, a)
end

function Button:mousepressed(x, y, button, istouch)
	if button == 1 and self.hover and self.callback then -- Left click and hovered
		self.callback()
		return true
	end
	return false
end

return Button
