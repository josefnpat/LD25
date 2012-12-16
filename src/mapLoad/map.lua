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
  map.gameCanvas = {} 
  map.gameCanvas[1] = love.graphics.newCanvas(800,600)
  map.gameCanvas[2] = love.graphics.newCanvas(800,600)
  map.gameCanvas[1]:setFilter("nearest","nearest")
  map.gameCanvas[2]:setFilter("nearest","nearest")
  
  map.autoLayer2 = {}
	
	for x = 1, map.mapWidth do
		map.autoLayer2[x] = {}
	end
	
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

function BitToQuad(Bit,x,y)

if Bit == 20 or Bit == 21 then
return 27
end

if Bit == 17 then
return 12
end

if Bit == 25 then

end

if Bit == 5 then

end

if Bit == 140 or Bit == 132 or Bit == 136  then
return 36
end

if Bit == 156 or Bit == 149 or Bit == 157 then
return 28
end

if Bit == 189 or Bit == 190 or Bit == 191 then
return 19
end

if Bit == 29 then
return 17
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

if Bit == 106 or Bit == 107 then
map.autoLayer2[x][y - 1] = 42
return 43
end

if Bit == 99 then
map.autoLayer2[x][y - 1] = 42
return 4
end

if Bit == 63 or Bit == 60 or Bit == 61 or Bit == 62 then
return 20
end

if Bit == 34 then
return 4
end

if Bit == 40 or Bit == 42 or Bit == 43 then
return 43
end

if Bit == 67 or Bit == 66 or Bit == 65 or Bit == 71 or Bit == 70 then
map.autoLayer2[x][y - 1] = 34
end

if Bit == 172 or Bit == 170 or Bit == 166 or Bit == 172 or Bit == 174 then
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

function map.draw(layer)
  local TopLeftX = math.max(1,camera.x / map.graphics.width)
  local TopLeftY = math.max(1,camera.y / map.graphics.height)

  local DrawLimitX = math.min(TopLeftX + camera.width, Dungeon.width)
  local DrawLimitY = math.min(TopLeftY + camera.height, Dungeon.height)
  love.graphics.setCanvas(map.gameCanvas[layer])
  for x = math.floor(TopLeftX), math.floor(DrawLimitX) do
    for y = math.floor(TopLeftY), math.floor(DrawLimitY) do
      
      if Dungeon.map[x][y] == Tiles.Solid and layer == 1 then
      
        if x > 1 and y > 1 and x < map.mapWidth - 2 and y < map.mapHeight - 2 then
        map.drawTile(x,y,BitToQuad(map.autoMap[x][y],x,y))
        end
        
      elseif Dungeon.map[x][y] == Tiles.Door and layer == 1 then
      
        map.drawTile(x,y,2)
        
      elseif Dungeon.map[x][y] == Tiles.Floor and layer == 1 then
      
        map.drawTile(x,y,2)
        
      end
      
      
      if map.autoLayer2[x][y] and layer == 2 then
        map.drawTile(x,y,map.autoLayer2[x][y])
      end
      
      
      love.graphics.setFont(font)
      if x > 1 and y > 1 and x < map.mapWidth - 2 and y < map.mapHeight - 2 then
		love.graphics.print(map.autoMap[x][y],(x - 1) * map.graphics.width - camera.x, (y - 1) * map.graphics.height - camera.y)
      end
    end
  end
  love.graphics.setCanvas()
  love.graphics.draw(map.gameCanvas[layer],0,0,0,4,4)
  
  for i = 1, #map.gameCanvas do
  map.gameCanvas[i]:clear()
  end
end

return map
