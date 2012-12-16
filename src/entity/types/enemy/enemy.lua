local enemy = {}
  x_scale = 4
  y_scale = 4
function enemy:update(dt)
 self.camera_x = (-camera.x + ((32 * 4) + self.x))
 self.camera_y = (-camera.y + ((32 * 4) + self.y))
  for _,v in ipairs(enemies) do
    if entity.distance(self,v) < 300 then
	 love.graphics.setColor(250,67,200)
	 love.graphics.print("enemy",(self.camera_x * x_scale),(self.camera_y * y_scale))
	 love.graphics.setColor(255,255,255)
    end
  end
  
end
function enemy:draw()

  love.graphics.print("enemy",(self.camera_x * x_scale),(self.camera_y * y_scale))
  
end

function enemy:keypressed(key,unicode)

end

function enemy.new()
  local e = {}
  e.type = "enemy"
  enemy.health = 100
  enemy.speed = 25
  e.x = 512 + math.random(0,65)
  e.y = 512 + math.random(0,65)
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
