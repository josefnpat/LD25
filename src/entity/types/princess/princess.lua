util = require "entity/types/princess/util/util"
vector = require "entity/types/princess/util/vector"
local princess = {}

function princess:draw()
  if self.captive == false then
    local frame = 2
    if self.walking then
      frame = math.floor((self.dt * 10) % #self.dir + 1)
    end
    love.graphics.drawq(self.sprite.sheet,
        self.dir[frame], 
        (self.x - camera.x - map.graphics.width) * 4,
        (self.y - camera.y - map.graphics.height - 4) * 4,
        0,
        self.scale.x,
        self.scale.y,
        8,
        24)
  end
end

function princess:update(dt)
  self.dt = self.dt + dt
  self.walking = false

  if self.captive == false then
    self.camera.x = (-camera.x + self.x) - (self.sprite.width)/2
    self.camera.y = (-camera.y + self.y) - (self.sprite.height)/2

    -- For testing animations.
--[[
    if love.keyboard.isDown("h") then
      self.move("left", dt)
    elseif love.keyboard.isDown("j") then
      self.move("down", dt)
    elseif love.keyboard.isDown("k") then
      self.move("up", dt)
    elseif love.keyboard.isDown("l") then
      self.move("right", dt)
    end
]]--

    -- Wandering logic.

    local mask = Dungeon.map
    local square = util:getSquare(self)

    if square.equals(self.target.sqr) or util:isEmpty(self.path) then
      local new_path = {}
      local path_len = math.random(5, 12)
      local sqr = square
      for i = 0, path_len do
        local squares = util:getValidSquares(sqr)
        if util:isEmpty(squares) then
          print("Princess has no where to move.")
        else
          local nxt = square
          local sdir = false
          if #new_path > 0 then
            sdir = util:dirIn(squares, new_path[#new_path].dir)
          end
          local ran = (math.random(1, 10))
          if #squares > 0 and sdir and ran > 4 then
            nxt = sdir
          else
            nxt = squares[math.random(#squares)]
          end
          table.insert(new_path, nxt)
          sqr = nxt.sqr
        end
      end
      self.path = new_path
      self.target = self.path[#self.path]
    end
    if not util:isEmpty(self.path) then
      if square.equals(self.path[1].sqr) then
        table.remove(self.path, 1)
      end
      self.move(self.path[1].dir, dt)
    end
  else -- Need to add enemy carry.
    self.path = {}
    self.x = player_obj.x
    self.y = player_obj.y
  end
end

function princess.new()
  local prin = {}
  prin.type = "princess"
  prin.x = player_obj.x
  prin.y = player_obj.y
  prin.camera = {}
  prin.health = 999
  -- Start next to player.
  prin.camera.x = 0
  prin.camera.y = 0
  prin.update = princess.update
  prin.draw = princess.draw
  prin.sprite = {}
  prin.sprite.sheet = love.graphics.newImage("entity/types/princess/princess.png")
  prin.sprite.sheet:setFilter("nearest","nearest")
  prin.sprite.width = 16
  prin.sprite.height = 32
  prin.scale = {}
  prin.scale.x = 4
  prin.scale.y = 4
  prin.captive = false
  prin.speed = 20
  prin.dt = 0
  prin.die = false 
  prin.walk = {}
  prin.walk.left = {x=0,y=0,framecount=3}
  prin.walk.right = {x=16*3,y=0,framecount=3}
  prin.walk.down = {x=0,y=32,framecount=3}
  prin.walk.up = {x=16*3,y=32,framecount=3}
  prin.walk_quads = {}


  for i,v in pairs(prin.walk) do
    prin.walk_quads[i] = {}
    for frame = 1,v.framecount+1 do
      if frame == 4 then
        real_frame = 2
      else
        real_frame = frame
      end
      local quad = love.graphics.newQuad(v.x+16*(real_frame-1),
            v.y,
            16,
            32,
            prin.sprite.sheet:getWidth(),
            prin.sprite.sheet:getHeight())
      table.insert(prin.walk_quads[i],quad)
    end
  end
  prin.dir = prin.walk_quads.down

  prin.quad = love.graphics.newQuad(0, 0,
             prin.sprite.width,
             prin.sprite.height,
             prin.sprite.sheet:getWidth(),
             prin.sprite.sheet:getHeight())

  function prin.move(dir, dt)
    if dir == "up" then
      prin.dir = prin.walk_quads.up
      prin.y = prin.y - prin.speed*dt
    elseif dir == "down" then
      prin.dir = prin.walk_quads.down
      prin.y = prin.y + prin.speed*dt
    elseif dir == "left" then
      prin.dir = prin.walk_quads.left
      prin.x = prin.x - prin.speed*dt
    elseif dir == "right" then
      prin.dir = prin.walk_quads.right 
      prin.x = prin.x + prin.speed*dt
    elseif dir == "right" then
      print ("Princess moves nowhere.")
    end
    prin.walking = true
  end

  local location = {}
  location.sqr = util:getSquare(prin)
  location.dir = "none"
  prin.target = location

  prin.path = {}

  return prin
end

return princess