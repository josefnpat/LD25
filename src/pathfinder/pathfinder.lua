Grid = require("pathfinder.jumper.grid")
Pathfinder = require("pathfinder.jumper.pathfinder")

pathfinder = {}

pathfinder.walkable = 3

function pathfinder.find(map,start,stop)
  if start and stop then  
    local grid = Grid(pathfinder.transpose(map))
    local myFinder = Pathfinder(grid,"ASTAR",pathfinder.walkable)
    myFinder:setMode('ORTHOGONAL')
    local jpath = myFinder:getPath(start[1],start[2],stop[1],stop[2])
    if jpath then
      local path = {}
      for v,count in jpath:nodes() do
        table.insert(path,{x=v:getX(),y=v:getY()})
      end
      return path
    end
  end
end

function pathfinder.transpose( m )
  local res = {}
  for i = 1, #m[1] do
    res[i] = {}
    for j = 1, #m do
      res[i][j] = m[j][i]
    end
  end
  return res
end

return pathfinder
