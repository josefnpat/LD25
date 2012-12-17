local wizard = {}

pathfind = require "entity/pathfind" -- 1/3

wizard.speedvals = {}
wizard.speedvals.slow = 2
wizard.speedvals.medium = 4

function wizard:draw()
  local x,y = entity.getScreenLocation(self)
  love.graphics.print("wizard",x,y)
  love.graphics.circle("line",x,y,self.range)
end

function wizard:update(dt)
  
  self:path_update(dt,prin) -- 2/3
  
  self.slowed = false
  for _,v in pairs(player_obj.traps) do
    local dist = entity.distance(self,v)
    if dist < 16 and dist ~=0 then
      if v.type == "slowtrap" then
        self.slowed = true     
      elseif v.type == "spiketrap" then
        self.health = self.health - 20*dt
      end
    end
  end

  if self.slowed then
    self.speed = wizard.speedvals.slow
  else
    self.speed = wizard.speedvals.medium
  end
  
end


function wizard.new()
  local e = {}
  pathfind.init(e) -- 3/3
  e.type = "wizard"
  e.x = player_obj.x + math.random(-100,100)
  e.y = player_obj.y + math.random(-100,100) 
  e.health = 100
  e.range = 100
  e.draw = wizard.draw
  e.update = wizard.update
  e.speed = wizard.speedvals.medium
  return e
end

return wizard
