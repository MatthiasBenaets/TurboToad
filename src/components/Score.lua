local Score = {}

Score.__index = Score

function Score:load()
	local this = {
		score = 0,
	}

	setmetatable(this, self)

	return this
end

function Score:update(dt)
	self.score = self.score + dt
end

function Score:draw()
	love.graphics.setColor(1, 1, 1, 1)
	love.graphics.print("Score: " .. math.floor(self.score), 50, 50)
end

return Score
