local test = {}

function test:update(dt)
  self.last_path_check = self.last_path_check + dt
  if self.last_path_check > 0.2 then
    self.last_path_check = 0
    local start = {entity.RawToMap(self)}  
    local stop = {entity.RawToMap(player_obj)}
    --print("searching")
    --local start_t = love.timer.getMicroTime( )
    self.path = pathfinder.find(Dungeon.map,start,stop)
    --local end_t = love.timer.getMicroTime( )
    --print("done searching"..(end_t - start_t))
  end
  if self.path and #self.path > 0 then
    local cx,cy = entity.MapToRaw(self.path[1].x,self.path[1].y)
    if self.path[2] and entity.distance(self,{x=cx,y=cy}) < 32 then
      local cx,cy = entity.MapToRaw(self.path[2].x,self.path[2].y)
      table.remove(self.path,1)
    end
    local sx,sy = entity.getScreenLocation(self)
    local nx,ny = entity.getScreenLocation({x=cx,y=cy})
    local dx,dy = nx-sx+32,ny-sy+32
    
    local previousX,previousY = self.x,self.y
    
    self.x = self.x + dx*dt/2
    self.y = self.y + dy*dt/2
    
    local tx,ty = entity.RawToTile(self)
    for i,v in ipairs(entity.data) do
      if self.x ~= v.x and self.y ~= v.y then
        local yx,yy = entity.RawToTile(v)
        if tx == yx and ty == yy then
          self.x = previousX
          self.y = previousY
        end
      end
    end
    
  end
end

function test:draw()
  local x,y = entity.getScreenLocation(self)
  love.graphics.circle("line",x,y,8,16*4)
  love.graphics.print("t",x,y)
  --[[
  if self.path then
    for i,v in ipairs(self.path) do
      local x,y = entity.MapToRaw(v.x,v.y)
      local e = {x=x,y=y}
      local rx,ry = entity.getScreenLocation(e)
      love.graphics.circle("line",rx+32,ry+32,4)
    end
  end
  --]]
end

function test.new()
  local e = {}
  e.type = "test"
  repeat
    e.x = player_obj.x + math.random(-200,200)
    e.y = player_obj.y + math.random(-200,200)
  until not entity.collision(e)
  e.update = test.update
  e.draw = test.draw
  e.last_path_check = math.random()
  return e
end

return test
