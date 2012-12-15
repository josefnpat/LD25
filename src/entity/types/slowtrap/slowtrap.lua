local slowtrap = {}
slowtrap.slow_amount = 50;
slowtrap.health = 100;
function slowtrap:update(dt)
end

function slowtrap:draw()
  love.graphics.print("slowtrap",self.x,self.y)
end

function slowtrap.new()
  local e = {}
  e.type = "slowtrap"
  e.x = 0
  e.y = 0
  e.update = slowtrap.update
  e.draw = slowtrap.draw
  return e
end

function slowtrap.gethealth()
  return slowtrap.health
end

function slowtrap.geteffect()
  return slowtrap.slow_amount
end

return slowtrap
