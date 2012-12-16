Dungeon = require("mapLoad/dungen/dungen")

local map = {}

function map.init()
	map.mapWidth = 64
	map.mapHeight = 64
	map.rooms = 32
	font = love.graphics.newFont(7)
  Dungeon.init(map.mapWidth,map.mapHeight)
  Dungeon.generate(map.rooms)
  camera = {}
  camera.x = 0
  camera.y = 0
  camera.width = 18
  camera.height = 14
  map.graphics = {}
  map.graphics.width = 16
  map.graphics.height = 16
  map.graphics.sheet = love.graphics.newImage("mapLoad/img/LDtiles.png")
  map.setQuads()
  map.gameCanvas = love.graphics.newCanvas(800,600)
  map.gameCanvas:setFilter("nearest","nearest")
  
  map.autoMap = map.autoTile()
end

function map.setQuads()
  map.quads = {}
	for x = 1, 8 do
		for y = 1, 8 do
			map.quads[#map.quads + 1] = map.newQuad(x - 1,y - 1)
		end
	end	
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



function map.autoTile()
autoMap = {}
for x = 2, map.mapWidth - 1 do
	autoMap[x] = {}
	for y = 2, map.mapHeight - 1 do
		autoMap[x][y] = calculateEdge(x,y,Tiles.Solid) + calculateCorner(x,y,Tiles.Solid)
	end
end
return autoMap
end

function BitToQuad(Bit)

if Bit == 140 or Bit == 132 or Bit == 136  then
return 36
end

if Bit == 156 then
return 28
end

if Bit == 7 then
return 3
end

if Bit == 11 then
return 5
end

if Bit == 3 then
return 11
end

if Bit == 40 or Bit == 42 or Bit == 43 then
return 43
end

if Bit == 20 then
return 27
end


if Bit == 172 or Bit == 170 or Bit == 166 or Bit == 172 then
return 44
end

return 35
end

function calculateCorner( x, y, tile)
local temp = 0
if Dungeon.map[x][y] == tile then
if Dungeon.map[x - 1][y - 1] ~= tile then
temp = temp + 1
end

if Dungeon.map[x + 1][y - 1] ~= tile then
temp = temp + 2
end

if Dungeon.map[x - 1][y + 1] ~= tile then
temp = temp + 4
end

if Dungeon.map[x + 1][y + 1] ~= tile then
temp = temp + 8
end
end

if temp > 0 then
	return temp
else
	return - 1
end

end

function calculateEdge( x, y, tile)
local temp = 0
if Dungeon.map[x][y] == tile then
if Dungeon.map[x - 1][y] ~= tile then
temp = temp + 16
end

if Dungeon.map[x + 1][y] ~= tile then
temp = temp + 32
end

if Dungeon.map[x][y - 1] ~= tile then
temp = temp + 64
end

if Dungeon.map[x][y + 1] ~= tile then
temp = temp + 128
end
end

if temp > 0 then
	return temp
else
	return - 1
end

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
  love.graphics.setCanvas(map.gameCanvas)
  for x = math.floor(TopLeftX), math.floor(DrawLimitX) do
    for y = math.floor(TopLeftY), math.floor(DrawLimitY) do
      if Dungeon.map[x][y] == Tiles.Solid then
        if x > 1 and y > 1 and x < map.mapWidth - 2 and y < map.mapHeight - 2 then
        map.drawTile(x,y,BitToQuad(map.autoMap[x][y]))
        end
      elseif Dungeon.map[x][y] == Tiles.Door then
        map.drawTile(x,y,2)
      elseif Dungeon.map[x][y] == Tiles.Floor then
        map.drawTile(x,y,2)
      end
      love.graphics.setFont(font)
      --if x > 1 and y > 1 and x < map.mapWidth - 2 and y < map.mapHeight - 2 then
		--love.graphics.print(map.autoMap[x][y],(x - 1) * map.graphics.width - camera.x, (y - 1) * map.graphics.height - camera.y)
      --end
    end
  end
  love.graphics.setCanvas()
  love.graphics.draw(map.gameCanvas,0,0,0,4,4)
end

return map
