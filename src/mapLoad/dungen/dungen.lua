local Dungen = {}


function Dungen.init(width,height)
  Tiles = {}
  Tiles.Solid = 0
  Tiles.Door = 1
  Tiles.Wall = 2
  Tiles.Floor = 3

  Dungen.map = {}
  Dungen.width = width
  Dungen.height = height
  for x = 1, width do
    Dungen.map[x] = {}
    for y = 1, height do
      Dungen.map[x][y] = 0
    end
  end
end

function Dungen.generate(rooms)
  Dungen.map[math.floor(Dungen.width / 2)][math.floor(Dungen.height / 2)] = 1
  for r = 1, rooms do 
  Dungen.gRoom(Dungen.findDoor())
  end
end

function Dungen.getLevel()
return Dungen.map
end


function Dungen.findDoor()
Doors = {}
 for x = 1, Dungen.width do
    for y = 1, Dungen.height do
      if Dungen.map[x][y] == Tiles.Door then
		CurrentDoor = #Doors + 1
		Doors[CurrentDoor] = {}
        Doors[CurrentDoor].x = x
        Doors[CurrentDoor].y = y 
      end
    end
  end
return Doors[math.random(#Doors)].x,Doors[math.random(#Doors)].y

end


function Dungen.gRoom(cursorX, cursorY)
  local width = math.random(6,12)
  local height = math.random(6,12)
  
  local orientation = math.random(4)
  
  if orientation == 1 then
  goalX = math.floor(cursorX - width / 2)
  goalY = cursorY
  elseif orientation == 2 then
  goalX = cursorX
  goalY = math.floor(cursorY - height/ 2)
  elseif orientation == 3 then
  goalX = math.floor(cursorX + width / 2)
  goalY = cursorY
  else
  goalX = cursorX
  goalY = math.floor(cursorY + height/ 2)
  end
  
  for x = goalX, goalX + width do
    for y = goalY, goalY + height do
	  if x > 1 and x < Dungen.width then
	    if y > 1 and y < Dungen.height then
			if Dungen.map[x][y] == Tiles.Solid then
				Dungen.map[x][y] = Tiles.Floor
				if x == goalX or x == goalX + width or y == goalY or y == goalY + height then
				  Dungen.map[x][y] = Tiles.Wall
				    if math.random(3) == 1 then
				      Dungen.map[x][y] = Tiles.Door
				    end
				end
			end
	    end
	  end
    end
  end
end

function Dungen.draw()
  for x = 1, Dungen.width do
    for y = 1, Dungen.height do
      if Dungen.map[x][y] == 0 then
        love.graphics.setColor(0,0,0)
      elseif Dungen.map[x][y] == 1 then
        love.graphics.setColor(255,255,255)
      elseif Dungen.map[x][y] == 2 then
        love.graphics.setColor(0,0,0)
      elseif Dungen.map[x][y] == 3 then
        love.graphics.setColor(255,255,255)
      end
      love.graphics.rectangle("fill",x * 16, y * 16, 16,16)
      end
  end
end

return Dungen