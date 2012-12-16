local enemy = {}
local x_scale = 4
local y_scale = 4

function enemy:update(dt)
  self.camera_x = (-camera.x + ((32 * 4) + self.x))
  self.camera_y = (-camera.y + ((32 * 4) + self.y))
  local rad = 100
  local wizard_is_near = false
  local trap_is_near = false
  for _,v in ipairs(enemies) do
    local dist = entity.distance(self,v)
    if dist < rad and dist ~=0  then
      if v.type == "wizard" then
        self.hasted = true        
        wizard_is_near = true  
        --self:applyeffect(v:geteffect(),v:getmodifier()) 
        if self.speed == 50 and self.slowed == false then  
          self.speed = 75
        elseif self.speed == 25 then
          self.speed = 50  
        end
      end
    end
  end

  for _,v in ipairs(player_obj.traps) do
    local dist = entity.distance(self,v)
    if dist < rad and dist ~=0 then
      if v.type == "slowtrap" then
        self.slowed = true         
        trap_is_near = true
        --self:applyeffect(v:geteffect(),v:getmodifier())    
        if self.speed == 50 and self.hasted == false then  
          self.speed = 25
        elseif self.speed == 75 then
          self.speed = 50  
        end
      end
    end
  end

  if not wizard_is_near and self.hasted == true then
   -- self:applyeffect(1,-25)
    if self.speed == 75 then  
      self.speed = 50
    elseif self.speed == 50 then
      self.speed = 25  
    end
  end
  if not trap_is_near and self.slowed == true then
    --self:applyeffect(1,25)
    if self.speed == 25 then  
      self.speed = 50
    elseif self.speed == 50 then
      self.speed = 75  
    end
  end
end

function enemy:draw()
  local rad = 100
  if self.speed == 50  then
    love.graphics.setColor(250,0,0)
  elseif self.speed == 25 then
    love.graphics.setColor(0,191,255)
  elseif self.speed == 75 then
    love.graphics.setColor(255,105,180)
  else
    love.graphics.setColor(255,255,255)
  end
 --[[ if self.slowed == true  then
    love.graphics.setColor(0,191,255)
  else
    love.graphics.setColor(255,255,255)
  end]]--
  local str = string.format("%02d",self.speed)
  love.graphics.print("enemy",(self.camera_x * x_scale),(self.camera_y * y_scale))
  love.graphics.circle("line",(self.camera_x * x_scale),(self.camera_y * y_scale),rad*2)
  love.graphics.print(str,(self.camera_x * x_scale)+12,(self.camera_y * y_scale)+12)
  love.graphics.setColor(255,255,255)
  
end

function enemy:keypressed(key,unicode)

end

function enemy.new()
  local e = {}
  e.type = "enemy"
  e.health = 100
  e.x = 512 + math.random(-100,100)
  e.y = 512 + math.random(-100,100)
  e.camera_x = 0
  e.camera_y = 0
  e.speed = 50
  e.slowed = false
  e.hasted = false
  e.update = enemy.update
  e.draw = enemy.draw
  e.slow = enemy.slow
  e.applyeffect = enemy.applyeffect
  e.gethealth = enemy.gethealth
  e.keypressed = enemy.keypressed
  return e
end

function enemy:gethealth()
  return self.health
end

function enemy:ishit(pow)
  self.health = self.health - pow
end
function enemy:slow()
  self.slowed = true
end
 
function enemy:applyeffect(effect,modifier)
  if effect == 1 then
    self.speed = self.speed + modifier 
  else
    self.speed = self.speed
  end

end



return enemy
