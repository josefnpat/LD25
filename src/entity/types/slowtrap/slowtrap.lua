local slowtrap = {}
slowtrap.sheet = map.graphics.sheet
slowtrap.sheet:setFilter('nearest','nearest')

function slowtrap:update(dt)
end

function slowtrap:draw()
  local x,y = entity.getScreenLocation(self)
  love.graphics.drawq(slowtrap.sheet,map.quads[8],x,y,0,4,4)
end

function slowtrap.new()
  local e = {}
  e.type = "slowtrap"
  e.x = 0
  e.y = 0
  e.z_index = -1
  e.range = 60
  e.update = slowtrap.update
  e.draw = slowtrap.draw
  e.die = false 
  return e
end

return slowtrap
