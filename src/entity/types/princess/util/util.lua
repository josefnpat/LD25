require "entity/types/princess/util/vector"

local util = {}

function util:getSquare(e)
  local square = vector:new(math.floor(e.x/map.graphics.width),
         math.floor(e.y/map.graphics.height))
  return square
end


function util:getValidSquares(v)
  local x = v.x
  local y = v.y
  local map = Dungeon.map
  local empty = 3
  -- Returns valid next squares, if any.
  local sqs = {}
  if map[x + 1][y] == empty then
    local s = {}
    s.dir = "right"
    s.sqr = vector:new(x + 1, y)
    table.insert(sqs, s)
  end
  if map[x - 1][y] == empty then
    local s = {}
    s.dir = "left"
    s.sqr = vector:new(x - 1, y)
    table.insert(sqs, s)
  end
  if map[x][y + 1] == empty then
    local s = {}
    s.dir = "down"
    s.sqr = vector:new(x, y + 1)
    table.insert(sqs, s)
  end
  if map[x][y - 1] == empty then
    local s = {}
    s.dir = "up"
    s.sqr = vector:new(x, y - 1)
    table.insert(sqs, s)
  end
  return sqs
end

function util:isEmpty(t)
  for _ in pairs(t)  do 
    return false
  end
  return true
end

function util:dirIn(t, d)
  if #t == 0 then
    return false
  end
  for i, s in pairs(t) do
    if s.dir == d then
      return s
    end
  end
  return false
end

return util