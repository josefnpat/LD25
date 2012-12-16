require("codeatuts")

pathfinder = {}

pathfinder.stateObstacle = 0

function pathfinder.find(map,start,stop)

  if start then
    if stop then
      path = CalcPath(CalcMoves(map, start[1], start[2], stop[1], stop[2]))
      if path == nil then
      else
        return path
      end
    end
  end
end

return pathfinder
