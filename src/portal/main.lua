portal = require('portal')

function love.load()
  portal.load()
  portal.new('enemy',20,20)
  portal.new('player',40,40)
end

function love.draw()
  -- draw(x_pos,y_pos,width)
  portal.draw()
end

function love.update(dt)
  portal.update(dt)
end

function love.keypressed(key,uni)
end

function love.mousereleased(x,y,b)
  portal.mousereleased(x,y,b)
end