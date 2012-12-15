local portal = {}

function portal:draw()
  x_scale = 4
  y_scale = 4
  sheet = map.graphics.sheet
  sheet:setFilter("nearest","nearest")
  if self.type == "portal_enemy" then
    --love.graphics.rectangle('fill',self.x,self.y,10,10)
    quad = love.graphics.newQuad(0,80,16,24,sheet:getWidth(),sheet:getHeight())
    love.graphics.drawq(sheet,quad,(self.camera_x * x_scale),(self.camera_y * y_scale),0,x_scale,y_scale,8,24)
  elseif self.type == "portal_player" then
    --love.graphics.rectangle('line',self.x,self.y,10,10)
    quad = love.graphics.newQuad(0,80,16,24,sheet:getWidth(),sheet:getHeight())
    love.graphics.drawq(sheet,quad,(self.camera_x * x_scale),(self.camera_y * y_scale),0,x_scale,y_scale,8,24)

  end
end

function portal:update(dt)
  print(camera.x.." x "..camera.y)
  print("Portal Location: "..self.x.." x "..self.y)
    self.camera_x = (-camera.x + ((32 * 4) + self.x))
    self.camera_y = (-camera.y + ((32 * 4) + self.y))
end

function portal.new(type,x,y)
  local p = {}
  p.type = "portal_enemy"
  p.x = 0
  p.y = 0
  p.camera_x = 0
  p.camera_y = 0
  p.update = portal.update
  p.draw = portal.draw
  return p
end

return portal