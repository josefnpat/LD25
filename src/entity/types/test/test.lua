local test = {}

function test:update(dt)
  self.last_path_check = self.last_path_check + dt
  if self.last_path_check > 1 then
    self.last_path_check = 0
    local start = {entity.RawToMap(self)}  
    local stop = {entity.RawToMap(player_obj)}
    self.path = pathfinder.find(Dungeon.map,start,stop)
  end

end

function test:draw()
  local x,y = entity.getScreenLocation(self)
  love.graphics.circle("line",x,y,16*4)
  love.graphics.print("t",x,y)
  if self.path then
    for i,v in ipairs(self.path) do
      local x,y = entity.MapToRaw(v.x,v.y)
      local e = {x=x,y=y}
      local rx,ry = entity.getScreenLocation(e)
      love.graphics.circle("line",rx,ry,4)
    end
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
  e.last_path_check = math.random()
  return e
end

return test
