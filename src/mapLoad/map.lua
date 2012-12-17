Dungeon = require("mapLoad/dungen/dungen")
minimap = require("mapLoad/minimap/minimap")

local map = {}

function map.init()
	map.mapWidth = 48
	map.mapHeight = 48
	map.rooms = 64
	font = love.graphics.newFont(7)
  Dungeon.init(map.mapWidth,map.mapHeight)
  Dungeon.generate(map.rooms)
  
  map.graphics = {}
  map.graphics.width = 16
  map.graphics.height = 16
  map.graphics.sheet = love.graphics.newImage("mapLoad/img/LDtiles.png")
  
  camera = {}
  camera.x = 0
  camera.y = 0
  
  --These two lines need to be changed dynamically (width and height)
  camera.width = love.graphics.getWidth() / map.graphics.width / 4 + 1
  camera.height = love.graphics.getHeight() / map.graphics.height / 4 + 1
  
  map.setQuads()
  map.gameCanvas = {} 
  map.gameCanvas[1] = love.graphics.newCanvas(800,600)
  map.gameCanvas[2] = love.graphics.newCanvas(800,600)
  map.gameCanvas[1]:setFilter("nearest","nearest")
  map.gameCanvas[2]:setFilter("nearest","nearest")
  
  map.autoLayer2 = {}
	
	local finished = false
	
	while finished == false do
	map.autoMap = map.autoTile()
	finished = map.TestQuads()
	print("error in auto mapping, trying again")
	end
	
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

function map.TestQuads()
for x = 2, map.mapWidth - 1 do
	for y = 2, map.mapHeight - 1 do
		CurrentBit, Error = BitToQuad(map.autoMap[x][y],x,y)
		if Error then
		Dungeon.map[x][y] = Tiles.Floor
		--print("An error was found, fixed it")
		return false
		end
	end
end
return true
end



function map.autoTile()
autoMap = {}
for x = 1, map.mapWidth do
		map.autoLayer2[x] = {}
end
for x = 2, map.mapWidth - 1 do
	autoMap[x] = {}
	for y = 2, map.mapHeight - 1 do
		autoMap[x][y] = calculateEdge(x,y,Tiles.Solid) + calculateCorner(x,y,Tiles.Solid)
	end
end

  return autoMap, true
end

function BitToQuad(Bit,x,y)

if Bit >= 20 and Bit <= 23 then
return 27
end

if Bit >= 17 and Bit <= 19 then
return 12
end

if Bit >= 132 and Bit <= 142  then
return 36
end

if Bit >= 148 and Bit <= 157 then
return 28
end

if Bit == 189 or Bit == 190 or Bit == 191 then
return 19
end

if Bit == 29 then
return 17
end

if Bit == 3 then
return 11
end

if Bit == 119 then
map.autoLayer2[x][y - 1] = 18
return 33
end

if Bit >= 7 and Bit <= 9 then
return 3
end

if Bit >= 93 and Bit <= 95 then
map.autoLayer2[x][y - 1] = 26
return 17
end

if Bit >= 235 and Bit <= 239 then
map.autoLayer2[x][y - 1] = 42
return 44
end

if Bit == 27 then
return 25
end

if Bit == 159 then
return 28
end

if Bit == 223 or Bit == 213 or Bit == 215 then
map.autoLayer2[x][y - 1] = 26
return 28
end

if Bit == 11 then
return 5
end

if Bit == 46 then
return 25
end

if Bit == 25 then
return 41
end

if Bit == 41 then
return 43
end

if Bit == 44 then
return 25
end

if Bit == 188 then
return 19
end

if Bit == 35 then
return 4
end

if Bit == 255 or Bit == 253 then
map.autoLayer2[x][y - 1] = 18
return 19
end

if Bit == 221 then
map.autoLayer2[x][y - 1] = 26
return 28
end

if Bit >= 71 and Bit <= 72 then
map.autoLayer2[x][y - 1] = 34
return 11
end

if Bit == 106 or Bit == 107 then
map.autoLayer2[x][y - 1] = 42
return 43
end

if Bit == 98 then
map.autoLayer2[x][y - 1] = 42
return 4
end

if Bit == 55 then
return 33
end

if Bit == 187 then
return 19
end

if Bit == 31 then
return 4
end

