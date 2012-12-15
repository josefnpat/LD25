local portal = {}

function portal:draw()
  if self.type == "portal_enemy" then
    love.graphics.rectangle('fill',self.x,self.y,10,10)
  elseif self.type == "portal_player" then
    love.graphics.rectangle('line',self.x,self.y,10,10)
  end
end

function portal:update(dt)
  
end

function portal.new(type,x,y)
  local p = {}
  p.type = "portal_enemy"
  p.x = 0
  p.y = 0
  p.update = portal.update
  p.draw = portal.draw
  return p
end

return portal
