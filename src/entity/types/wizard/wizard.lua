local wizard = {}

wizard.spritesheet = love.graphics.newImage("entity/types/wizard/wizard.png")
wizard.spritesheet:setFilter("nearest","nearest")

wizard.walk = {}
wizard.walk.left = {x=0,y=0,framecount=3}
wizard.walk.right = {x=16*3,y=0,framecount=3}
wizard.walk.down = {x=0,y=32,framecount=3}
wizard.walk.up = {x=16*3,y=32,framecount=3}
wizard.walk_quads = {}

wizard.carry = {}
wizard.carry.left = {x=0,y=32*2,framecount=3}
wizard.carry.right = {x=16*3,y=32*2,framecount=3}
wizard.carry.down = {x=0,y=32*3,framecount=3}
wizard.carry.up = {x=16*3,y=32*3,framecount=3}
wizard.carry_quads = {}

local real_frame

for i,v in pairs(wizard.walk) do
  wizard.walk_quads[i] = {}
  for frame = 1,v.framecount+1 do
    if frame == 4 then
      real_frame = 2
    else
      real_frame = frame
    end
    local quad = love.graphics.newQuad( v.x+16*(real_frame-1), v.y, 16, 32, wizard.spritesheet:getWidth(),wizard.spritesheet:getHeight() )
    table.insert(wizard.walk_quads[i],quad)
  end
end

pathfind = require "entity/pathfind" -- 1/3

wizard.speedvals = {}
wizard.speedvals.slow = 1
wizard.speedvals.medium = 2

function wizard:update(dt)
  if self.health < 0 then
    self.die = true
  end
  if player_obj.isCarryingPrincess and entity.distance(self,player_obj) < 32 then
    player_obj.isCarryingPrincess = false
    prin.captive = false
  end
  
  if enemy_has_princess then
    self:path_update(dt,player_obj) -- 2/3
  else
    self:path_update(dt,prin) -- 2/3
  end
  
  self.dt = self.dt + dt
  
  self.dir = wizard.walk_quads[self.dir_name]
  
  self.slowed = false
  for _,v in pairs(player_obj.traps) do
    local dist = entity.distance(self,v)
    if dist < 16 and dist ~=0 then
      if v.type == "slowtrap" then
        self.slowed = true     
      elseif v.type == "spiketrap" then
        self.health = self.health - 20*dt
      end
    end
  end

  if self.slowed then
    self.speed = wizard.speedvals.slow
  else
    self.speed = wizard.speedvals.medium
  end
  
end

function wizard:draw()
  local frame = 2
  if self.walking then
    frame = math.floor((self.dt * 10) % #self.dir + 1)
  end
  local x,y = entity.getScreenLocation(self)
  love.graphics.drawq( wizard.spritesheet, self.dir[frame], x, y, 0, 4, 4, 9, 28 )
  
  love.graphics.setColor(0,0,0)
  love.graphics.rectangle("fill",x-32,y+16,64,4)
  love.graphics.setColor(255,0,0)
  love.graphics.rectangle("fill",x-32,y+16,64*self.health/100,4)
  love.graphics.setColor(255,255,255)
  
end

function wizard.new()
  local e = {}
  pathfind.init(e) -- 3/3
  e.type = "wizard"
  e.health = 100
  e.x = player_obj.x + math.random(-100,100)
  e.y = player_obj.y + math.random(-100,100)
  e.dir = wizard.walk_quads.down
  e.dir_name = "down"
  e.speed = wizard.speedvals.medium 
  e.range = 100
  e.slowed = false
  e.update = wizard.update
  e.draw = wizard.draw
  e.dt = 0
  e.die = false
  return e
end

return wizard
