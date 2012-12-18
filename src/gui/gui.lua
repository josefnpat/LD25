gui = {}

gui.img = love.graphics.newImage("gui/gui.png")
gui.img:setFilter("nearest","nearest")

function gui.draw()
  local x = (love.graphics.getWidth()-gui.img:getWidth()*4)/2
  local y = love.graphics.getHeight()-gui.img:getHeight()*4
  love.graphics.draw(gui.img,x,y,0,4,4)
  
  map.graphics.sheet:setFilter("nearest","nearest")
  
  local x_offset = (gui.img:getWidth()*4 - 192)/2
  local y_offset = 36
  
  love.graphics.drawq(map.graphics.sheet,map.quads[32],x+x_offset,y+y_offset,0,4,4)
  love.graphics.drawq(map.graphics.sheet,map.quads[8],x+64+x_offset,y+y_offset,0,4,4)
  love.graphics.drawq(map.graphics.sheet,map.quads[57],x+128+x_offset,y+y_offset,0,4,4)
  
end



return gui
