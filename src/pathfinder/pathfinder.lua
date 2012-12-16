require("codeatuts")

pathfinder = {}

pathfinder.stateObstacle = 0

function pathfinder.find(map,start,stop)

  -- If a start and end cell has been defined, use
  -- the A* algorithm to find and display a path.

  if start then
    if stop then
      --print("-- Calculating A* Path.")
      path = CalcPath(CalcMoves(map, start[1], start[2], stop[1], stop[2]))
      if path == nil then
        --print("-- No path found.")
      else
        --print("-- Path found:\n")
        --for i,v in ipairs(path) do
          --print(i,v)
          --for j,w in pairs(v) do
          --  print("",j,w)
          --end
        --end
        return path
      end
    else
      --print("-- ERROR: Path can't be found until end cell is selected.")
    end
  else
    --print("-- ERROR: Path can't be found until start cell is selected.")
  end
end

return pathfinder
