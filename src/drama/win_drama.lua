d = require("drama/dramalib")

drama = {}

scene = {}
scene.lines = {}

line = {}
line.speaker = "right"
line.left = {}
line.left.img = love.graphics.newImage("drama/player.png")
line.left.img:setFilter("nearest","nearest")
line.left.name = "\"The Villan\""

line.right = {}
line.right.img = love.graphics.newImage("drama/princess.png")
line.right.img:setFilter("nearest","nearest")
line.right.name = "Princess Diamonds"

line.text = "Oh no, he got me!!!"

table.insert(scene.lines,line)


line = {}
line.speaker = "left"
line.text = "I am sorry Hero, but the Princess is another castle!!!"

table.insert(scene.lines,line)

line = {}

line.speaker = "right"
line.right = {}
line.right.name = "\"The Silly Hero\""
line.right.img = love.graphics.newImage("drama/hero.png")
line.right.img:setFilter("nearest","nearest")
line.text = "Darn it!"

table.insert(scene.lines,line)

line = {}

line.right = {}
line.text = "I'm the hero!"

table.insert(scene.lines,line)

line = {}

line.right = {}
line.right.img = love.graphics.newImage("drama/princess.png")
line.right.img:setFilter("nearest","nearest")
line.right.name = "Princess Diamonds"
line.text = "My hero!"

table.insert(scene.lines,line)

libdrama = require("drama/dramalib")

function drama.load(arg)
  d.load(scene)
end

function drama.draw()
  d.draw()
end

function drama.keypressed(key,uni)
  if key == "escape" then
    state = "menu"
  else
    d.keypressed(key,uni)
  end
end

function drama.mousepressed()
  d.mousepressed()
end

function libdrama.done()
  state = "game"
end

function drama.update(dt)
  libdrama.update(dt)
end

return drama
