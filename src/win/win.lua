win = {}

win.dt = 0

function win.draw()
  love.graphics.setColor(255,255,255)
  love.graphics.printf("YOU WON THE GAME!!",0,love.graphics.getHeight()/2,love.graphics.getWidth(),"center")
end

function win.update(dt)
  win.dt = win.dt + dt
end

function win.keypressed(key)
  if win.dt > 2 then
    state = "menu"
  end
end

return win
