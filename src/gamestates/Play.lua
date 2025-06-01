local Play = {}

Play.__index = Play

local collision = require("src/components/collision")

local score = {
	class = require("src/components/Score"),
	instance = {},
}

local ground = {
	class = require("src/world/Ground"),
	instance = {},
}

local player = {
	class = require("src/entities/Player"),
}

local enemy = {
	class = require("src/entities/Enemy"),
	minSpawnTimer = 1000,
	maxSpawnTimer = 4000,
}

function Play:load(players)
	local this = {
		ground = {
			width = 32,
			height = 50,
			speed = 200,
		},
		player = {
			width = 32,
			height = 32,
			offset = 10,
			keys = { "space", "up" },
		},
		enemy = {
			width = 32,
			height = 32,
		},
		offset = 150,
		players = {},
		grounds = {},
		enemies = {},
		enemyTimers = {},
		colors = { 1, 0.5 },
	}

	score.instance = score.class:load()

	for i = 1, players do
		table.insert(
			this.players,
			player.class:load(
				this.player.width,
				this.player.height,
				this.player.offset - (i - 1) * 2,
				this.ground.height + (i - 1) * this.offset,
				this.player.keys[i],
				this.colors[i]
			)
		)

		table.insert(
			this.grounds,
			ground.class:load(this.ground.width, this.ground.height + (i - 1) * this.offset, this.colors[i])
		)

		this.enemies[i] = {}
		this.enemyTimers[i] = math.random(enemy.minSpawnTimer, enemy.maxSpawnTimer) / 1000
	end

	setmetatable(this, self)

	return this
end

function Play:update(dt)
	score.instance:update(dt)

	for _, char in ipairs(self.players) do
		char:update(dt)
	end

	for i = 1, #self.players do
		self.enemyTimers[i] = self.enemyTimers[i] - dt

		if self.enemyTimers[i] <= 0 then
			table.insert(
				self.enemies[i],
				enemy.class:load(
					love.graphics.getWidth() + self.enemy.width,
					love.graphics.getHeight() - self.ground.height - (i - 1) * self.offset - self.enemy.height,
					self.enemy.width,
					self.enemy.height,
					self.ground.speed,
					self.colors[i]
				)
			)
			self.enemyTimers[i] = math.random(enemy.minSpawnTimer, enemy.maxSpawnTimer) / 1000
		end
	end

	for i = 1, #self.enemies do
		for _, mob in ipairs(self.enemies[i]) do
			mob:update(dt)
		end
	end

	for i = 1, #self.enemies do
		local char = self.players[i]
		for _, mob in ipairs(self.enemies[i]) do
			if collision.check(char, mob) then
				print("Player " .. i .. " DEAD")
			end
		end
	end
end

function Play:draw()
	love.graphics.setColor(1, 1, 1, 1)
	love.graphics.print("Play", 0, 0)

	for i = #self.players, 1, -1 do
		self.grounds[i]:draw()
		self.players[i]:draw()
		for _, mob in ipairs(self.enemies[i]) do
			mob:draw()
		end
	end
end

function Play:keypressed(key)
	for _, char in ipairs(self.players) do
		if key == char.key then
			char:jump()
		end
	end
end

return Play
