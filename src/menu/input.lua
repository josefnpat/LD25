local input = {}

input.sfx_fail = love.audio.newSource("menu/input_sfx/fail.wav")
input.sfx_succes = love.audio.newSource("menu/input_sfx/succes.wav")
input.bg = love.graphics.newImage("menu/assets/bg.png")
input.bg:setFilter("nearest","nearest")

function input.init(question)
input.question = question 
input.line = ""
end

function input.give(char)
input.line = input.line .. char
end

function input.remove()
input.line = string.sub(input.line, 1, -2)
end

function input.submit()
if string.len(input.line) > 1 then 
    input.sfx_succes:stop()
    input.sfx_succes:play()
    return true,input.line 
  else
    input.sfx_fail:stop()
    input.sfx_fail:play()
    return false 
  end
end

function input.draw()
love.graphics.draw(input.bg,0,0,0,love.graphics.getWidth() / win.img:getWidth(),love.graphics.getHeight() / win.img:getHeight())
love.graphics.setColor(0,0,0,150)
love.graphics.rectangle("fill",love.graphics.getWidth() / 2 - 250,love.graphics.getHeight() / 2 - 70,500,140)
love.graphics.setColor(255,255,255,255)
love.graphics.rectangle("line",love.graphics.getWidth() / 2 - 250,love.graphics.getHeight() / 2 - 70,500,140)
love.graphics.print(input.question, love.graphics.getWidth() / 2 - 230, love.graphics.getHeight() / 2 - 50)
if love.timer.getTime() % 2 > 1 then
love.graphics.print("> " .. input.line .. "|", love.graphics.getWidth() / 2 - 230, love.graphics.getHeight() / 2 + 30) 
else
love.graphics.print("> " .. input.line, love.graphics.getWidth() / 2 - 230, love.graphics.getHeight() / 2 + 30) 
end
love.graphics.setColor(255,255,255,255)
end

return input
