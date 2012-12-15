require("lovemenuwrap")

function love.load()
 lovemenuwrap.load()
end
function love.draw()
  lovemenuwrap.draw()
end


function love.keypressed(key,unicode)
 lovemenuwrap.keypressed(key,unicode)
end


function love.update(dt)
  lovemenuwrap.update(dt)
end

function love.mousepressed(x,y,button)
  lovemenuwrap.mousepressed(x,y,button)
end
