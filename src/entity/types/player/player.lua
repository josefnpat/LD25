local player = {}

player.spritesheet = love.graphics.newImage("entity/types/player/player.png")
player.spritesheet:setFilter("nearest","nearest")
player.walk = {}
player.walk.left = {x=0,y=0,framecount=3}
player.walk.right = {x=16*3,y=0,framecount=3}
player.walk.down = {x=0,y=32,framecount=3}
player.walk.up = {x=16*3,y=32,framecount=3}
player.walk_quads = {}
player.speed = 100
player.traps = {}
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
    self.dir = player.walk_quads.left
    self.walking = true
    self.x = self.x - player.speed*dt
  elseif love.keyboard.isDown("right","d") then
    self.dir = player.walk_quads.right
    self.walking = true
    self.x = self.x + player.speed*dt
  elseif love.keyboard.isDown("up","w") then
    self.dir = player.walk_quads.up
    self.walking = true
    self.y = self.y - player.speed*dt
  elseif love.keyboard.isDown("down","s") then
    self.dir = player.walk_quads.down
    self.walking = true
    self.y = self.y + player.speed*dt
  end
  
  if Dungeon.map[math.floor(self.x / 16)][math.floor(self.y / 16)] ~= Tiles.Floor and 
     Dungeon.map[math.floor(self.x / 16)][math.floor(self.y / 16)] ~= Tiles.Door then
    self.x = previousX
    self.y = previousY
  end
  
  camera.x = self.x - camera.width / 2 * map.graphics.width
  camera.y = self.y - camera.height / 2 * map.graphics.height
  
end

function player:keyreleased(key)
  if key == "1" then
    local temp = entity.new("slowtrap")
    temp.x = camera.x
    temp.y = camera.y
    table.insert(player.traps,temp)
  end
end

function player.new()
  local e = {}
  e.type = "player"
  e.dt = 0
  e.walking = false
  e.screen_x = love.graphics.getWidth()/2
  e.screen_y = love.graphics.getHeight()/2
  e.x = 16 * 16 -- start x * tile width * scale
  e.y = 16 * 16 -- start y * tile height * scale
  e.draw = player.draw
  e.mousepressed = player.mousepressed
  e.update = player.update
  e.dir = player.walk_quads.down
  e.keyreleased = player.keyreleased
  return e
end

return player
