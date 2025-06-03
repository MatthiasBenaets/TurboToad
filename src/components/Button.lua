local Button = {}

Button.__index = Button

function Button:load(text, x, y, w, h, callback)
	local this = {
		text = text,
		x = x,
		y = y,
		w = w,
		h = h,
		hover = false,
		callback = callback,
	}

	setmetatable(this, self)

	return this
end

function Button:update(dt)
	local mouseX, mouseY = love.mouse.getPosition()

	if mouseX and mouseY then
		self.hover = (mouseX >= self.x and mouseX <= self.x + self.w and mouseY >= self.y and mouseY <= self.y + self.h)
	else
		self.hover = false
	end
end

function Button:draw()
	local textWidth = love.graphics.getFont():getWidth(self.text)
	local textHeight = love.graphics.getFont():getHeight()
	if self.hover then
		love.graphics.setColor(0.05, 0.17, 0.22, 1)
	else
		love.graphics.setColor(0.10, 0.26, 0.34, 1)
	end
	love.graphics.rectangle("fill", self.x, self.y, self.w, self.h)
	love.graphics.setColor(0.92, 0.51, 0.14, 1)
	love.graphics.setLineWidth(4)
	love.graphics.rectangle("line", self.x, self.y, self.w, self.h)
	love.graphics.setColor(0.92, 0.51, 0.14, 1)
	love.graphics.print(self.text, self.x + (self.w / 2) - (textWidth / 2), self.y + (self.h / 2) - (textHeight / 2))
end

function Button:mousepressed(x, y, button)
	if button == 1 and self.hover then
		self.callback()
	end
end

return Button
