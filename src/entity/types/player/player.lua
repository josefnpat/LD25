local player = {}

function player:mousepressed(x,y,button)
  self.x = x
  self.y = y
end

function player:draw()
  love.graphics.print("player",self.x,self.y)
end

function player.new()
  local e = {}
  e.type = "player"
  e.x = 0
  e.y = 0
  e.draw = player.draw
  e.mousepressed = player.mousepressed
  return e
end

return player
