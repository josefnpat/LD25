local spiketrap = {}
spiketrap.sheet = map.graphics.sheet
spiketrap.sheet:setFilter('nearest','nearest')

function spiketrap:update(dt)
end

function spiketrap:draw()
  local x,y = entity.getScreenLocation(self)
  love.graphics.drawq(spiketrap.sheet,map.quads[32],x,y,0,4,4)
end

function spiketrap.new()
  local e = {}
  e.type = "spiketrap"
  e.x = 0
  e.y = 0
  e.health = 10
  e.range = 16*4
  e.z_index = -1
  e.update = spiketrap.update
  e.draw = spiketrap.draw
  return e
end

return spiketrap
