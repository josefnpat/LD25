local enemy = {}

pathfind = require "entity/pathfind" -- 1/3

enemy.speedvals = {}
enemy.speedvals.slow = 0.5
enemy.speedvals.medium = 2
enemy.speedvals.fast = 4

function enemy:update(dt)

  self:path_update(dt,prin) -- 2/3

  self.hasted = false
  for _,v in ipairs(enemies) do
    local dist = entity.distance(self,v)
    if dist < v.range and dist ~=0  then
      if v.type == "wizard" then
        self.hasted = true
      end
    end
  end

  self.slowed = false
  for _,v in ipairs(player_obj.traps) do
    local dist = entity.distance(self,v)
    if dist < v.range and dist ~=0 then
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

  --debug
  if self.speed == enemy.speedvals.medium   then
    love.graphics.setColor(250,0,0)
  elseif self.speed == enemy.speedvals.slow then
    love.graphics.setColor(0,191,255)
  elseif self.speed == enemy.speedvals.fast then
    love.graphics.setColor(255,105,180)
  else
    love.graphics.setColor(255,255,255)
  end

  local hstr = string.format("%02d",self.health)
  local x,y = entity.getScreenLocation(self)
  --love.graphics.drawq(self.sprite.sheet,self.dir[frame], x,y,0,4,4,8,24)
  love.graphics.circle("line",x,y,self.range)
  love.graphics.print(hstr,x,y)
  love.graphics.setColor(255,255,255)
  
end

function enemy:keypressed(key,unicode)

end

function enemy.new()
  local e = {}
  pathfind.init(e) -- 3/3
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
  e.speed = enemy.speedvals.medium 
  e.range = 16
  e.weapon_power = 10
  e.slowed = false
  e.hasted = false
  e.update = enemy.update
  e.draw = enemy.draw
  e.slow = enemy.slow
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

return enemy
