map = require("map")
Dungeon = require("dungen/dungen")
bresenham = require("dungen/bresenham")

function love.load()
map.init()
end

function love.draw()
map.draw()
end

