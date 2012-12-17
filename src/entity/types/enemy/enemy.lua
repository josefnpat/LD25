local enemy = {}


function enemy:update(dt)
  local rad = 100
  local wizard_is_near = false
  local trap_is_near = false
  for _,v in ipairs(enemies) do
    local dist = entity.distance(self,v)
    if dist < v.range and dist ~=0  then
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
    if dist < v.range and dist ~=0 then
      if v.type == "slowtrap" then
        self.slowed = true         
        trap_is_near = true
        --self:applyeffect(v:geteffect(),v:getmodifier())    
        if self.speed == 50 and self.hasted == false then  
          self.speed = 25
        elseif self.speed == 75 then
          self.speed = 50  
        end
      elseif v.type == "spiketrap" then
        self:ishit(v:getmodifier())
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
  local frame = 2
  if self.walking then
    frame = math.floor((self.dt * 10) % #self.dir + 1)
  end
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
  --leave these as well
 
  local str = string.format("%02d",self.speed)
  local hstr = string.format("%02d",self.health)
  local x,y = entity.getScreenLocation(self)
  love.graphics.drawq(self.sprite.sheet,self.dir[frame], x,y,0,4,4,8,24)
  love.graphics.circle("line",x,y,rad)
  --leave this in I'm going to need it for testing love, Cirrus
  love.graphics.print(str,x,y)
  --also, leave this 
  love.graphics.print(hstr,x,y)
  love.graphics.setColor(255,255,255)
  
end

function enemy:keypressed(key,unicode)

end

function enemy.new()
  local e = {}
  e.type = "enemy"
  e.health = 100
  e.x = player_obj.x + math.random(-100,100)
  e.y = player_obj.y + math.random(-100,100)
  e.sprite = {}
  e.walking = false
  e.sprite.sheet = love.graphics.newImage("entity/types/enemy/enemy.png")
  e.sprite.sheet:setFilter("nearest","nearest")
  e.sprite.width = 16
  e.sprite.height = 32
  e.speed = 50
  e.range = 999
  e.weapon_power = 10
  e.slowed = false
  e.hasted = false
  e.update = enemy.update
  e.draw = enemy.draw
  e.slow = enemy.slow
  e.applyeffect = enemy.applyeffect
  e.gethealth = enemy.gethealth
  e.keypressed = enemy.keypressed
  e.ishit = enemy.ishit
  e.dt = 0

  e.walk = {}
  e.walk.left = {x=0,y=0,framecount=3}
  e.walk.right = {x=16*3,y=0,framecount=3}
  e.walk.down = {x=0,y=32,framecount=3}
  e.walk.up = {x=16*3,y=32,framecount=3}
  e.walk_quads = {}

for i,v in pairs(e.walk) do
    e.walk_quads[i] = {}
    for frame = 1,v.framecount+1 do
      if frame == 4 then
        real_frame = 2
      else
        real_frame = frame
      end
      local quad = love.graphics.newQuad(v.x+16*(real_frame-1),
            v.y,
            16,
            32,
            e.sprite.sheet:getWidth(),
            e.sprite.sheet:getHeight())
      table.insert(e.walk_quads[i],quad)
    end
  end
  e.dir = e.walk_quads.down

  e.quad = love.graphics.newQuad(0, 0,
             e.sprite.width,
             e.sprite.height,
             e.sprite.sheet:getWidth(),
             e.sprite.sheet:getHeight())
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
