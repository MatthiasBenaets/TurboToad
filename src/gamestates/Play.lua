local Play = {}

Play.__index = Play

local collision = require("src/components/collision")

local score = {
	class = require("src/components/Score"),
	instance = {},
}

local ground = require("src/world/Ground")

local player = {
	class = require("src/entities/Player"),
}

local enemy = {
	class = require("src/entities/Enemy"),
	minSpawnTimer = 1000,
	maxSpawnTimer = 4000,
}

local background = require("src/world/Background")

local speed = 200

function Play:load(players, setGame)
	local this = {
		ground = {
			width = 32,
			height = 50,
			speed = speed,
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
		state = "play",
		offset = 100,
		setGame = setGame,
		players = {},
		grounds = {
			layers = {},
			image = "assets/images/ground.png",
		},
		enemies = {},
		background = {
			layers = {},
			images = {
				{ "assets/images/plx-1.png", speed / 16 },
				{ "assets/images/plx-2.png", speed / 8 },
				{ "assets/images/plx-3.png", speed / 4 },
				{ "assets/images/plx-4.png", speed / 2 },
				{ "assets/images/plx-5.png", speed },
			},
		},
		enemyTimers = {},
		colors = { 1, 0.8 },
	}

	for _, layer in ipairs(this.background.images) do
		table.insert(this.background.layers, background:new(layer[1], layer[2]))
	end

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
			this.grounds.layers,
			ground:load(
				this.ground.width,
				this.ground.height + (i - 1) * this.offset,
				this.colors[i],
				this.grounds.image,
				speed
			)
		)

		this.enemies[i] = {}
		this.enemyTimers[i] = math.random(enemy.minSpawnTimer, enemy.maxSpawnTimer) / 1000
	end

	setmetatable(this, self)

	return this
end

function Play:update(dt)
	if self.state == "play" then
		score.instance:update(dt)

		for _, bg in ipairs(self.background.layers) do
			bg:update(dt)
		end

		for _, gr in ipairs(self.grounds.layers) do
			gr:update(dt)
		end

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
					self.state = "gameover"
				end
			end
		end
	end
end

function Play:draw()
	for _, bg in ipairs(self.background.layers) do
		bg:draw()
	end

	score.instance:draw()

	for i = #self.players, 1, -1 do
		self.grounds.layers[i]:draw()
		for _, mob in ipairs(self.enemies[i]) do
			mob:draw()
		end
		self.players[i]:draw()
	end

	if self.state == "gameover" then
		love.graphics.setColor(0.92, 0.51, 0.14, 1)
		love.graphics.print(
			"Game Over",
			love.graphics.getWidth() / 2 - love.graphics.getFont():getWidth("Game Over") / 2,
			love.graphics.getHeight() / 2
		)
		love.graphics.print(
			"Press 'R' to restart",
			love.graphics.getWidth() / 2 - love.graphics.getFont():getWidth("Press 'R' to restart") / 2,
			love.graphics.getHeight() / 2 + 50
		)
	end
end

function Play:keypressed(key)
	for _, char in ipairs(self.players) do
		if key == char.key then
			char:jump()
		end
	end

	if key == "r" and self.state == "gameover" then
		self.setGame("play", #self.players)
	end
end

return Play
