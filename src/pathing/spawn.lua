require "vector"
require "proto"

spawn = {}
player = {}
map_data = {
   { 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0}, 
   { 0, 1, 0, 0, 2, 2, 2, 0, 3, 0, 3, 0, 1, 1, 1, 0, 0, 0, 0, 0},
   { 0, 1, 0, 0, 2, 0, 2, 0, 3, 0, 3, 0, 1, 0, 0, 0, 0, 0, 0, 0},
   { 0, 1, 1, 0, 2, 2, 2, 0, 0, 3, 0, 0, 1, 1, 0, 0, 0, 0, 0, 0},
   { 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0},
   { 0, 1, 0, 1, 1, 1, 0, 0, 0, 0, 0, 0, 1, 1, 1, 0, 0, 0, 0, 0},
   { 0, 1, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0},
   { 0, 1, 0, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0},
   { 0, 1, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0},
   { 0, 1, 0, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0},
   { 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0},
   { 0, 2, 2, 2, 0, 3, 3, 3, 0, 1, 1, 1, 0, 2, 0, 0, 0, 0, 0, 0},
   { 0, 2, 0, 0, 0, 3, 0, 3, 0, 1, 0, 1, 0, 2, 0, 0, 0, 0, 0, 0},
   { 0, 2, 0, 0, 0, 3, 0, 3, 0, 1, 0, 1, 0, 2, 0, 0, 0, 0, 0, 0},
   { 0, 2, 2, 2, 0, 3, 3, 3, 0, 1, 1, 1, 0, 2, 2, 2, 0, 0, 0, 0},
   { 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0},
   { 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0},
   { 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0},
   { 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0},
   { 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0},
}

test_data = {
   { 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0}, 
   { 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0},
   { 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0},
   { 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0},
   { 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0},
   { 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0},
   { 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0},
   { 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0},
   { 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0},
   { 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0},
   { 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0},
   { 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0},
   { 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0},
   { 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0},
   { 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0},
   { 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0},
   { 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0},
   { 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0},
   { 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0},
   { 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0},
}

sqlen = 32

function getSquare(e)
  square = vector.new(math.floor(e.x/32), math.floor(e.y/32))
  return square
end

spawn.enemy = function (x, y)
  local enemy = {}
  enemy.x = x
  enemy.y = y

  enemy.img = love.graphics.newImage("enemy.png")

  function enemy.draw()
    love.graphics.draw( 
      enemy.img,
      enemy.x,
      enemy.y)
  end
  enemy.curr_path = {}
  enemy.curr_path.tar = {}
  enemy.curr_path.tar.x = 0
  enemy.curr_path.tar.y = 0

  function get_center(square)
    return vector.new(square.x * 32 + 16, square.y * 32 + 16)
  end

  enemy.speed = 1

  enemy.tar = vector.new(-10, -10)
  enemy.path = {vector.new(0, 0)}
  enemy.i = 1

  function enemy.update(dt)
    local curr_square = getSquare(enemy)
    local tar_square = getSquare(player)

    if curr_square.equals(tar_square) then
    print ("In same square")
    return
    end
    local checked = test_data
    function getValidSquares(v)
      local x = v.x
      local y = v.y
      -- Returns valid next squares, if any.
      local sqs = {}
      if x < 20 and x > 1 then
        if map_data[x + 1][y] == 0 then
          if checked[x + 1][y] ~= 0 then
            table.insert(sqs, vector.new(x + 1, y))
            table.insert(checked[x+1], 1, y)
          end
        end
        if map_data[x - 1][y] == 0 then
          table.insert(sqs, vector.new(x - 1, y))
          table.insert(checked[x-1], 1, y)
        end
      end
      if y < 20 and y > 1 then
        if map_data[x][y + 1] == 0 then
          table.insert(sqs, vector.new(x, y + 1))
          table.insert(checked[x], 1, y+1)
        end
        if map_data[x][y - 1] == 0 then
          table.insert(sqs, vector.new(x, y - 1))
          table.insert(checked[x], 1, y-1)
        end
      end
      return sqs
    end

    function make_path(s, old_path)
       local path = {}
       path.x = s.x
       path.y = s.y
       path.path = old_path
       path.steps = old_path.steps + 1
       return path
    end

    if vector.sdist(tar_square, enemy.tar) > 1 then
       local possible = {} -- paths

       init_path = {}
       init_path.x = curr_square.x
       init_path.y = curr_square.y
       init_path.path = {}
       init_path.steps = 0
       
       local function add(path)
         print ("path steps")
         print (path.steps)
         if possible[path.steps] == nil then
           possible[path.steps] = {}
         end
         table.insert(possible[path.steps], path)
       end

       add(init_path)
       local ind = 0
       local found = false
       function comp_paths()
         while ind < 200 do
           paths = possible[ind]
           for i, p in pairs(paths) do
             local sqs = getValidSquares(p)       
             for i, s in pairs(sqs) do
                if tar_square.equals(s) then
                  print("YAY!")
                  enemy.path = make_path(s, p)
                  return
                end
                add(make_path(s, p))
             end
           end
           print ("!!!")
           print (ind)
           ind = ind + 1
         end
       end
       comp_paths()


    end

    -- Regular move.

    if enemy.path[i] == nil then
      -- Panic.
      return
    end

    if curr_square.equals(enemy.path[i]) then
      i = i + 1
    end

    enemy.x = enemy.x + (enemy.path[i].x - curr_square.x) * enemy.speed
    enemy.y = enemy.y + (enemy.path[i].y - curr_square.y) * enemy.speed


-------

--[[
    enemy.path=CalcPath(CalcMoves(test_data, math.floor(enemy.x/32)+1, math.floor(enemy.y/32)+1, tar_square.x, tar_square.y))
    print(path)
    if path ~= nil then

      enemy.x = enemy.x + (enemy.path[1].x - curr_square.x) * enemy.speed
      enemy.y = enemy.y + (enemy.path[1].y - curr_square.y) * enemy.speed
    end 
--]]
-------

  end

  return enemy
end


spawn.player = function (x, y)
  local player = {}
  player.x = x
  player.y = y
  player.speed = 100
  player.img = love.graphics.newImage("player.png")
  player.tile = {}
  player.tile.x = 0
  player.tile.y = 0

  function player.draw()
    love.graphics.draw( 
      player.img,
      player.x,
      player.y)
  end

  function player.update(dt)
    getSquare(player)
    if love.keyboard.isDown("left") then
        player.x = player.x - player.speed*dt
    elseif love.keyboard.isDown("right") then
        player.x = player.x + player.speed*dt
    elseif love.keyboard.isDown("up") then
        player.y = player.y - player.speed*dt
    elseif love.keyboard.isDown("down") then
        player.y = player.y + player.speed*dt
    end

  end

  return player
end

spawn.map = function()
  local map = {}

  local tile = {}
    for i=0,3 do -- change 3 to the number of tile images minus 1.
      tile[i] = love.graphics.newImage( "tile"..i..".png" )
  end

  map.w = 20
  map.h = 20
  map.x = 0
  map.y = 0
  map.offset_x = 0
  map.offset_y = 0
  map.display_w = 14
  map.display_h = 10
  tile_w = 32
  tile_h = 32

  function map.draw()
    for x = 1, map.display_w do
      for y = 1, map.display_h do
        i = map_data[y+map.y][x+map.x]
        love.graphics.draw( 
          tile[i], 
          (x*tile_w)+map.offset_x, 
          (y*tile_h)+map.offset_y )
      end
    end
  end
  return map
end

return spawn