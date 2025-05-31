local Play = {}

Play.__index = Play

local collision = require("src/components/collision")

local ground = {
	class = require("src/world/Ground"),
	instance = {},
}

local player = {
	class = require("src/entities/Player"),
	instance = {},
}

local enemy = {
	class = require("src/entities/Enemy"),
	instance = {},
	minSpawnTimer = 1000,
	maxSpawnTimer = 4000,
	spawnTimer = 0,
}

function Play:load()
	local this = {
		ground = {
			width = 32,
			height = 32,
			speed = 200,
		},
		player = {
			width = 32,
			height = 32,
			offset = 10,
		},
		enemy = {
			width = 32,
			height = 32,
		},
		enemies = {},
	}

	ground.instance = ground.class:load(this.ground.width, this.ground.height)
	player.instance = player.class:load(this.player.width, this.player.height, this.player.offset, this.ground.height)
	enemy.spawnTimer = math.random(enemy.minSpawnTimer, enemy.maxSpawnTimer) / 1000

	setmetatable(this, self)

	return this
end

function Play:update(dt)
	player.instance:update(dt)

	enemy.spawnTimer = enemy.spawnTimer - dt
	if enemy.spawnTimer <= 0 then
		table.insert(
			self.enemies,
			enemy.class:load(
				love.graphics.getWidth() + self.enemy.width,
				love.graphics.getHeight() - self.ground.height - self.enemy.height,
				self.enemy.width,
				self.enemy.height,
				self.ground.speed
			)
		)
		enemy.spawnTimer = math.random(enemy.minSpawnTimer, enemy.maxSpawnTimer) / 1000
	end

	for _, mob in ipairs(self.enemies) do
		mob:update(dt)
	end

	for _, mob in ipairs(self.enemies) do
		if collision.check(player.instance, mob) then
			print("DEAD")
		end
	end
end

function Play:draw()
	love.graphics.setColor(1, 1, 1, 1)
	love.graphics.print("Play", 0, 0)

	ground.instance:draw()
	player.instance:draw()
	for _, mob in ipairs(self.enemies) do
		mob:draw()
	end
end

function Play:keypressed(key)
	if key == "space" then
		player.instance:jump()
	end
end

return Play
