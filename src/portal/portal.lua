local portal = {}

function portal.load()

end

function portal:draw()
  love.graphics.rectangle('fill',self.x,self.y,10,10)
end

function portal:update(dt)
  
end

function portal:keypressed(key,uni)

end

function portal:mousereleased(x,y,b)

end

function portal.new(type,x,y)
  local p = {}
  p.type = type
  p.x = x
  p.y = y
  p.update = portal.update
  p.draw = portal.draw
  return p
end

return portal