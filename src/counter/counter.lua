counter = {}


function counter.load()
  counter.load_time = 0
  counter.x = x
  counter.y = y
  counter.h = h
  counter.w = w
  counter.count = 10
  counter.font = love.graphics.newFont(20)
  counter.color = {200,200,200,100}
  counter.bg_color = {0,0,0,60}
end

function counter.set_time(sec)
  counter.count = sec
end

function counter.get_time()
  return counter.count
end

function counter.set_color(color)
  counter.color = color
end

function counter.set_font(data,size)
  counter.font = love.graphics.newFont(data,size)
end

function counter.draw(x,y,w,h)
  love.graphics.setFont(counter.font)
  love.graphics.setColor(counter.color)
  minute = 0
  if math.floor(counter.count/60) > 0 then
    minute = math.floor(counter.count/60)
  end
  second = counter.count - (minute * 60)
  if minute > 0 then
    love.graphics.printf("Counter: "..minute.."min "..second.."sec",x,y,w,'left')
  else
    love.graphics.printf("Counter: "..second.."sec",x,y,w,'left')
  end
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