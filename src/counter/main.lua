require('counter')

function love.load()
  counter.load()
end

function love.draw()
  -- draw(x_pos,y_pos,width)
  counter.draw(10,10,400)
  if counter.get_time() == 0 then
    love.graphics.printf("Counter Reached 0 sec.",100,100,500,'center')
  end
end

function love.update(dt)
  counter.update(dt)
end

function love.keypressed(key,uni)
  counter.set_time(65);
end

function love.mousereleased(x,y,b)

end