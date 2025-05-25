local World = {}

World.__index = World

local Player = {
	load = require("lib.player"),
	active = function() end,
}

local Background = {
	load = require("lib.background"),
	layers = {
		{ "assets/plx-1.png", 6 },
		{ "assets/plx-2.png", 12 },
		{ "assets/plx-3.png", 25 },
		{ "assets/plx-4.png", 50 },
		{ "assets/plx-5.png", 100 },
	},
}

local Ground = {
	load = require("lib.ground"),
	active = function() end,
}

function World:new(virtualWidth, virtualHeight)
	local this = {
		groundHeight = virtualHeight * 0.8,
		player = {},
		background = {},
	}

	Player.active = Player.load:new(virtualWidth, virtualHeight, this.groundHeight)

	for _, layer in ipairs(Background.layers) do
		table.insert(this.background, Background.load:new(layer[1], layer[2]))
	end

	Ground.active = Ground.load:new(virtualWidth, virtualHeight, "assets/ground.png", 100)

	setmetatable(this, self)

	return this
end

function World:update(dt)
	for _, bg in ipairs(self.background) do
		bg:update(dt)
	end

	Ground.active:update(dt)

	Player.active:update(dt)
end

function World:draw()
	for _, bg in ipairs(self.background) do
		bg:draw()
	end

	Ground.active:draw()

	Player.active:draw()
end

return World
