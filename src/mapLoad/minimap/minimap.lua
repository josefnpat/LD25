minimap = {}

minimap.tile_size = 1

function minimap.draw()
  for i,v in ipairs(Dungeon.map) do
    for j,w in ipairs(v) do
      if w == 0 then
        love.graphics.setColor(255,255,255)
      else
        love.graphics.setColor(0,0,0)
      end
      love.graphics.rectangle("fill",(i-1)*minimap.tile_size,(j-1)*minimap.tile_size,minimap.tile_size,minimap.tile_size)
    end
  end
  love.graphics.setColor(255,255,255)
end

return minimap
