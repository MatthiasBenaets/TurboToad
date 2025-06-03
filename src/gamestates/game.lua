local game = {
	state = "menu",
	players = 1,
}

local menu = {
	class = require("src/gamestates/Menu"),
	instance = {},
}

local play = {
	class = require("src/gamestates/Play"),
	instance = {},
}

local font

local function setGame(state, players)
	game.state = state
	game.players = players

	if state == "play" then
		play.instance = play.class:load(players)
	end
end

function game.load()
	font = love.graphics.newFont("assets/fonts/font.ttf", 24)
	love.graphics.setFont(font)

	menu.instance = menu.class:load(setGame)
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
