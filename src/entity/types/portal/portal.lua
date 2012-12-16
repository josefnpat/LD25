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
  local x_scale = 4
  local y_scale = 4

  if self.owner == "enemy" then
	love.graphics.drawq(
    portal.sheet,
    portal.portal_quads[4],
    ((self.x * map.graphics.width) - camera.x) * 4 - map.graphics.width * 4,
    ((self.y * map.graphics.height) - camera.y) * 4 - map.graphics.height * 8,
    0,
    x_scale,
    y_scale)
   end
   if self.owner == "player" then
	 if counter.get_time() == 0 then
	 love.graphics.drawq(
    portal.sheet,
    portal.portal_quads[portal.frame],
    ((self.x * map.graphics.width) - camera.x) * 4 - map.graphics.width * 4,
    ((self.y * map.graphics.height) - camera.y) * 4 - map.graphics.height * 8,
    0,
    x_scale,
    y_scale)
    else
	love.graphics.setColor(100,255,255)
	love.graphics.drawq(
    portal.sheet,
    portal.portal_quads[1],
    ((self.x * map.graphics.width) - camera.x) * 4 - map.graphics.width * 4,
    ((self.y * map.graphics.height) - camera.y) * 4 - map.graphics.height * 8,
    0,
    x_scale,
    y_scale)
	end
	love.graphics.setColor(255,255,255)
   end
end

function portal:update(dt)
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

function portal.new()
  local p = {}
  p.type = "portal"
  p.owner = "enemy"
  p.dt = 0
  p.x = 0
  p.y = 0
  p.z_index = -1
  p.update = portal.update
  p.draw = portal.draw
  return p
end

return portal
