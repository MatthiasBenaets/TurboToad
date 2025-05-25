local push = require("lib.push")
local windowWidth, windowHeight = love.window.getDesktopDimensions()
local virtualWidth, virtualHeight = 800, 600

local menu = love.graphics.newImage("assets/menu.png")

function love.load()
	love.graphics.setDefaultFilter("nearest", "nearest")
	push:setupScreen(
		virtualWidth,
		virtualHeight,
		windowWidth,
		windowHeight,
		{ fullscreen = false, vsync = true, resizable = true }
	)
end

function love.update(dt) end

function love.resize(w, h)
	push:resize(w, h)
end

function love.draw()
	push:start()
	love.graphics.draw(menu, 0, 0)
	push:finish()
end
