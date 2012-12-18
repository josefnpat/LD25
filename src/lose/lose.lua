lose = {}

lose.sfx = love.audio.newSource("lose/lose.wav")
lose.img = love.graphics.newImage("lose/YOULOSE.png")
lose.img:setFilter("nearest","nearest")

function lose.draw()
  love.graphics.setColor(255,255,255)
  love.graphics.draw(lose.img,0,0,0,love.graphics.getWidth() / win.img:getWidth(),love.graphics.getHeight() / win.img:getHeight())
end

function lose.update(dt)
    if win.dt == 0 then
		if gamemode == "survival" then
		  addScore("Player_1", counter.count, "Survival")
		end
      love.audio.stop()
      lose.sfx:play()
    end
  win.dt = win.dt + dt
end

function lose.keypressed(key)
  if win.dt > 2 then
    state = "menu"
  end
end

function addScore(name,score)
local topscores = {}

if love.filesystem.exists("score.lua") then
local chunk = love.filesystem.load("score.lua")
scoreBoard = chunk()
 for i = 1, #scoreBoard.scores do
	topscores[i] = scoreBoard.scores[i]
 end
end
local output = "return{ scores = {"
for i = 1, #topscores do
output = output .. "{"
output = output .. "name = \"" .. topscores[i].name .. "\","
output = output .. "score = " .. topscores[i].score .. ","
output = output .. "gamemode = \"" .. topscores[i].gamemode .. "\""
output = output .. "},"
end

output = output .. "{"
output = output .. "name = \"" .. name .. "\","
output = output .. "score = " .. score .. ","
output = output .. "gamemode = \"" .. gamemode .. "\""
output = output .. "}"

output = output .. "}}"

success = love.filesystem.write("score.lua", output)
end
return lose
