spawn = {}

local map_data = {
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

  function enemy.update(dt)
  
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
  map.offset_x = 30
  map.offset_y = 30
  map.display_w = 14
  map.display_h = 10
  tile_w = 48
  tile_h = 48

  function map.draw()
    for x = 1, map.display_w do
      for y = 1, map.display_h do
        love.graphics.draw( 
          tile[map_data[y+map.y][x+map.x]], 
          (x*tile_w)+map.offset_x, 
          (y*tile_h)+map.offset_y )
      end
    end
  end
  return map
end

return spawn
