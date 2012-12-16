local enemy = {}
x_scale = 4
y_scale = 4

function enemy:update(dt)
  self.camera_x = (-camera.x + ((32 * 4) + self.x))
  self.camera_y = (-camera.y + ((32 * 4) + self.y))
end

function enemy:draw()
  local rad = 100
  local something_is_near = false
  for _,v in ipairs(enemies) do
    local dist = entity.distance(self,v)
    if dist < rad and dist ~=0 then
      something_is_near = true
    end
  end
  
  if something_is_near then
    love.graphics.setColor(250,0,0)
  else
    love.graphics.setColor(255,255,255)
  end
  
  love.graphics.print("enemy",(self.camera_x * x_scale),(self.camera_y * y_scale))
  love.graphics.circle("line",(self.camera_x * x_scale),(self.camera_y * y_scale),rad*2)
  love.graphics.setColor(255,255,255)
  
end

function enemy:keypressed(key,unicode)

end

function enemy.new()
  local e = {}
  e.type = "enemy"
  enemy.health = 100
  enemy.speed = 25
  e.x = 512 + math.random(-100,100)
  e.y = 512 + math.random(-100,100)
  e.camera_x = 0
  e.camera_y = 0
  e.update = enemy.update
  e.draw = enemy.draw
  e.keypressed = enemy.keypressed
  return e
end

function enemy:gethealth()
  return self.health
end

function enemy:hit(pow)
  self.health = self.health - pow
end
 
function applyeffect(effect)
end

return enemy
