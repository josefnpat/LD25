Dungeon = require("mapLoad/dungen/dungen")

local map = {}

function map.init()
Dungeon.init(32,32)
Dungeon.generate(64)
camera = {}
camera.x = 0
camera.y = 0
camera.width = 16
camera.height = 14
map.graphics = {}
map.graphics.width = 16
map.graphics.height = 16
map.graphics.sheet = love.graphics.newImage("mapLoad/img/LDtiles.png")
map.setQuads()
map.gameCanvas = love.graphics.newCanvas(800,600)
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

function map.drawTile(x,y,quad)
love.graphics.drawq(map.graphics.sheet,
        map.quads[quad],
        math.floor((x - 1) * map.graphics.width - camera.x), 
        math.floor((y - 1) * map.graphics.height - camera.y))
end

function map.draw()
local TopLeftX = math.max(1,camera.x / map.graphics.width)
local TopLeftY = math.max(1,camera.y / map.graphics.height)

local DrawLimitX = math.min(TopLeftX + camera.width, Dungeon.width)
local DrawLimitY = math.min(TopLeftY + camera.height, Dungeon.height)

  for x = math.floor(TopLeftX), math.floor(DrawLimitX) do
    for y = math.floor(TopLeftY), math.floor(DrawLimitY) do
      if Dungeon.map[x][y] == Tiles.Solid then
        map.drawTile(x,y,2)
      elseif Dungeon.map[x][y] == Tiles.Door then
        map.drawTile(x,y,1)
      elseif Dungeon.map[x][y] == Tiles.Wall then
        map.drawTile(x,y,2)
      elseif Dungeon.map[x][y] == Tiles.Floor then
        map.drawTile(x,y,1)
      end
    end
  end
end

return map
