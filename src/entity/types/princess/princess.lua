local princess = {}

function princess:draw()
  if self.captive == false then
    local frame = 2
    if self.walking then
      frame = math.floor((self.dt * 10) % #self.dir + 1)
    end
    love.graphics.drawq(self.sprite.sheet,
        self.dir[frame], 
        (self.x - camera.x - map.graphics.width) * 4,
        (self.y - camera.y - map.graphics.height - 4) * 4, 0, 4, 4, 8, 24 )
  end

--    love.graphics.drawq(self.sprite.sheet, self.quad,
--             (self.camera.x * self.scale.x),
--             (self.camera.y * self.scale.y),
--             0,
--             self.scale.x,
--             self.scale.y,
--             8,
--             24)
end

function princess:update(dt)
  self.dt = self.dt + dt
  if self.captive == false then
    self.walking = false
    self.camera.x = (-camera.x + self.x) - (self.sprite.width)/2
    self.camera.y = (-camera.y + self.y) - (self.sprite.height)/2

    -- For testing animations.

    if love.keyboard.isDown("h") then
      self.dir = self.walk_quads.left
      self.walking = true
      self.x = self.x - self.speed*dt
    elseif love.keyboard.isDown("j") then
      self.dir = self.walk_quads.down
      self.walking = true
      self.y = self.y + self.speed*dt
    elseif love.keyboard.isDown("k") then
      self.dir = self.walk_quads.up
      self.walking = true
      self.y = self.y - self.speed*dt
    elseif love.keyboard.isDown("l") then
      self.dir = self.walk_quads.right 
      self.walking = true
      self.x = self.x + self.speed*dt
    end

    -- Fill in wandering logic.
    
  else
    self.x = player_obj.x
    self.y = player_obj.y
  end
end

function princess.new()
  local prin = {}
  prin.type = "princess"
  prin.x = player_obj.x
  prin.y = player_obj.y
  prin.camera = {}
  -- Start next to player.
  prin.camera.x = 0
  prin.camera.y = 0
  prin.update = princess.update
  prin.draw = princess.draw
  prin.sprite = {}
  prin.sprite.sheet = love.graphics.newImage("entity/types/princess/princess.png")
  prin.sprite.sheet:setFilter("nearest","nearest")
  prin.sprite.width = 16
  prin.sprite.height = 32
  prin.scale = {}
  prin.scale.x = 4
  prin.scale.y = 4
  prin.captive = false
  prin.speed = 20
  prin.dt = 0

  prin.walk = {}
  prin.walk.left = {x=0,y=0,framecount=3}
  prin.walk.right = {x=16*3,y=0,framecount=3}
  prin.walk.down = {x=0,y=32,framecount=3}
  prin.walk.up = {x=16*3,y=32,framecount=3}
  prin.walk_quads = {}


  for i,v in pairs(prin.walk) do
    prin.walk_quads[i] = {}
    for frame = 1,v.framecount+1 do
      if frame == 4 then
        real_frame = 2
      else
        real_frame = frame
      end
      local quad = love.graphics.newQuad( v.x+16*(real_frame-1), v.y, 16, 32, prin.sprite.sheet:getWidth(),prin.sprite.sheet:getHeight() )
      table.insert(prin.walk_quads[i],quad)
    end
  end
  prin.dir = prin.walk_quads.down

  prin.quad = love.graphics.newQuad(0, 0,
             prin.sprite.width,
             prin.sprite.height,
             prin.sprite.sheet:getWidth(),
             prin.sprite.sheet:getHeight())


  return prin
end

return princess