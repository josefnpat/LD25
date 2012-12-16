debug = {}

function debug.draw()
  love.graphics.setColor(0,0,0,191)
  love.graphics.rectangle("fill",0,0,love.graphics.getWidth(),love.graphics.getHeight()/2)
  love.graphics.setColor(255,255,255)
  love.graphics.print("DEBUG MODE - "..love.timer.getFPS(),0,0)
  map.graphics.sheet:setFilter("nearest","nearest")
  local x_ret,y_ret = 1,0.5
  for i,v in ipairs(map.quads) do
    if x_ret > 13 then
      x_ret = 1
      y_ret = y_ret + 1
    end
    love.graphics.drawq(map.graphics.sheet,v,x_ret*16*4,y_ret*16*4,0,4,4)
    love.graphics.print(i,x_ret*16*4,y_ret*16*4)
    x_ret = x_ret + 1
  end
  
end

return debug
