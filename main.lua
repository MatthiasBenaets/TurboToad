local push = require("lib.push")
local windowWidth, windowHeight = love.window.getDesktopDimensions()
local virtualWidth, virtualHeight = 800, 600

local state = "menu"

local menu = {
	load = require("menu"),
	active = function() end,
}

function love.load()
	love.graphics.setDefaultFilter("nearest", "nearest")
	push:setupScreen(
		virtualWidth,
		virtualHeight,
		windowWidth,
		windowHeight,
		{ fullscreen = false, vsync = true, resizable = true }
	)

	menu.active = menu.load:new()
end

function love.update(dt) end

function love.resize(w, h)
	push:resize(w, h)
end

function love.draw()
	push:start()
	if state == "menu" then
		menu.active:draw()
	end
	push:finish()
end
