local Push = require("lib.push")
local windowWidth, windowHeight = love.window.getDesktopDimensions()
local virtualWidth, virtualHeight = 800, 600

local Menu = {
	load = require("menu"),
	active = function() end,
}

local World = {
	load = require("world"),
	active = function() end,
}

local state = "menu"
local function setState(newState)
	state = newState
end

function love.load()
	love.graphics.setDefaultFilter("nearest", "nearest")
	Push:setupScreen(
		virtualWidth,
		virtualHeight,
		windowWidth,
		windowHeight,
		{ fullscreen = false, vsync = true, resizable = true }
	)

	Menu.active = Menu.load:new(virtualWidth, virtualHeight, setState)
	World.active = World.load:new(virtualWidth, virtualHeight, setState)
end

function love.update(dt)
	if state == "menu" then
		Menu.active:update(dt)
	elseif state == "game" then
		World.active:update(dt)
	end
end

function love.resize(w, h)
	Push:resize(w, h)
end

function love.draw()
	Push:start()
	if state == "menu" then
		Menu.active:draw()
	else
		World.active:draw()
		if state == "gameover" then
			love.graphics.setColor(1, 0, 0, 1)
			love.graphics.setFont(love.graphics.newFont(30))
			love.graphics.printf("GAME OVER!", 0, virtualHeight / 2 - 15, virtualWidth, "center")
			love.graphics.setFont(love.graphics.newFont(16))
			love.graphics.printf("Press R to Restart", 0, virtualHeight / 2 + 30, virtualWidth, "center")
		end
	end
	Push:finish()
end

function love.mousepressed(x, y, button, istouch)
	local virtualX, virtualY = Push:toGame(x, y)
	if state == "menu" then
		Menu.active:mousepressed(virtualX, virtualY, button, istouch)
	elseif state == "game" then
	end
end

function love.keypressed(key)
	if state == "game" then
		if key == "space" then
			World.active:playerJump()
		end
	elseif state == "gameover" then
		if key == "r" then
			setState("game")
			World.active = World.load:new(virtualWidth, virtualHeight, setState)
		end
	end
end
