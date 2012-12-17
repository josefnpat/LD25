lose = {}

function lose.draw()
  love.graphics.setColor(255,255,255)
  love.graphics.printf("YOU LOST THE GAME!!",0,love.graphics.getHeight()/2,love.graphics.getWidth(),"center")
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
