Dungeon = require("dungen")

function love.load()
Dungeon.init(128,128)
Dungeon.generate(32)
end

function love.draw()
Dungeon.draw()
end

