local game = {
	state = "menu",
}

local menu = {
	class = require("src/gamestates/Menu"),
	instance = {},
}

local play = {
	class = require("src/gamestates/Play"),
	instance = {},
}

local function setState(state)
	game.state = state
end

function game.load()
	menu.instance = menu.class:load(setState)
	play.instance = play.class:load()
end

function game.update(dt)
	if game.state == "menu" then
		menu.instance:update(dt)
	elseif game.state == "play" then
		play.instance:update(dt)
	end
end

function game.draw()
	if game.state == "menu" then
		menu.instance:draw()
	elseif game.state == "play" then
		play.instance:draw()
	end
end

function game.mousepressed(x, y, button)
	if game.state == "menu" then
		menu.instance:mousepressed(x, y, button)
	end
end

function game.keypressed(key)
	if game.state == "play" then
		play.instance:keypressed(key)
	end
end

return game
