local portal = {}

portal.sheet = map.graphics.sheet
portal.sheet:setFilter('nearest','nearest')

portal.frame = 1

portal.portal_quads = {}
portal.portal_quads[1] =  love.graphics.newQuad(32,64,32,32,map.graphics.sheet:getWidth(),map.graphics.sheet:getHeight())
portal.portal_quads[2] =  love.graphics.newQuad(64,64,32,32,map.graphics.sheet:getWidth(),map.graphics.sheet:getHeight())
portal.portal_quads[3] =  love.graphics.newQuad(96,64,32,32,map.graphics.sheet:getWidth(),map.graphics.sheet:getHeight())
portal.portal_quads[4] =  love.graphics.newQuad(0,80,16,32,map.graphics.sheet:getWidth(),map.graphics.sheet:getHeight())

function portal:draw()
  local x,y = entity.getScreenLocation(self)
  if self.owner == "enemy" then
    love.graphics.drawq(portal.sheet,portal.portal_quads[4],x,y,0,4,4)
  end
  if self.owner == "player" then
    if counter.get_time() ~= 0 then
      love.graphics.setColor(0,255,255)
    end
    love.graphics.drawq(portal.sheet,portal.portal_quads[portal.frame],x,y,0,4,4)
    love.graphics.setColor(255,255,255)
  end
end

function portal:update(dt)
  if self.dt > 0.2 then
    self.dt = self.dt - 0.2
    if portal.frame >= 3 then
      portal.frame = 1
    else 
      portal.frame = portal.frame + 1
    end
  else 
    self.dt = self.dt + dt
  end
end

function portal.new()
  local p = {}
  p.type = "portal"
  p.owner = "enemy"
  p.health = 999
  p.dt = 0
  p.x = 0
  p.y = 0
  p.z_index = -2
  p.update = portal.update
  p.draw = portal.draw
  return p
end

return portal
