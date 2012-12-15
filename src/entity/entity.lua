local entity = {}

function entity.new(t)
  local temp = entity.type[t].new()
  table.insert(entity.data,temp)
  return temp
end

function entity.getType(t)
  local temp = {}
  for i,v in ipairs(entity.data) do
    if v.type and v.type == t then
      table.insert(temp,v)
    end
  end
end

function entity.load(args)
  entity.type = {}

  files = love.filesystem.enumerate("entity/types")

  for _,t in ipairs(files) do
    print("loading type `"..t.."`")
    entity.type[t] = require("entity/types/"..t.."/"..t)
    if entity.type[t].load then
      entity.type[t].load(args)
    end
  end

  entity.data = {}
end

function entity.update(dt)
  for i,v in ipairs(entity.data) do
    if v.update then
      v:update(dt)
    end
  end
end

function entity.draw()
  for i,v in ipairs(entity.data) do
    if v.draw then
      v:draw()
    end
  end
end

function entity.keypressed(key,unicode)
  for i,v in ipairs(entity.data) do
    if v.keypressed then
      v:keypressed(key,unicode)
    end
  end
end

function entity.keyreleased(key)
  for i,v in ipairs(entity.data) do
    if v.keyreleased then
      v:keyreleased(key)
    end
  end
end

function entity.mousepressed(x,y,button)
  for i,v in ipairs(entity.data) do
    if v.mousepressed then
      v:mousepressed(x,y,button)
    end
  end
end

function entity.mousereleased(x,y,button)
  for i,v in ipairs(entity.data) do
    if v.mousereleased then
      v:mousereleased(x,y,button)
    end
  end
end

function entity.joystickpressed(joystick,button)
  for i,v in ipairs(entity.data) do
    if v.joystickpressed then
      v:joystickpressed(joystick,button)
    end
  end
end

function entity.joystickreleased(joystick,button)
  for i,v in ipairs(entity.data) do
    if v.joystickreleased then
      v:joystickreleased(joystick,button)
    end
  end
end

function entity.focus(f)
  for i,v in ipairs(entity.data) do
    if v.focus then
      v:focus(f)
    end
  end
end

return entity
