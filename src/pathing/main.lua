state = "menu"
--require("dgenlib/dgenlib")
--require("gamelib/gamelib")
--require("menulib/menulib")
require "spawn"

-------------------------------------
-- love.load
-------------------------------------
function love.load (arg)

  enemies = {}
  player = spawn.player(50, 50)
  

  --dgenlib.load(arg)

  --gamelib.load(arg)

  --menulib.load(arg)
  
end

-------------------------------------
-- love.update
-------------------------------------
function love.update (dt)
  if state == "dgen" then
  --dgenlib.update(dt)
  elseif state == "game" then
  --gamelib.update(dt)
  elseif state == "menu" then
  --menulib.update(dt)
  end
  map = spawn.map()
  player.update(dt)
end

-------------------------------------
-- love.draw
-------------------------------------
function love.draw ()
  love.graphics.print("Hello World", 400, 300)
--  love.graphics.print(foo, 400, 300)
  map.draw()
  player.draw()
  if state == "dgen" then
  --dgenlib.draw()
  elseif state == "game" then
  --gamelib.draw()
  elseif state == "menu" then
  --menulib.draw()
  end
end

-------------------------------------
-- love.keypressed
-------------------------------------
function love.keypressed (key,unicode)
  if state == "dgen" then
  --dgenlib.keypressed(key,unicode)
  elseif state == "game" then
  --gamelib.keypressed(key,unicode)
  elseif state == "menu" then
  --menulib.keypressed(key,unicode)
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
  if state == "dgen" then
  --dgenlib.mousepressed(x,y,button)
  elseif state == "game" then
  --gamelib.mousepressed(x,y,button)
  elseif state == "menu" then
  --menulib.mousepressed(x,y,button)
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