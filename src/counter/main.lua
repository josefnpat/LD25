require('counter')

function love.load()
  counter.load()
end

function love.draw()
  -- draw(x_pos,y_pos,limit)
  counter.draw(10,10,100)
end

function love.update(dt)
  counter.update(dt)
end

function love.keypressed(key,uni)
  counter.set_time(20);
end

function love.mousereleased(x,y,b)

end