local player = {}

player.spritesheet = love.graphics.newImage("entity/types/player/player.png")
player.spritesheet:setFilter("nearest","nearest")

player.walk = {}
player.walk.left = {x=0,y=0,framecount=3}
player.walk.right = {x=16*3,y=0,framecount=3}
player.walk.down = {x=0,y=32,framecount=3}
player.walk.up = {x=16*3,y=32,framecount=3}
player.walk_quads = {}


player.flames = {}

player.flames_cooldown = 1
player.flames_cooldown_init = 1
player.spiketraps_cooldown = 2
player.spiketraps_cooldown_init = 2
player.slowtraps_cooldown = 3
player.slowtraps_cooldown_init = 3

player.coolDown = 0
player.flameCost = 10

player.carry = {}
player.carry.left = {x=0,y=32*2,framecount=3}
player.carry.right = {x=16*3,y=32*2,framecount=3}
player.carry.down = {x=0,y=32*3,framecount=3}
player.carry.up = {x=16*3,y=32*3,framecount=3}
player.carry_quads = {}

player.speed = 100

local real_frame

for i,v in pairs(player.walk) do
  player.walk_quads[i] = {}
  for frame = 1,v.framecount+1 do
    if frame == 4 then
      real_frame = 2
    else
      real_frame = frame
    end
    local quad = love.graphics.newQuad( v.x+16*(real_frame-1), v.y, 16, 32, player.spritesheet:getWidth(),player.spritesheet:getHeight() )
    table.insert(player.walk_quads[i],quad)
  end
end

for i,v in pairs(player.carry) do
  player.carry_quads[i] = {}
  for frame = 1,v.framecount+1 do
    if frame == 4 then
      real_frame = 2
    else
      real_frame = frame
    end
    local quad = love.graphics.newQuad( v.x+16*(real_frame-1), v.y, 16, 32, player.spritesheet:getWidth(),player.spritesheet:getHeight() )
    table.insert(player.carry_quads[i],quad)
  end
end

function player:draw()
  local frame = 2
  if self.walking then
    frame = math.floor((self.dt * 10) % #self.dir + 1)
  end
  local x,y = entity.getScreenLocation(self)
  love.graphics.drawq( player.spritesheet, self.dir[frame], x, y, 0, 4, 4, 9, 28 )
end

function player:update(dt)

  player.flames_cooldown = player.flames_cooldown - dt
  if player.flames_cooldown < 0 then
    player.flames_cooldown = 0
  end
  player.spiketraps_cooldown = player.spiketraps_cooldown - dt
  if player.spiketraps_cooldown < 0 then  
    player.spiketraps_cooldown = 0
  end
  player.slowtraps_cooldown = player.slowtraps_cooldown - dt
  if player.slowtraps_cooldown < 0 then
    player.slowtraps_cooldown = 0
  end

  if self.health < 0 then
    self.die = true
  end
  self.dt = self.dt + dt
  player.coolDown = player.coolDown - 1
  self.walking = false
  local previousX = self.x
  local previousY = self.y
  if love.keyboard.isDown("left","a") then
    self.dir_name = "left"
    if self.isCarryingPrincess then
      self.dir = player.carry_quads.left
    else
      self.dir = player.walk_quads.left
    end
    self.walking = true
    self.x = self.x - player.speed*dt
  end
  if love.keyboard.isDown("right","d") then
    self.dir_name = "right"
    if self.isCarryingPrincess then
      self.dir = player.carry_quads.right
    else
      self.dir = player.walk_quads.right
    end
    self.walking = true
    self.x = self.x + player.speed*dt
  end
  if love.keyboard.isDown("up","w") then
    self.dir_name = "up"
    if self.isCarryingPrincess then
      self.dir = player.carry_quads.up
    else
      self.dir = player.walk_quads.up
    end
    self.walking = true
    self.y = self.y - player.speed*dt
  end
  if love.keyboard.isDown("down","s") then
    self.dir_name = "down"
    if self.isCarryingPrincess then
      self.dir = player.carry_quads.down
    else
      self.dir = player.walk_quads.down
    end
    self.walking = true
    self.y = self.y + player.speed*dt
  end
  
  if love.keyboard.isDown("lshift","3") then
    if player.flames_cooldown == 0 then
      player.flames_cooldown = player.flames_cooldown_init
      player:shoot(self.dir_name,self.x,self.y)
    end
  end
  
  if entity.collision(self) then
    self.x = previousX
    self.y = previousY
  end
  
  camera.x = self.x - (camera.width / 2) * map.graphics.width
  camera.y = self.y - (camera.height / 2) * map.graphics.height
  local p_portal = {}
  --p_portal.x = ((playerportal_obj.x * map.graphics.width) - map.graphics.width) + 32
  --p_portal.y= ((playerportal_obj.y * map.graphics.height) - map.graphics.height) + 10
  
  if counter.count == 0 and entity.distance(self,playerportal_obj) < 16  and self.isCarryingPrincess then
    state = "win"
  else
    self.game_status = "current"
  end 
end

function player:shoot(dir,x,y)
  if player.coolDown < 0 then
    local c = #player.flames + 1
    player.flames[c] = entity.new("flame")
    player.flames[c].dir = dir
    player.flames[c].x = x
    player.flames[c].y = y
    player.coolDown = player.flameCost 
  end
end

function player:keyreleased(key)

  px,py = entity.RawToTile(player_obj)
  local at_empty_tile = true
  for i,v in ipairs(entity.data) do
    local x,y = entity.RawToTile(v)
    if x == px and y == py and player_obj ~= v then
      if v.type == "portal" or v.type == "slowtrap" or v.type == "spiketrap" then
        at_empty_tile = false
      end
    end
  end
  
  if key == "1" then
    if player.slowtraps_cooldown == 0 then
      player.slowtraps_cooldown = player.slowtraps_cooldown_init
      if at_empty_tile then
        local temp = entity.new("slowtrap")
        temp.x,temp.y = px,py
        table.insert(self.traps,temp)
      end
    end
  elseif key == "2" then
    if player.spiketraps_cooldown == 0 then
      player.spiketraps_cooldown = player.spiketraps_cooldown_init
      if at_empty_tile then
        local temp = entity.new("spiketrap")
        temp.x,temp.y = px,py
        table.insert(self.traps,temp)
      end
    end
  elseif key == " " and (self.isCarryingPrincess or entity.distance(self, prin) < 16) and not enemy_has_princess then   --debug
    self.isCarryingPrincess = not self.isCarryingPrincess
    if self.isCarryingPrincess then
      self.dir = player.carry_quads[self.dir_name]
    else
      self.dir = player.walk_quads[self.dir_name]
    end
    prin.captive = not prin.captive
  end
end

function player.new()
  local e = {}
  e.type = "player"
  e.dt = 0
  e.walking = false
  e.health = 999
  e.isCarryingPrincess = false
  e.screen_x = love.graphics.getWidth()/2
  e.screen_y = love.graphics.getHeight()/2
  e.x,e.y = entity.MapToRaw(map.mapHeight/2+0.5,map.mapHeight/2+0.5)
  e.draw = player.draw
  e.mousepressed = player.mousepressed
  e.update = player.update
  e.dir = player.walk_quads.down
  e.dir_name = "down"
  e.keyreleased = player.keyreleased
  e.z_index = 2
  e.game_status = "current"
  e.traps = {}
  e.die = false 
  return e
end

return player
