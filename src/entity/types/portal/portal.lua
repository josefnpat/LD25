local portal = {}

portal.sheet = map.graphics.sheet
portal.sheet:setFilter('nearest','nearest')

portal.frame = 1
portal.camera_x = 0
portal.camera_y = 0

portal.portal_quads = {}
portal.portal_quads[1] = {}
portal.portal_quads[1] =  love.graphics.newQuad(32,64,32,32,map.graphics.sheet:getWidth(),map.graphics.sheet:getHeight())
portal.portal_quads[2] = {}
portal.portal_quads[2] =  love.graphics.newQuad(64,64,32,32,map.graphics.sheet:getWidth(),map.graphics.sheet:getHeight())
portal.portal_quads[3] = {}
portal.portal_quads[3] =  love.graphics.newQuad(96,64,32,32,map.graphics.sheet:getWidth(),map.graphics.sheet:getHeight())
portal.portal_quads[4] = {}
portal.portal_quads[4] = love.graphics.newQuad(0,80,16,32,map.graphics.sheet:getWidth(),map.graphics.sheet:getHeight())

function portal:draw()
  local x_scale = 4
  local y_scale = 4

  if self.type == "portal_enemy" then
    love.graphics.drawq(portal.sheet,portal.portal_quads[4],math.floor((-camera.x + ((32 * 4) + self.x)) * x_scale),math.floor((-camera.y + ((32 * 4) + self.y)) * y_scale),0,x_scale,y_scale,6,7)
  elseif self.type == "portal_player" then
    love.graphics.drawq(portal.sheet,portal.portal_quads[portal.frame],math.floor((-camera.x + ((32 * 4) + self.x)) * x_scale),math.floor((-camera.y + ((32 * 4) + self.y)) * y_scale),0,x_scale,y_scale,4,4)
  end
end

function portal:update(dt)
  --print(camera.x.." : "..camera.y)
  portal.camera_x = (-camera.x + ((32 * 4) + self.x))
  portal.camera_y = (-camera.y + ((32 * 4) + self.y))
  if self.dt > 0.2 then
    self.dt = 0.00
    if portal.frame == 3 then
      portal.frame = 1
    else 
      portal.frame = portal.frame + 1
    end
  else 
    self.dt = self.dt + dt
  end
end

function portal.new(type,x,y)
  local p = {}
  p.type = "portal_enemy"
  p.dt = 0
  p.x = 0
  p.y = 0
  p.z_index = -1
  p.update = portal.update
  p.draw = portal.draw
  return p
end

return portal
