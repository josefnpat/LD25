entity = require("entity")

function love.load()
  entity.load()
  
  local temp = entity.new("player")
  
  local temp = entity.new("enemy")
  
  local temp2 = entity.new("enemy")

  temp2.x = 300
  temp2.y = 300
  
end

function love.update(dt)
  entity.update(dt)
end

function love.draw()
  entity.draw()
end

function love.mousepressed(x,y,button)
  entity.mousepressed(x,y,button)
end

function love.keypressed(key,unicode)
  entity.keypressed(key,unicode)
end

function love.keyreleased(key,unicode)
  entity.keyreleased(key,unicode)
end
