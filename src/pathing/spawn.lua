require "vector"

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

  function enemy.update(dt)
    local curr_square = getSquare(enemy)
    local tar_square = getSquare(player)

    local checked = {}
    local unckecked = {}
    local num_uncheck = 1
    local num_check = 0
    local index = 1

    function checkValid(x, y)
      if x == 0
    end

    while num_uncheck > 0 do
 
    end

  end

  return enemy
end


spawn.player = function (x, y)
  local player = {}
  player.x = x
  player.y = y
  player.speed = {}
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