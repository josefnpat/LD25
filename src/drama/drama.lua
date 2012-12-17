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

line.text = "Hero, Help! This nasty villain has taken me hostage!"

table.insert(scene.lines,line)


line = {}
line.speaker = "left"
line.text = "Bwahahaha, I'v stolen your precious princess, you silly hero!"

table.insert(scene.lines,line)

line = {}

line.speaker = "right"
line.right = {}
line.right.name = "\"The Silly Hero\""
line.right.img = love.graphics.newImage("drama/hero.png")
line.right.img:setFilter("nearest","nearest")
line.text = "Not if I can help it!"

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

line = {}

line.speaker = "left"
line.text = "It takes a while until the portal opens up, but I better carry this princess out of here, before the hero can rescue her."

table.insert(scene.lines,line)

libdrama = require("drama/dramalib")

function drama.load(arg)
  d.load(scene)
end

function drama.draw()
  d.draw()
end

function drama.keypressed(key,uni)
  d.keypressed(key,uni)
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
