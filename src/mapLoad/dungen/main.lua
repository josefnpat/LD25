Dungeon = require("dungen")

function love.load()
Dungeon.init(32,32)
Dungeon.generate(32)
end

function love.draw()
Dungeon.draw()
end

