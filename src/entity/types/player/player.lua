local player = {}

player.spritesheet = love.graphics.newImage("entity/types/player/player.png")
player.spritesheet:setFilter("nearest","nearest")

player.walk = {}
player.walk.left = {x=0,y=0,framecount=3}
player.walk.right = {x=16*3,y=0,framecount=3}
player.walk.down = {x=0,y=32,framecount=3}
player.walk.up = {x=16*3,y=32,framecount=3}
player.walk_quads = {}

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
  self.dt = self.dt + dt
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

function player:keyreleased(key)
  if key == "1" then
    local temp = entity.new("slowtrap")
    temp.x,temp.y = entity.RawToTile(player_obj)
    table.insert(self.traps,temp)
  elseif key == "2" then
    local temp = entity.new("spiketrap")
    temp.x,temp.y = entity.RawToTile(player_obj)
    table.insert(self.traps,temp)
  elseif key == " " and (self.isCarryingPrincess or entity.distance(self, prin) < 16) then   --debug
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
  return e
end

return player