if Bit == 143 then
return 36
end

if Bit == 123 then
map.autoLayer2[x][y - 1] = 18
return 41
end

if Bit == 99 then
map.autoLayer2[x][y - 1] = 42
return 4
end

if Bit == 51 then
return 13
end

if Bit == 63 or Bit == 60 or Bit == 61 or Bit == 62 then
return 20
end

if Bit == 126 then
return 20
end

if Bit == 127 or Bit == 125 then
map.autoLayer2[x][y - 1] = 18
return 20
end

if Bit == 234 then
map.autoLayer2[x][y - 1] = 42
return 44
end

if Bit == 28 then
return 17
end

if Bit == 34 then
return 4
end

if Bit == 59 then
return 41
end

if Bit == 40 or Bit == 42 or Bit == 43 then
return 43
end

if Bit == 203 or Bit == 207 or Bit == 206 or Bit == 205 or Bit == 202 or Bit == 179 or Bit == 106 or Bit == 199 or Bit == 198 then
map.autoLayer2[x][y - 1] = 34
return 36
end

if Bit >= 81 and Bit <= 83 then
map.autoLayer2[x][y - 1] = 26
return 12
end

if Bit == 91 then
map.autoLayer2[x][y - 1] = 26
return 41
end

if Bit == 201 then
map.autoLayer2[x][y - 1] = 34
return 36
end

if Bit == 175 then
return 44
end

if Bit == 89 then
map.autoLayer2[x][y - 1] = 26
return 12
end



if Bit == 115 then
map.autoLayer2[x][y - 1] = 18
return 13
end

if Bit == 79 then
map.autoLayer2[x][y - 1] = 34
return 5
end

if Bit >= 84 and Bit <= 87  then
map.autoLayer2[x][y - 1] = 26
return 27
end

if Bit == 67 or Bit == 66 or Bit == 65 or Bit == 71 or Bit == 70 then
map.autoLayer2[x][y - 1] = 34
return 35
end

if Bit >= 73 and Bit <= 75 then
map.autoLayer2[x][y - 1] = 34
return 3
end


if Bit >= 166 and Bit <= 174 then
return 44
end

if Bit >= -4 and Bit <= 10 then
return 35
end

return 35, true
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

function map.draw(layer,writeDebug)
  local TopLeftX = math.max(1,camera.x / map.graphics.width)
  local TopLeftY = math.max(1,camera.y / map.graphics.height)

  local DrawLimitX = math.min(TopLeftX + camera.width, Dungeon.width)
  local DrawLimitY = math.min(TopLeftY + camera.height, Dungeon.height)
  love.graphics.setCanvas(map.gameCanvas[layer])
  for x = math.floor(TopLeftX), math.floor(DrawLimitX) do
    for y = math.floor(TopLeftY), math.floor(DrawLimitY) do
      
      if Dungeon.map[x][y] == Tiles.Solid and layer == 1 then
      
        if x > 1 and y > 1 and x < map.mapWidth - 2 and y < map.mapHeight - 2 then
        map.drawTile(x,y, BitToQuad(map.autoMap[x][y],x,y))
        end
        
      elseif Dungeon.map[x][y] == Tiles.Door and layer == 1 then
      
        map.drawTile(x,y,2)
        
      elseif Dungeon.map[x][y] == Tiles.Floor and layer == 1 or Dungeon.map[x][y] == Tiles.Portal and layer == 1 then
      
        map.drawTile(x,y,2)
        
      end
      
      
      if map.autoLayer2[x][y] and layer == 2 then
        map.drawTile(x,y,map.autoLayer2[x][y])
      end
      
      if writeDebug == true then
        love.graphics.setFont(font)
        if x > 1 and y > 1 and x < map.mapWidth - 2 and y < map.mapHeight - 2 then
		  love.graphics.print(map.autoMap[x][y],(x - 1) * map.graphics.width - camera.x, (y - 1) * map.graphics.height - camera.y)
        end
      end
    end
  end
  love.graphics.setCanvas()
  love.graphics.draw(map.gameCanvas[layer],0,0,0,4,4)
  
  map.gameCanvas[1]:clear(31,24,24)
  map.gameCanvas[2]:clear()
  
  --minimap.draw()
  
end

return map
