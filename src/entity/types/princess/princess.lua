local princess = {}

function princess:draw()
  love.graphics.drawq(self.sprite.sheet, self.quad,
             (self.camera.x * self.scale.x),
             (self.camera.y * self.scale.y),
             0,
             self.scale.x,
             self.scale.y,
             8,
             24)
end

function princess:update(dt)
  self.camera.x = (-camera.x + self.x)
  self.camera.y = (-camera.y + self.y)
  print ("!!!")
  print (self.camera.x)
  print (self.camera.y)
end

function princess.new()
  local prin = {}
  prin.type = "princess"
--  prin.x = ((map.mapWidth / 2) + 0.5) * 16
--  prin.y = ((map.mapHeight / 2) + 0.5) * 16
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

  prin.quad = love.graphics.newQuad(0, 0,
             prin.sprite.width,
             prin.sprite.height,
             prin.sprite.sheet:getWidth(),
             prin.sprite.sheet:getHeight())


  return prin
end

return princess