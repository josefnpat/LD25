local player = {}



player.spritesheet = love.graphics.newImage("types/player/player.png")
player.walk = {}
player.walk.left = {x=0,y=0,framecount=3}
player.walk.right = {x=16*3,y=0,framecount=3}
player.walk.down = {x=0,y=32,framecount=3}
player.walk.up = {x=16*3,y=32,framecount=3}
player.walk_quads = {}
for i,v in pairs(player.walk) do
  player.walk_quads[i] = {}
  for frame = 1,v.framecount do
    local quad = love.graphics.newQuad( v.x+16*(frame-1), v.y, 16, 32, player.spritesheet:getWidth(),player.spritesheet:getHeight() )
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
  love.graphics.drawq( player.spritesheet, self.dir[frame], self.screen_x, self.screen_y, 0, 1, 1, 8, 24 )
end

function player:update(dt)
  self.dt = self.dt + dt
  self.walking = false
  if love.keyboard.isDown("left") then
    self.dir = player.walk_quads.left
    self.walking = true
  elseif love.keyboard.isDown("right") then
    self.dir = player.walk_quads.right
    self.walking = true
  elseif love.keyboard.isDown("up") then
    self.dir = player.walk_quads.up
    self.walking = true
  elseif love.keyboard.isDown("down") then
    self.dir = player.walk_quads.down
    self.walking = true
  end
end

function player.new()
  local e = {}
  e.type = "player"
  e.dt = 0
  e.walking = false
  e.screen_x = love.graphics.getWidth()/2
  e.screen_y = love.graphics.getHeight()/2
  e.draw = player.draw
  e.mousepressed = player.mousepressed
  e.update = player.update
  e.dir = player.walk_quads.down
  return e
end

return player
