pathfind = {}

function pathfind:path_update(dt,target)
  self.last_path_check = self.last_path_check + dt
  if self.last_path_check > 0.2 then
    self.last_path_check = 0
    local start = {entity.RawToMap(self)}  
    local stop = {entity.RawToMap(target)}
    --print("searching")
    --local start_t = love.timer.getMicroTime( )
    self.path = pathfinder.find(Dungeon.map,start,stop)
    --local end_t = love.timer.getMicroTime( )
    --print("done searching"..(end_t - start_t))
  end
  if self.path and #self.path > 0 then
    local cx,cy = entity.MapToRaw(self.path[1].x,self.path[1].y)
    if self.path[2] and entity.distance(self,{x=cx,y=cy}) < 16 then
      local cx,cy = entity.MapToRaw(self.path[2].x,self.path[2].y)
      table.remove(self.path,1)
    end
    local sx,sy = entity.getScreenLocation(self)
    local nx,ny = entity.getScreenLocation({x=cx,y=cy})
    local dx,dy = nx-sx+32,ny-sy+32
    local previousX,previousY = self.x,self.y
    self.x = self.x + dx*dt/3*self.speed
    self.y = self.y + dy*dt/3*self.speed
    local tx,ty = entity.RawToTile(self)
    for i,v in ipairs(entity.data) do
      if self.x ~= v.x and self.y ~= v.y and v.type ~= Tiles.Portal then
        local yx,yy = entity.RawToTile(v)
        if tx == yx and ty == yy then
          self.x = previousX
          self.y = previousY
        end
      end
    end
  end
end

function pathfind.init(e)
  e.last_path_check = math.random()
  e.path_update = pathfind.path_update
  e.speed = 1
end

return pathfind
