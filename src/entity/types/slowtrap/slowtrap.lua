local slowtrap = {}
slowtrap.sheet = map.graphics.sheet
slowtrap.sheet:setFilter('nearest','nearest')


function slowtrap:update(dt)
    self.camera_x = (-camera.x + ((32 * 4) + self.x))
    self.camera_y = (-camera.y + ((32 * 4) + self.y))
end

function slowtrap:draw()
  local x_scale = 4
  local y_scale = 4
  --love.graphics.print("slowtrap",(self.camera_x * x_scale),(self.camera_y * y_scale))
  love.graphics.drawq(
    map.graphics.sheet,map.quads[7],
    self.camera_x * x_scale,
    self.camera_y * y_scale,
    0,4,4)
end

function slowtrap.new()
  local e = {}
  e.type = "slowtrap"
  e.x = 0
  e.y = 0
  e.camera_x = 0
  e.camera_y = 0
  e.slow_amount = -25;
  e.effect = 1
  e.health = 10;
  e.z_index = -1
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
