menu = require("menu/menu")

lovemenuwrap = {}
function lovemenuwrap.load()

  menu:toggle()
  menu_view = {}
  menu_view[1] = {
    title="Dungen Fuckers",
    desc="The Forces of good are coming to take what you've rightfully stolen. Hold them off. If you can.",
    {t="New Game",cb="ng"},
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
    desc="Josefnpat - Programmer\nBlarget - Artist\nIoke - Programmer\npeterrstanley - Programmer\nExpugnosententia - Incompetent\nVividReality - Programmer\n",
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
  if not menu.run and key == "escape" then
    menu:toggle()
  end
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
    menu:toggle()
  elseif cb == "op" then
    menu:setstate(2)
  elseif cb == "cr" then
    menu:setstate(4)
  elseif cb == "exit" then
    menu:setstate(3)
  elseif cb == "cexit" then
    love.event.push("q")
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