counter = {}


function counter.load()
  counter.load_time = 0
  counter.x = x
  counter.y = y
  counter.h = h
  counter.w = w
  counter.count = 70
  counter.font = love.graphics.newFont("counter/assets/spathaserif.ttf",26)
  counter.img = love.graphics.newImage("counter/assets/time.png")
  counter.img:setFilter("nearest","nearest")
  counter.color = {255,255,255}
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

function counter.draw()
  love.graphics.setFont(counter.font)
  love.graphics.setColor(counter.color)
  local minute = 0
  local strmin = "00"
  if math.floor(counter.count/60) > 0 then
    minute = math.floor(counter.count/60)
    strmin = string.format("%02d",minute)
  end
  second = counter.count - (minute * 60)
  strsec = string.format("%02d",second)
  love.graphics.draw(counter.img,love.graphics.getWidth()/2,0,0,4,4,32,0)
  if counter.count == 0 then
    love.graphics.printf("Portal Is Open!\nEscape!",0,12,love.graphics.getWidth(),"center")
  else
    love.graphics.printf("Portal Opens In:\n"..strmin..":"..strsec,0,12,love.graphics.getWidth(),"center")
  end
  love.graphics.setColor(255,255,255)
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

return counter
