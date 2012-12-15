 local slowtrap = {}

function slowtrap:update(dt)
  self.x = self.x
  self.y = self.y
end

function slowtrap:draw()
  love.graphics.print("slowtrap",self.x,self.y)
end

function slowtrap:keypressed(key,unicode)

end

function slowtrap.new()
  local e = {}
  e.type = "slowtrap"
  e.x = player.x
  e.y = player.y
  e.update = slowtrap.update
  e.draw = slowtrap.draw
  
  return e
end

function slowtrap.gethealth()

end

return slowtrap
