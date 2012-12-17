debug = {}

chartlib = require('debug/chartlib')
chart_fps = chartlib.new(200)

function debug.draw()
  if not debug.show then
    return
  end
  if debug.dist then
    local px,py = entity.getScreenLocation(player_obj)
    for i,v in ipairs(entity.data) do
      local ex,ey = entity.getScreenLocation(v)
      if v.owner == "player" then
        love.graphics.setColor(255,0,0)
      else
        love.graphics.setColor(255,255,255)
      end
      love.graphics.line(px,py,ex,ey)
      love.graphics.setColor(255,255,255)
      local dist = entity.distance(player_obj,v)
      love.graphics.print(dist,(px+ex)/2,(py+ey)/2)
      love.graphics.circle("line",ex,ey,16*4)
    end
  end
  if debug.quake then
    love.graphics.setColor(255,0,255,255)
    love.graphics.rectangle("fill",0,0,love.graphics.getWidth(),love.graphics.getHeight()/2)
    love.graphics.setColor(255,255,255)
    map.graphics.sheet:setFilter("nearest","nearest")
    local x_ret,y_ret = 1,0.5
    for i,v in ipairs(map.quads) do
      if x_ret > 13 then
        x_ret = 1
        y_ret = y_ret + 1
      end
      love.graphics.drawq(map.graphics.sheet,v,x_ret*16*4,y_ret*16*4,0,4,4)
      love.graphics.setColor(255,255,255,127)
      love.graphics.print(i,x_ret*16*4,y_ret*16*4)
      love.graphics.rectangle("line",x_ret*16*4,y_ret*16*4,16*4,16*4)
      love.graphics.setColor(255,255,255)
      x_ret = x_ret + 1
    end
  end
  chart_fps:draw("FPS",32,love.graphics.getHeight()/2+16*4,nil,100)
  love.graphics.print("F2 - Tile Numers\nF3 - distance\nF4 - Tileset\nF5 - vsync",32,love.graphics.getHeight()/2+16*16)
end

function debug.update(dt)
  chart_fps:push(love.timer.getFPS())
end

debug.show = false
debug.tile = false
debug.dist = false
debug.quake = false
debug.vsync = false
function debug.keypressed(key)
  if key == "f1" then
    debug.show = not debug.show
  elseif key == "f2" then
    debug.tile = not debug.tile
  elseif key == "f3" then
    debug.dist = not debug.dist
  elseif key == "f4" then
    debug.quake = not debug.quake
  elseif key == "f5" then
    debug.vsync = not debug.vsync
    local width, height, fullscreen, vsync, fsaa = love.graphics.getMode( )
    success = love.graphics.setMode( width, height, fullscreen, debug.vsync, fsaa )
  end
end

return debug
