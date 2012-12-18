lose = {}

lose.img = love.graphics.newImage("lose/YOULOSE.png")
lose.img:setFilter("nearest","nearest")

function lose.draw()
  love.graphics.setColor(255,255,255)
  love.graphics.draw(lose.img,0,0,0,love.graphics.getWidth() / win.img:getWidth(),love.graphics.getHeight() / win.img:getHeight())
end

function lose.update(dt)
  win.dt = win.dt + dt
end

function lose.keypressed(key)
  if win.dt > 2 then
    state = "menu"
  end
end

return lose
