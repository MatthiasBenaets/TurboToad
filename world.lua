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
	scrollSpeed = 100,
}

local Enemy = {
	load = require("lib.enemy"),
	spawnTimer = 0,
	minSpawnTime = 3.0,
	maxSpawnTime = 6.0,
	nextSpawnTime = 0,
}

function World:new(virtualWidth, virtualHeight)
	local this = {
		virtualWidth = virtualWidth,
		virtualHeight = virtualHeight,
		groundHeight = virtualHeight * 0.8,
		player = {},
		background = {},
		enemies = {},
	}

	Player.active = Player.load:new(virtualWidth, virtualHeight, this.groundHeight)

	for _, layer in ipairs(Background.layers) do
		table.insert(this.background, Background.load:new(layer[1], layer[2]))
	end

	Ground.active = Ground.load:new(virtualWidth, virtualHeight, "assets/ground.png", 100)

	Enemy.nextSpawnTime = love.math.random(Enemy.minSpawnTime * 100, Enemy.maxSpawnTime * 100) / 100

	setmetatable(this, self)

	return this
end

function World:update(dt)
	for _, bg in ipairs(self.background) do
		bg:update(dt)
	end

	Ground.active:update(dt)

	Enemy.spawnTimer = Enemy.spawnTimer + dt
	if Enemy.spawnTimer >= Enemy.nextSpawnTime then
		Enemy.spawnTimer = 0
		Enemy.nextSpawnTime = love.math.random(Enemy.minSpawnTime * 100, Enemy.maxSpawnTime * 100) / 100

		local newEnemy = Enemy.load:new(self.virtualWidth, self.virtualHeight, self.groundHeight, Ground.scrollSpeed)

		newEnemy.x = self.virtualWidth + love.math.random(50, 200) -- Spawns between 50 and 200 pixels off-screen

		table.insert(self.enemies, newEnemy)
	end

	for i = #self.enemies, 1, -1 do
		local enemy = self.enemies[i]
		enemy:update(dt)

		if enemy.x + enemy.width < 0 then
			table.remove(self.enemies, i)
		end
	end

	Player.active:update(dt)
end

function World:draw()
	for _, bg in ipairs(self.background) do
		bg:draw()
	end

	Ground.active:draw()

	for _, enemy in ipairs(self.enemies) do
		enemy:draw()
	end

	Player.active:draw()
end

function World:playerJump()
	if Player.active then
		Player.active:jump()
	end
end

return World
