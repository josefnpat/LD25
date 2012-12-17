local test = {}

function test:update(dt)
  --local start = {entity.RawToTile(self)}
  --start[1],start[2] = math.round(start[1]/16),math.round(start[2]/16)
  local start = {entity.RawToMap(self)}
  --print(start[1],start[2])
  
  --local stop = {entity.RawToTile(player_obj)}
  --stop[1],stop[2] = math.round(stop[1]/16),math.round(stop[2]/16)
  local stop = {entity.RawToMap(player_obj)}
  --print(stop[1],stop[2])
  
  self.path = pathfinder.find(Dungeon.map,start,stop)
end

function test:draw()
  local x,y = entity.getScreenLocation(self)
  love.graphics.circle("line",x,y,16*4)
  love.graphics.print("t",x,y)
  for i,v in ipairs(self.path) do
    --local x,y = entity.MapToRaw(v)
    --love.graphics.circle("line",x,y,4)
  end
end

function test.new()
  local e = {}
  e.type = "test"
  repeat
    e.x = player_obj.x + math.random(-100,100)
    e.y = player_obj.y + math.random(-100,100)
  until not entity.collision(e)
  e.update = test.update
  e.draw = test.draw
  return e
end

return test
