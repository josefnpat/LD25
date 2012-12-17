require("git")
lovesplash = require("lovesplash/lovesplash")
require("menu/lovemenuwrap")
map = require("mapLoad/map")
bresenham = require("mapLoad/dungen/bresenham")
debuglib = require("debug/debug")
entity = require("entity/entity")
counter = require("counter/counter")
drama = require("drama/drama")
win = require("win/win")
lose = require("win/win")
state = "lovesplash"

-------------------------------------
-- love.load
-------------------------------------
function love.load (arg)
  lovemenuwrap.load()
  game_init()  
end

function game_init()
  love.graphics.setCaption("Loading .")
  map.init()
  love.graphics.setCaption("Loading ..")
  entity.load()
  love.graphics.setCaption("Loading ...")
  player_obj = entity.new("player")
  love.graphics.setCaption("Loading ....")
  enemies = {}  
  enemy1 = entity.new("enemy")
  enemy2 = entity.new("enemy")
  enemy3 = entity.new("enemy")
  wizard1 = entity.new("wizard")
  table.insert(enemies,enemy1)
  table.insert(enemies,enemy2)
  table.insert(enemies,enemy3)
  table.insert(enemies,wizard1)
  love.graphics.setCaption("Loading .....")
  counter.load()
  counter.set_time(120);
  love.graphics.setCaption("Loading ......")
  portals = {}
  for x = 1, map.mapWidth do
	  for y = 1, map.mapHeight do
		  if Dungeon.map[x][y] == Tiles.Portal then
		    local c = #portals + 1
		    portals[c] = entity.new("portal")
		    if c == 3 then
		      portals[c].owner = "player"
		      playerportal_obj = portals[c]
		    else
		      portals[c].owner = "enemy"
		    end
		    local nx,ny = entity.getMapLocation(x,y)
		    portals[c].x = nx
		    portals[c].y = ny
		  end
    end
  end
  love.graphics.setCaption("Loading .......")
  prin = entity.new("princess")
  love.graphics.setCaption("Loading ........")
  drama.load()
  love.graphics.setCaption("DunGen")
  
end

-------------------------------------
-- love.update
-------------------------------------
function love.update (dt)
  if state == "lovesplash" then
    lovesplash.update(dt)
    if lovesplash.done() then
      state = "menu"
    end
  elseif state == "menu" then
    lovemenuwrap.update(dt)
  elseif state == "drama" then
    drama.update(dt)
  elseif state == "game" then
    if not pause then
      for i,v in ipairs(enemies) do
        if v.health < 0  then
          table.remove(enemies,i)
        end
      end
      for i,v in ipairs(entity.data) do
        if v.health < 0  then
          table.remove(entity.data,i)
        end
      end
      entity.update(dt)
      counter.update(dt)
    end
  elseif state == "win" then
     win.update(dt)
  elseif state == "lose" then
     lose.update(dt)
  end
  debuglib.update(dt)
end

-------------------------------------
-- love.draw
-------------------------------------
function love.draw ()
  if state == "lovesplash" then
    lovesplash.draw()
  elseif state == "menu" then
    lovemenuwrap.draw()
  elseif state == "drama" then
    drama.draw()
  elseif state == "game" then
    map.draw(1)
    entity.draw()
    map.draw(2,debug.tile and debug.show)
    counter.draw()
    if pause then
      love.graphics.setColor(0,0,0,191)
      love.graphics.rectangle("fill",0,0,love.graphics.getWidth(),love.graphics.getHeight())
      love.graphics.setColor(255,255,255)
      love.graphics.printf("Paused\nPuse `q` to return to menu. Press `escape` to return to game.",0,love.graphics.getHeight()/2,love.graphics.getWidth(),"center")
    end
  elseif state == "win" then
     win.draw()
  elseif state == "lose" then
     lose.draw()
  end
  debuglib.draw(debug)
end

pause = false
-------------------------------------
-- love.keypressed
-------------------------------------
function love.keypressed (key,unicode)
  debuglib.keypressed(key)
  if state == "lovesplash" then
    lovesplash.stop()
  elseif state == "menu" then
    lovemenuwrap.keypressed(key,unicode)
  elseif state == "drama" then
    drama.keypressed (key,unicode)
  elseif state == "game" then
    if pause then
      if key == "escape" then
        pause = false
      elseif key == "q" then
        state = "menu"
        pause = false
      end
    else
      if key == "escape" then
        pause = true
      end
    end
    entity.keypressed (key,unicode)
  elseif state == "win" then
     win.keypressed (key,unicode)
  elseif state == "lose" then
     lose.keypressed (key,unicode)
  end
end

-------------------------------------
-- love.keyreleased
-------------------------------------
function love.keyreleased (key)
  if state == "game" then
    entity.keyreleased(key)
  end
end

-------------------------------------
-- love.mousepressed
-------------------------------------
function love.mousepressed (x,y,button)
  if state == "lovesplash" then
    lovesplash.stop()
  elseif state == "menu" then
    lovemenuwrap.mousepressed(x,y,button)
  elseif state == "drama" then
    drama.mousepressed(x,y,button)  
  elseif state == "game" then
    entity.mousepressed(x,y,button)
  end
end

-------------------------------------
-- love.mousereleased
-------------------------------------
function love.mousereleased (x,y,button)
  if state == "game" then
    entity.mousereleased (x,y,button)
  end
end

-------------------------------------
-- love.joystickpressed
-------------------------------------
function love.joystickpressed (joystick,button)
  if state == "dgen" then
  --dgenlib.joystickpressed(joystick,button)
  elseif state == "game" then
  --gamelib.joystickpressed(joystick,button)
  elseif state == "menu" then
  --menulib.joystickpressed(joystick,button)
  end
end

-------------------------------------
-- love.joystickreleased
-------------------------------------
function love.joystickreleased (joystick,button)
  if state == "dgen" then
  --dgenlib.joystickreleased(joystick,button)
  elseif state == "game" then
  --gamelib.joystickreleased(joystick,button)
  elseif state == "menu" then
  --menulib.joystickreleased(joystick,button)
  end
end

-------------------------------------
-- love.focus
-------------------------------------
function love.focus (f)
  if state == "dgen" then
  --dgenlib.focus(f)
  elseif state == "game" then
  --gamelib.focus(f)
  elseif state == "menu" then
  --menulib.focus(f)
  end
end

function math.round(num, idp)
  local mult = 10^(idp or 0)
  return math.floor(num * mult + 0.5) / mult
end
