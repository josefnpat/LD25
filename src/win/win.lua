win = {}

win.dt = 0

win.sfx = love.audio.newSource("win/win.wav")
win.img = love.graphics.newImage("win/YOUWIN.png")
win.img:setFilter("nearest","nearest")

function win.draw()
  love.graphics.setColor(255,255,255)
  love.graphics.draw(win.img,0,0,0,love.graphics.getWidth() / win.img:getWidth(),love.graphics.getHeight() / win.img:getHeight())
end

function win.update(dt)
    if win.dt == 0 then
      love.audio.stop()
      win.sfx:play()
    end
  win.dt = win.dt + dt
end

function win.keypressed(key)
  if win.dt > 2 then
    state = "menu"
  end
end

return win
