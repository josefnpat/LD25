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
  e.slow_amount = -25;
  e.effect = 1
  e.health = 10;
  e.z_index = -1
  e.range = 60
  e.update = slowtrap.update
  e.gethealth = slowtrap.gethealth
  e.geteffect = slowtrap.geteffect
  e.getmodifier = slowtrap.getmodifier
  e.ishit = slowtrap.ishit
  e.draw = slowtrap.draw
  return e
end

function slowtrap:gethealth()
  return self.health
end

function slowtrap:geteffect()
  return self.slow_amount
end

function slowtrap:getmodifier()
  return self.slow_amount
end
function slowtrap:ishit(pow)
  self.health = self.health - pow;
end

return slowtrap
