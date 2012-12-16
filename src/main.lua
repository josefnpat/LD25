function file_exists(name)
  local f=io.open(name,"r")
  if f~=nil then io.close(f) return true else return false end
end

if file_exists("git.lua") then
  require("git")
end
require("menu/lovemenuwrap")
map = require("mapLoad/map")
entity = require("entity/entity")

state = "menu"

-------------------------------------
-- love.load
-------------------------------------
function love.load (arg)
  lovemenuwrap.load()
  map.init()
  entity.load()
  player_obj = entity.new("player")
 enemies = {}  
  enemy1 = entity.new("enemy")
  enemy2 = entity.new("enemy")
  enemy3 = entity.new("enemy")
   table.insert(enemies,enemy1)
   table.insert(enemies,enemy2)
   table.insert(enemies,enemy3)
  portal_enemy = entity.new("portal")
  portal_enemy.type = "portal_player"
  portal_enemy.x,portal_enemy.y = 500,500
  portal_player = entity.new("portal")
  portal_player.x,portal_player.y = 550,550
  prin = entity.new("princess")

end

-------------------------------------
-- love.update
-------------------------------------
function love.update (dt)
  if state == "menu" then
    lovemenuwrap.update(dt)
  elseif state == "game" then
    entity.update(dt)
  end
end

-------------------------------------
-- love.draw
-------------------------------------
function love.draw ()
  if state == "game" then
    map.draw()
    entity.draw()
  elseif state == "menu" then
    lovemenuwrap.draw()
  end
end

-------------------------------------
-- love.keypressed
-------------------------------------
function love.keypressed (key,unicode)
  if state == "menu" then
    lovemenuwrap.keypressed(key,unicode)
  elseif state == "game" then
    entity.keypressed (key,unicode)
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
  if state == "menu" then
    lovemenuwrap.mousepressed(x,y,button)
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
