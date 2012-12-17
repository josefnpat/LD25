local entity = {}

entity.needs_sorting = false

function entity.new(t)
  local temp = entity.type[t].new()
  table.insert(entity.data,temp)
  entity.needs_sorting = true
  return temp
end

function entity.getScreenLocation(entity)
  local x = (entity.x - camera.x - map.graphics.width) * 4
  local y = (entity.y - camera.y - map.graphics.height) * 4
  return x,y
end

function entity.setScreenLocation(x,y)
  local entity_x = x/4 + map.graphics.width + camera.x
  local entity_y = y/4 + map.graphics.height + entity.y
  return entity_x,entity_y
end

function entity.MapToRaw(x,y)
  return x * 16, y * 16
end

function entity.RawToMap(entity)
  local nx = math.round((entity.x-4)/16)
  local ny = math.round((entity.y-4)/16)
  return nx,ny
end

function entity.RawToTile(entity)
  local nx = math.round((entity.x-4)/16)*16
  local ny = math.round((entity.y-4)/16)*16
  return nx,ny
end

function entity.sort(t)
  table.sort(t,function(x,y)
      local x_index,y_index = 0,0
      if x.z_index then
        x_index = x.z_index
      end
      if y.z_index then
        y_index = y.z_index
      end
      return y_index > x_index
    end
  )
end

function entity.getType(t)
  local temp = {}
  for i,v in ipairs(entity.data) do
    if v.type and v.type == t then
      table.insert(temp,v)
    end
  end
end

function entity.collision(entity)
  for x = -1,1 do
    for y = -1,1 do
      local tiletype = Dungeon.map[math.floor((entity.x+x*4) / 16)][math.floor((entity.y+y*4) / 16)]
      if tiletype == Tiles.Solid then
        return true
      end
    end
  end
  return false
end

function entity.distance(a,b)
  return math.sqrt( (a.x - b.x) ^ 2 + (a.y - b.y) ^ 2 )
end

function entity.load(args)
  entity.type = {}

  files = love.filesystem.enumerate("entity/types")

  for _,t in ipairs(files) do
    --print("loading type `"..t.."`")
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
  if entity.needs_sorting then
    entity.sort(entity.data)
    entity.needs_sorting = false
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
