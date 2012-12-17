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
  e.camera_x = 0
  e.camera_y = 0
  e.effect = 1
  e.health = 10;
  e.range = 50
  e.weaponpower = 15
  e.z_index = -1
  e.update = spiketrap.update
  e.gethealth = spiketrap.gethealth
  e.geteffect = spiketrap.geteffect
  e.getmodifier = spiketrap.getmodifier
  e.ishit = spiketrap.ishit
  e.draw = spiketrap.draw
  return e
end

function spiketrap:gethealth()
  return self.health
end

function spiketrap:geteffect()
  return self.effect
end

function spiketrap:getmodifier()
  return self.weaponpower
end
function spiketrap:ishit(pow)
  self.health = self.health - pow;
end

return spiketrap
