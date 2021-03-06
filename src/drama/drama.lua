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
line.text = "Now, I can walk with [arrow keys] or [W][A][S][D]. Excellent!"

table.insert(scene.lines,line)

line = {}

line.speaker = "left"
line.text = "There might be situations in which I need to pick up the Princess! I could do that with [space]."

table.insert(scene.lines,line)

line = {}

line.speaker = "left"
line.text = "Last but not least: The action keys (like placing traps) are [1],[2] and [3]. I have got to keep that in mind."

table.insert(scene.lines,line)

line = {}

line.speaker = "left"
line.text = "I better make sure the heroes don't bring the Princess to the green portals, otherwise they will warp back with her and everything will have been in vain!"

table.insert(scene.lines,line)

line = {}

line.speaker = "left"
line.text = "It will take a little bit until the red portal to the next castle will opens up for me. When it does, I'll have to carry the princess out of here."

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
    state = "game"
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
