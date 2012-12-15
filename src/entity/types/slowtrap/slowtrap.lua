local slowtrap = {}

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
  slowtrap.slow_amount = 50;
  slowtrap.health = 10;
  e.update = slowtrap.update
  e.draw = slowtrap.draw
  return e
end

function slowtrap:gethealth()
  return self.health
end

function slowtrap:geteffect()
  return self.slow_amount
end
function slowtrap:ishit()
  self.health = self.health - 1;
end

return slowtrap
