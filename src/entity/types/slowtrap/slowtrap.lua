local slowtrap = {}

function slowtrap:update(dt)
   self.camera_x = (-camera.x + ((32 * 4) + self.x))
    self.camera_y = (-camera.y + ((32 * 4) + self.y))
end

function slowtrap:draw()
  x_scale = 4
  y_scale = 4
  love.graphics.print("slowtrap",(self.camera_x * x_scale),(self.camera_y * y_scale))
end

function slowtrap.new()
  local e = {}
  e.type = "slowtrap"
  e.x = 0
  e.y = 0
  e.camera_x = 0
  e.camera_y = 0
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
