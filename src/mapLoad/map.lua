Dungeon = require("mapLoad/dungen/dungen")

local map = {}

function map.init()
Dungeon.init(32,32)
Dungeon.generate(32)
camera = {}
camera.x = 0
camera.y = 0
map.graphics = {}
map.graphics.width = 16
map.graphics.height = 16
map.graphics.sheet = love.graphics.newImage("mapLoad/img/LDtiles.png")
map.setQuads()
end

function map.setQuads()
map.quads = {}
map.quads[1] = map.newQuad(0,1)
map.quads[2] = map.newQuad(4,2)
end

function map.newQuad(x,y)
return love.graphics.newQuad(
x * map.graphics.width, 
y * map.graphics.height,
map.graphics.width,
map.graphics.height,
map.graphics.sheet:getWidth(),
map.graphics.sheet:getHeight())
end

function map.draw()
  for x = 1, Dungeon.width do
    for y = 1, Dungeon.height do
      if Dungeon.map[x][y] == Tiles.Solid then
        love.graphics.drawq(map.graphics.sheet,
        map.quads[2],
        (x - 1) * map.graphics.width - camera.x, 
        (y - 1) * map.graphics.height - camera.y)
      elseif Dungeon.map[x][y] == Tiles.Door then
        love.graphics.drawq(map.graphics.sheet,
        map.quads[1],
        (x - 1) * map.graphics.width - camera.x, 
        (y - 1) * map.graphics.height - camera.y)
      elseif Dungeon.map[x][y] == Tiles.Wall then
        love.graphics.drawq(map.graphics.sheet,
        map.quads[2],
        (x - 1) * map.graphics.width - camera.x, 
        (y - 1) * map.graphics.height - camera.y)
      elseif Dungeon.map[x][y] == Tiles.Floor then
        love.graphics.drawq(map.graphics.sheet,
        map.quads[1],
        (x - 1) * map.graphics.width - camera.x, 
        (y - 1) * map.graphics.height - camera.y)
        --love.graphics.rectangle("line",x * map.graphics.width, y * map.graphics.height, map.graphics.width,map.graphics.height)
      end
    end
  end
end

return map
