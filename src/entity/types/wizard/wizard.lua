local wizard = {}

--wizard.spritesheet = love.graphics.newImage("entity/types/wizard/wizard.png")
--wizard.spritesheet:setFilter("nearest","nearest")
wizard.walk = {}
wizard.walk.left = {x=0,y=0,framecount=3}
wizard.walk.right = {x=16*3,y=0,framecount=3}
wizard.walk.down = {x=0,y=32,framecount=3}
wizard.walk.up = {x=16*3,y=32,framecount=3}
wizard.walk_quads = {}


--[[for i,v in pairs(wizard.walk) do
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
end--]]

function wizard:mousepressed(x,y,button)

end

function wizard:draw()
  local frame = 2
  if self.walking then
    frame = math.floor((self.dt * 10) % self.dir + 1)
  end
 --love.graphics.drawq( wizard.spritesheet, #self.dir[frame], (self.x - camera.x - map.graphics.width) * 4, (self.y - camera.y - map.graphics.height - 4) * 4, 0, 4, 4, 8, 24 )
end

function wizard:update(dt)
  --[[self.dt = self.dt + dt
  self.walking = false
  local previousX = self.x
  local previousY = self.y
  if love.keyboard.isDown("left","a") then
    self.dir = wizard.walk_quads.left
    self.walking = true
    self.x = self.x - wizard.speed*dt
  elseif love.keyboard.isDown("right","d") then
    self.dir = wizard.walk_quads.right
    self.walking = true
    self.x = self.x + wizard.speed*dt
  elseif love.keyboard.isDown("up","w") then
    self.dir = wizard.walk_quads.up
    self.walking = true
    self.y = self.y - wizard.speed*dt
  elseif love.keyboard.isDown("down","s") then
    self.dir = wizard.walk_quads.down
    self.walking = true
    self.y = self.y + wizard.speed*dt
  end
  
  
  
  camera.x = self.x - camera.width / 2 * map.graphics.width
  camera.y = self.y - camera.height / 2 * map.graphics.height]]--
  
end


function wizard.new()
  local e = {}
  e.type = "wizard"
  e.dt = 0
  e.walking = false
  e.screen_x = love.graphics.getWidth()/2
  e.screen_y = love.graphics.getHeight()/2
  e.x = 30 
  e.y = 200 
  e.draw = wizard.draw
  e.update = wizard.update
  e.geteffect = wizard.geteffect
  e.getmodifier = wizard.getmodifier
  wizard.effect = 1
  wizard.modifier = 25
  wizard.speed = 50
  e.dir = wizard.walk_quads.down
  return e
end

function wizard:geteffect()
  return self.effect
end

function wizard:getmodifier()
  return self.modifier
end

return wizard
