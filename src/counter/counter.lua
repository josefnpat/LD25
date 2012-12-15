counter = {}


function counter.load(x,y,l)
  counter.load_time = 0
  counter.x = x
  counter.y = y
  counter.l = l
  counter.count = 10
end

function counter.set_time(sec)
  counter.count = sec
end

function counter.get_time()
  return counter.count
end

function counter.draw(x,y,l)
  love.graphics.printf("Counter: "..counter.count,x,y,l,'left')
end

function counter.update(dt)
  if counter.load_time > 1 then
    counter.load_time = 0
    counter.count = counter.count - 1
  elseif counter.count < 1 then
    counter.count = 0
  else
    counter.load_time = counter.load_time + dt
  end
end

function counter.keypressed(key,uni)

end

function counter.mousepressed(x,y,b)

end