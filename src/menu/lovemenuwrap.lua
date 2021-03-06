menu = require("menu/menu")

lovemenuwrap = {}
function lovemenuwrap.load()

  menu:toggle(true)
  menu_view = {}
  
  if git and git_count then
    git = "\nGIT: v"..git_count.." ["..git.."]"
  else
    git = ""
    print("Game does not have any git information.")
  end
  
  menu_view[1] = {
    title="",
    desc="The Forces of good are coming to take what you've rightfully stolen. Hold them off.\n If you can."..git,
    {t="Story mode",cb="ng"},
    {t="Survival mode",cb="su"},
    {t="Leaderboard",cb = "lead"},
    {t="Options",cb="op"},
    {t="Credits",cb="cr"},
    {t="Exit",cb="exit"}
  }
  menu_view[2] = {
    title="Options",
    desc="Set your options here.",
    {t="Fullscreen",cb="fs"},
    {t="Resolution ("..love.graphics.getWidth().."x"..love.graphics.getHeight()..")",cb="res"},
    {t="Sound (on)",cb="sound"},
    {t="Return",cb="mm"}
  }
  menu_view[3] = {
    title="Quit",
    desc="Are you sure you want to quit?",
    {t="Confirm",cb="cexit"},
    {t="Return",cb="mm"}
  }
  menu_view[4] = {
    title="Credits",
    desc="Josefnpat - Programmer\nBlarget - Artist\nIoke - Programmer/Princess\npeterrstanley - Programmer\nExpugnosententia - Programmer/Incompetent\nVividReality - Programmer\nmmmeff - Game Tester\nDaniel Bienvenu - What Is Love Intro",
    {t="Return",cb="mm"}
  }
  menu_view[5] = {
    title="Leaderboards",
    desc="Select a gamemode.",
    {t="Survival",cb="su_lead"},
    {t="Return",cb="mm"}
  }
  menu_view[6] = {
    title="Survival",
    desc="",
    {t="Return",cb="mm"}
  }
  menu:load(menu_view)
  videomodes = love.graphics.getModes()
  currentmode = 1  
end
function lovemenuwrap.draw()
  menu:draw()
end

curbg = 0
function lovemenuwrap.keypressed(key,unicode)
  menu:keypressed(key)
  if key == "r" then
    curbg = (curbg + 1)%4
    if curbg == 0 then
      menu.bg = love.graphics.newImage("menu/assets/bg.png")
    else
      menu.bg = love.graphics.newImage("bg"..curbg..".png")
    end
  end
end

sound = true
function menu:callback(cb)
  if cb == "ng" then
    game_init("story")
    state = "drama"
  elseif cb == "su" then
    game_init("survival")
    state = "game"
  elseif cb == "op" then
    menu:setstate(2)
  elseif cb == "cr" then
    menu:setstate(4)
  elseif cb == "lead" then
    menu:setstate(5)
  elseif cb == "su_lead"then
    menu:setstate(6)
    local scores = loadScore()
    menu_view[6].desc = ""
    for i = 1, math.min(#scores, 5) do
		if scores[i].gamemode == "survival" then
		  menu_view[6].desc = menu_view[6].desc .. "#" .. i .. " " .. scores[i].name .. " - " .. timeToString(scores[i].score) .. "\n\r \n\r"
		end
    end
  elseif cb == "exit" then
    menu:setstate(3)
  elseif cb == "cexit" then
    love.event.quit()
  elseif cb == "fs" then
    love.graphics.toggleFullscreen( )
  elseif cb == "res" then
    love.graphics.setMode( videomodes[currentmode].width, videomodes[currentmode].height )
    menu_view[2][2].t = "Resolution ("..love.graphics.getWidth().."x"..love.graphics.getHeight()..")"
    currentmode = currentmode % #videomodes + 1
  elseif cb == "sound" then
    sound = not sound
    local temp_x = ""
    if sound then
      temp_s = "on"
    else
      temp_s = "off"
    end
    menu_view[2][3].t = "Sound ("..temp_s..")"
  elseif cb == "mm" then
    menu:setstate(1)
  else
    print("unknown command:"..cb)
  end
end



function lovemenuwrap.update(dt)
  menu:update(dt)
end

function lovemenuwrap.mousepressed(x,y,button)
  menu:mousepressed(x,y,button)
end
return lovemenuwrap
