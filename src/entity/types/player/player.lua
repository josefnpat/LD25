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
player.traps = {}

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

function player:mousepressed(x,y,button)

end

function player:draw()
  local frame = 2
  if self.walking then
    frame = math.floor((self.dt * 10) % #self.dir + 1)
  end
  love.graphics.drawq( player.spritesheet, self.dir[frame], (self.x - camera.x - map.graphics.width) * 4, (self.y - camera.y - map.graphics.height - 4) * 4, 0, 4, 4, 8, 24 )
end

function player:update(dt)
  self.dt = self.dt + dt
  self.walking = false
  local previousX = self.x
  local previousY = self.y
  if love.keyboard.isDown("left","a") then
    if self.isCarryingPrincess then
      self.dir = player.carry_quads.left
    else
      self.dir = player.walk_quads.left
    end
    self.walking = true
    self.x = self.x - player.speed*dt
  elseif love.keyboard.isDown("right","d") then
    if self.isCarryingPrincess then
      self.dir = player.carry_quads.right
    else
      self.dir = player.walk_quads.right
    end
    self.walking = true
    self.x = self.x + player.speed*dt
  elseif love.keyboard.isDown("up","w") then
    if self.isCarryingPrincess then
      self.dir = player.carry_quads.up
    else
      self.dir = player.walk_quads.up
    end
    self.walking = true
    self.y = self.y - player.speed*dt
  elseif love.keyboard.isDown("down","s") then
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
  
  camera.x = self.x - camera.width / 2 * map.graphics.width
  camera.y = self.y - camera.height / 2 * map.graphics.height
  
end

function dist(v1, v2)
  local sub = {}
  sub.x = v1.x - v2.x
  sub.y = v1.y - v2.y
  local len = sub.x*sub.x + sub.y*sub.y
  return len
end

function player:keyreleased(key)
  if key == "1" then
    local temp = entity.new("slowtrap")
    temp.x = camera.x
    temp.y = camera.y
    table.insert(player.traps,temp)
  elseif key == "p" and (self.isCarryingPrincess or dist(self, prin) < 200) then   --debug
    self.isCarryingPrincess = not self.isCarryingPrincess
    prin.captive = not prin.captive
  end
end

function player.new()
  local e = {}
  e.type = "player"
  e.dt = 0
  e.walking = false
  e.isCarryingPrincess = false
  e.screen_x = love.graphics.getWidth()/2
  e.screen_y = love.graphics.getHeight()/2
  e.x = ((map.mapWidth / 2) + 0.5) * 16 -- start x * tile width * scale
  e.y = ((map.mapHeight / 2) + 0.5) * 16 -- start y * tile height * scale
  e.draw = player.draw
  e.mousepressed = player.mousepressed
  e.update = player.update
  e.dir = player.walk_quads.down
  e.keyreleased = player.keyreleased
  return e
end

return player
