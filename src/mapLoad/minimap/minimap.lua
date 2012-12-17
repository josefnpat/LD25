minimap = {}

minimap.tile_size = 1

minimap.miniCanvas = love.graphics.newCanvas(Dungeon.width,Dungeon.height)
minimap.miniCanvas:setFilter("nearest","nearest")
minimap.madeCanvas = false
minimap.backdrop = love.graphics.newImage("mapLoad/minimap/img/minimap.png")
minimap.backdrop:setFilter("nearest","nearest")

function minimap.draw()
if minimap.madeCanvas == false then
love.graphics.setCanvas(minimap.miniCanvas)
  for i,v in ipairs(Dungeon.map) do
    for j,w in ipairs(v) do
      if w == 0 then
        love.graphics.setColor(59,44,44,0)
      else
        love.graphics.setColor(59,44,44)
      end
      love.graphics.rectangle("fill",(i-1)*minimap.tile_size,(j-1)*minimap.tile_size,minimap.tile_size,minimap.tile_size)
    end
  end
  love.graphics.setColor(255,255,255)
  minimap.madeCanvas = true
  love.graphics.setCanvas()
end
love.graphics.draw(minimap.backdrop,10,10,0,4,4)
love.graphics.setColor(255,255,255,150)
love.graphics.draw(minimap.miniCanvas,25,25,0,2.5,2.5)
love.graphics.setColor(255,255,255)
  for i,v in ipairs(entity.data) do
      local x,y = entity.RawToMap(v)
		if v.type == "portal" then
		love.graphics.setColor(255,255,0)
        elseif v.type == "slowtrap" or v.type == "spiketrap" then
        love.graphics.setColor(0,255,255)
        elseif v.type == "player" then
        love.graphics.setColor(0,0,255)
        elseif v.type == "enemy" then
        love.graphics.setColor(255,0,0)
        else
        love.graphics.setColor(255,255,255)
		end
		
		love.graphics.rectangle("fill",25 + x * 2.5,25 + y * 2.5,2,2)
		love.graphics.setColor(255,255,255)
  end
end

return minimap
