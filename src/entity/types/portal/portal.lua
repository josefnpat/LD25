local portal = {}

function portal:draw()
  x_scale = 4
  y_scale = 4
  sheet = map.graphics.sheet
  sheet:setFilter("nearest","nearest")
  if self.type == "portal_enemy" then
    quad = love.graphics.newQuad(0,80,16,32,sheet:getWidth(),sheet:getHeight())
    love.graphics.drawq(sheet,quad,(self.camera_x * x_scale),(self.camera_y * y_scale),0,x_scale,y_scale,6,7)
  elseif self.type == "portal_player" then
    quad_x = self.dir[self.frame].x
    quad_y = self.dir[self.frame].y
    quad = love.graphics.newQuad(quad_x,quad_y,32,32,sheet:getWidth(),sheet:getHeight())
    love.graphics.drawq(sheet,quad,(self.camera_x * x_scale),(self.camera_y * y_scale),0,x_scale,y_scale,4,4)
  end
end

function portal:update(dt)
  --print(camera.x.." : "..camera.y)
  self.camera_x = math.floor(-camera.x + ((32 * 4) + self.x))
  self.camera_y = math.floor(-camera.y + ((32 * 4) + self.y))
  if self.dt > 0.2 then
    self.dt = 0.00
    if self.frame == 3 then
      self.frame = 1
    else 
      self.frame = self.frame + 1
    end
  else 
    self.dt = self.dt + dt
  end
end

function portal.new(type,x,y)
  local p = {}
  p.type = "portal_enemy"
  p.x = 0
  p.y = 0
  p.dir = {}
  p.dir[1] = { x=32,y=64 }
  p.dir[2] = { x=64,y=64 }
  p.dir[3] = { x=96,y=64 }
  p.dt = 0
  p.frame = 1
  p.camera_x = 0
  p.camera_y = 0
  p.z_index = -1
  p.update = portal.update
  p.draw = portal.draw
  return p
end

return portal
