local flame = {}
flame.speed = 250


function flame:update(dt)
  if self.health < 0 then
    self.die = true
  end
self.dt = self.dt + dt
if self.dir == "down" then
self.y = self.y + flame.speed*dt
self.angle = math.rad(90)
end
if self.dir == "right" then
self.x = self.x + flame.speed*dt
self.angle = math.rad(0)
end
if self.dir == "up" then
self.y = self.y - flame.speed*dt
self.angle = math.rad(270)
end
if self.dir == "left" then
self.x = self.x - flame.speed*dt
self.angle = math.rad(180)
end

if entity.collision(self) then
    self.die = true
  end
  
 for _,v in ipairs(enemies) do
    local dist = entity.distance(self,v)
    if dist < 8 and dist ~=0  then
      v.health = v.health - self.weaponpower
      self.die = true
    end
  end
end

function flame:draw()
local x,y = entity.getScreenLocation(self)
love.graphics.drawq(map.graphics.sheet,map.quads[57],x,y - 32,self.angle,4,4,8,8)
end

function flame.new()
  local e = {}
  e.type = "flame"
  e.img = map.graphics.sheet
  e.img:setFilter('nearest','nearest')
  e.angle = 0
  e.health = 1
  e.weaponpower = 20
  e.quad = 57
  e.dt = 0
  e.x,e.y = 0,0
  e.draw = flame.draw
  e.update = flame.update
  e.dir = "down"
  e.die = false 
  return e
end

return flame
