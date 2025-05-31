local game = {
	state = "menu",
}

local menu = {
	class = require("src/gamestates/Menu"),
	instance = {},
}

function game.load()
	menu.instance = menu.class:load()
end

function game.update(dt)
	if game.state == "menu" then
		menu.instance:update(dt)
	end
end

function game.draw()
	if game.state == "menu" then
		menu.instance:draw()
	end
end

return game
