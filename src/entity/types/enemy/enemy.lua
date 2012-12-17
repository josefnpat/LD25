local enemy = {}

enemy.spritesheet = love.graphics.newImage("entity/types/enemy/enemy.png")
enemy.spritesheet:setFilter("nearest","nearest")

enemy.walk = {}
enemy.walk.left = {x=0,y=0,framecount=3}
enemy.walk.right = {x=16*3,y=0,framecount=3}
enemy.walk.down = {x=0,y=32,framecount=3}
enemy.walk.up = {x=16*3,y=32,framecount=3}
enemy.walk_quads = {}

enemy.carry = {}
enemy.carry.left = {x=0,y=32*2,framecount=3}
enemy.carry.right = {x=16*3,y=32*2,framecount=3}
enemy.carry.down = {x=0,y=32*3,framecount=3}
enemy.carry.up = {x=16*3,y=32*3,framecount=3}
enemy.carry_quads = {}

local real_frame

for i,v in pairs(enemy.walk) do
  enemy.walk_quads[i] = {}
  for frame = 1,v.framecount+1 do
    if frame == 4 then
      real_frame = 2
    else
      real_frame = frame
    end
    local quad = love.graphics.newQuad( v.x+16*(real_frame-1), v.y, 16, 32, enemy.spritesheet:getWidth(),enemy.spritesheet:getHeight() )
    table.insert(enemy.walk_quads[i],quad)
  end
end

for i,v in pairs(enemy.carry) do
  enemy.carry_quads[i] = {}
  for frame = 1,v.framecount+1 do
    if frame == 4 then
      real_frame = 2
    else
      real_frame = frame
    end
    local quad = love.graphics.newQuad( v.x+16*(real_frame-1), v.y, 16, 32, enemy.spritesheet:getWidth(),enemy.spritesheet:getHeight() )
    table.insert(enemy.carry_quads[i],quad)
  end
end

pathfind = require "entity/pathfind" -- 1/3

enemy.speedvals = {}
enemy.speedvals.slow = 0.5
enemy.speedvals.medium = 2
enemy.speedvals.fast = 4

function enemy:update(dt)
  self:path_update(dt,prin) -- 2/3

  self.dt = self.dt + dt
  
  self.dir = enemy.walk_quads[self.dir_name]
  
  self.hasted = false
  for _,v in ipairs(enemies) do
    local dist = entity.distance(self,v)
    if dist < self.range and dist ~=0  then
      if v.type == "wizard" then
        self.hasted = true
      end
    end
  end

  self.slowed = false
  for _,v in ipairs(player_obj.traps) do
    local dist = entity.distance(self,v)
    if dist < 16 and dist ~=0 then
      if v.type == "slowtrap" then
        self.slowed = true     
      elseif v.type == "spiketrap" then
        self.health = self.health - 20*dt
      end
    end
  end

  if self.slowed and self.hasted then
    self.speed = enemy.speedvals.medium
  elseif self.slowed then
    self.speed = enemy.speedvals.slow
  elseif self.hasteed then
    self.speed = enemy.speedvals.fast
  else
    self.speed = enemy.speedvals.medium
  end
  
end

function enemy:draw()

  local frame = 2
  if self.walking then
    frame = math.floor((self.dt * 10) % #self.dir + 1)
  end
  local x,y = entity.getScreenLocation(self)
  love.graphics.drawq( enemy.spritesheet, self.dir[frame], x, y, 0, 4, 4, 9, 28 )

  local hstr = string.format("%02d",self.health)
  local x,y = entity.getScreenLocation(self)
  --love.graphics.drawq(self.sprite.sheet,self.dir[frame], x,y,0,4,4,8,24)
  love.graphics.print(self.health,x,y)
  love.graphics.setColor(255,255,255)
  
end

function enemy.new()
  local e = {}
  pathfind.init(e) -- 3/3
  e.type = "enemy"
  e.health = 100
  e.x = player_obj.x + math.random(-100,100)
  e.y = player_obj.y + math.random(-100,100)
  e.dir = enemy.walk_quads.down
  e.dir_name = "down"
  e.speed = enemy.speedvals.medium 
  e.range = 100
  e.slowed = false
  e.hasted = false
  e.update = enemy.update
  e.draw = enemy.draw
  e.dt = 0
  return e
end

return enemy
