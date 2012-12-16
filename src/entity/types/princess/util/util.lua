require "entity/types/princess/util/vector"

local util = {}

function util:getSquare(e)
  print (e)
  square = vector.new(math.floor(e.x/map.graphics.width), math.floor(e.y/map.graphics.height))
  return square
end


function util:getValidSquares(v)
  local x = v.x
  local y = v.y
  local map = Dungeon.map
  -- Returns valid next squares, if any.
  local sqs = {}
  if x < 20 and x > 1 then
    if map[x + 1][y] == 0 then
      table.insert(sqs, vector.new(x + 1, y))
    end
    if map[x - 1][y] == 0 then
      table.insert(sqs, vector.new(x - 1, y))
    end
  end
  if y < 20 and y > 1 then
    if map[x][y + 1] == 0 then
      table.insert(sqs, vector.new(x, y + 1))
    end
    if map[x][y - 1] == 0 then
      table.insert(sqs, vector.new(x, y - 1))
    end
  end
  return sqs
end

function util:isEmpty(t)
  for _ in pairs(t)  do 
    return false
  end
  return true
end

return util