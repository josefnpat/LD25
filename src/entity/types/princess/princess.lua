local princess = {}

function princess:draw()
  local quad = love.graphics.newQuad(0, 0,
             self.sprite.width,
             self.sprite.height,
             self.sprite.sheet:getWidth(),
             self.sprite.sheet:getHeight())
  love.graphics.drawq(self.sprite.sheet, quad,
             (self.camera.x * self.scale.x),
             (self.camera.y * self.camera.y),
             0,
             self.scale.x,
             self.scale.y,
             8,
             24)
end

function princess:update(dt)
  self.camera.x = (-camera.x + ((33 * 4) + self.x))
  self.camera.y = (-camera.y + ((32 * 4) + self.y))
end

function princess.new()
  local prin = {}
  prin.type = "princess"
  prin.x = 10
  prin.y = 10
  prin.camera = {}
  -- Start next to player.
  prin.camera.x = ((map.mapWidth / 2) + 0.5) * 16
  prin.camera.y = ((map.mapHeight / 2) + 0.5) * 16
  prin.update = princess.update
  prin.draw = princess.draw
  prin.sprite = {}
  prin.sprite.sheet = love.graphics.newImage("entity/types/princess/princess.png")
  prin.sprite.width = 16
  prin.sprite.height = 32
  prin.scale = {}
  prin.scale.x = 4
  prin.scale.y = 4

  return prin
end

return princess