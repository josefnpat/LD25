local test = {}

-- To apply pathfinding to your own entities, insert the three commands commented.

pathfind = require "entity/pathfind" -- 1/3

function test:update(dt)
  self:path_update(dt,prin) -- 2/3
end

function test:draw()
  local x,y = entity.getScreenLocation(self)
  love.graphics.circle("line",x,y,8,16*4)
  love.graphics.print("t",x,y)
  --[[
  if self.path then
    for i,v in ipairs(self.path) do
      local x,y = entity.MapToRaw(v.x,v.y)
      local e = {x=x,y=y}
      local rx,ry = entity.getScreenLocation(e)
      love.graphics.circle("line",rx+32,ry+32,4)
    end
  end
  --]]
end

function test.new()
  local e = {}
  e.type = "test"
  repeat
    e.x = player_obj.x + math.random(-200,200)
    e.y = player_obj.y + math.random(-200,200)
  until not entity.collision(e)
  e.update = test.update
  e.draw = test.draw
  pathfind.init(e) -- 3/3
  return e
end

return test
