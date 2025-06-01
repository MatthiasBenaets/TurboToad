local Ground = {}

Ground.__index = Ground

function Ground:load(w, h, color)
	local this = {
		w = w,
		h = h,
		color = color,
	}

	setmetatable(this, self)

	return this
end

function Ground:update(dt) end

function Ground:draw()
	local width = love.graphics.getWidth()
	local height = love.graphics.getHeight()
	local tiles = math.ceil(width / self.w)

	love.graphics.setColor(0, self.color, 0, 1)
	for i = 0, tiles do
		love.graphics.rectangle("fill", i * self.w, height - self.h, self.w, self.h)
	end
end

return Ground
