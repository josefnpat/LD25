pathfinder = require("pathfinder")

path = {}

map = {
  {1,1,1,1,1,1,1,1,1,1},
  {1,1,1,1,1,1,1,1,1,1},
  {0,0,0,0,0,0,0,0,1,1},
  {1,1,1,1,1,1,1,1,1,1},
  {1,1,1,1,1,1,1,1,1,1},
  {1,1,1,1,1,1,1,1,1,1},
  {1,1,0,0,0,0,0,0,0,0},
  {1,1,1,1,1,1,1,1,1,1},
  {1,1,1,1,1,1,1,1,1,1},
  {1,1,1,1,1,1,1,1,1,1}
}

start = {1,1}
stop = {10,10}

function love.update(dt)
  path = pathfinder.find(map,start,stop)
end

function love.draw()
  for i,v in ipairs(map) do
    for j,w in ipairs(v) do
      if start[1]==i and start[2]==j then
        love.graphics.setColor(0,255,0)
      elseif stop[1]==i and stop[2]==j then
        love.graphics.setColor(0,0,255)
      else
        if w == 0 then
          love.graphics.setColor(255,0,0)
        else
          love.graphics.setColor(255,255,255)
        end
      end
      love.graphics.rectangle("fill", (i-1)*60, (j-1)*60, 59, 59)
      love.graphics.setColor(255,255,255)
    end
  end
  
  if path then
    love.graphics.setColor(255,255,0)
    for i,v in ipairs(path) do
      love.graphics.rectangle("fill", (v.x-1)*60+4, (v.y-1)*60+4, 59-8, 59-8)
    end
    love.graphics.setColor(255,255,255)
  end
end

function love.mousepressed(x,y,button)
  local new_x,new_y = math.ceil(x/60),math.ceil(y/60)
  if map[new_x] and map[new_x][new_y] then
    if map[new_x][new_y] == 1 then
      map[new_x][new_y] = 0
    else
      map[new_x][new_y] = 1
    end
  end
end
