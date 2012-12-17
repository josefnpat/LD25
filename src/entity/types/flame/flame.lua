local flame = {}
flame.speed = 250


function flame:update(dt)
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
    self.health = -1
  end
end

function flame:draw()
local x,y = entity.getScreenLocation(self)
love.graphics.drawq(map.graphics.sheet,map.quads[57],x,y,self.angle,4,4)
end

function flame.new()
  local e = {}
  e.type = "flame"
  e.img = map.graphics.sheet
  e.img:setFilter('nearest','nearest')
  e.angle = 0
  e.health = 1
  e.quad = 57
  e.dt = 0
  e.x,e.y = 0,0
  e.draw = flame.draw
  e.update = flame.update
  e.dir = "down"
  return e
end

return flame
