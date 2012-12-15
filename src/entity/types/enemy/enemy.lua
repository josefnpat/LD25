local enemy = {}

function enemy:update(dt)
  self.x = (self.x + 100*dt) % 800
end

function enemy:draw()
  love.graphics.print("enemy",self.x,self.y)
end

function enemy:keypressed(key,unicode)
  self.x = math.random(0,800)
  self.y = math.random(0,600)
end

function enemy.new()
  local e = {}
  e.type = "enemy"
  e.x = 0
  e.y = 100
  e.update = enemy.update
  e.draw = enemy.draw
  e.keypressed = enemy.keypressed
  return e
end

return enemy
