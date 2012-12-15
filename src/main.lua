require("menu/lovemenuwrap")
map = require("mapLoad/map")

state = "menu"

-------------------------------------
-- love.load
-------------------------------------
function love.load (arg)
  lovemenuwrap.load()
  map.init()
end

-------------------------------------
-- love.update
-------------------------------------
function love.update (dt)
  if state == "menu" then
    lovemenuwrap.update(dt)
  end
end

-------------------------------------
-- love.draw
-------------------------------------
function love.draw ()
  if state == "game" then
    map.draw()
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
  end
end

-------------------------------------
-- love.keyreleased
-------------------------------------
function love.keyreleased (key)
  if state == "dgen" then
  --dgenlib.keyreleased(key)
  elseif state == "game" then
  --gamelib.keyreleased(key)
  elseif state == "menu" then
  --menulib.keyreleased(key)
  end
end

-------------------------------------
-- love.mousepressed
-------------------------------------
function love.mousepressed (x,y,button)
  if state == "menu" then
    lovemenuwrap.mousepressed(x,y,button)
  end
end

-------------------------------------
-- love.mousereleased
-------------------------------------
function love.mousereleased (x,y,button)
  if state == "dgen" then
  --dgenlib.mousereleased(x,y,button)
  elseif state == "game" then
  --gamelib.mousereleased(x,y,button)
  elseif state == "menu" then
  --menulib.mousereleased(x,y,button)
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
