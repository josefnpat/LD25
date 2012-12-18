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
  
  --player_obj.slowtraps_cooldown = 3
  --player_obj.slowtraps_cooldown_init = 3
  --player_obj.spiketraps_cooldown = 2
  --player_obj.spiketraps_cooldown_init = 2
  --player_obj.flames_cooldown = 1
  --player_obj.flames_cooldown_init = 1
  
  local slowtraps_height = entity.type.player.slowtraps_cooldown/entity.type.player.slowtraps_cooldown_init*64
  local spiketraps_height = entity.type.player.spiketraps_cooldown/entity.type.player.spiketraps_cooldown_init*64
  local flames_height = entity.type.player.flames_cooldown/entity.type.player.flames_cooldown_init*64

  love.graphics.drawq(map.graphics.sheet,map.quads[8],x+x_offset,y+y_offset,0,4,4)
  love.graphics.drawq(map.graphics.sheet,map.quads[32],x+64+x_offset,y+y_offset,0,4,4)
  love.graphics.drawq(map.graphics.sheet,map.quads[57],x+128+x_offset,y+y_offset,0,4,4)
  
  love.graphics.setColor(255,0,0,127)
  love.graphics.rectangle("fill",x+x_offset,y+y_offset,64,slowtraps_height)
  love.graphics.rectangle("fill",x+x_offset+64,y+y_offset,64,spiketraps_height)
  love.graphics.rectangle("fill",x+x_offset+128,y+y_offset,64,flames_height)
  love.graphics.setColor(255,255,255)
  
end



return gui
