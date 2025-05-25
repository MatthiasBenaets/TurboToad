local Push = require("lib.push")
local windowWidth, windowHeight = love.window.getDesktopDimensions()
local virtualWidth, virtualHeight = 800, 600

local Menu = {
	load = require("menu"),
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
end

function love.update(dt)
	if state == "menu" then
		Menu.active:update(dt)
	elseif state == "game" then
	end
end

function love.resize(w, h)
	Push:resize(w, h)
end

function love.draw()
	Push:start()
	if state == "menu" then
		Menu.active:draw()
	elseif state == "game" then
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
