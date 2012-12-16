menu = {}

love.graphics.getFont()

menu.font_title = love.graphics.newFont("menu/assets/TriodPostnaja.ttf",64)
menu.font_desc = love.graphics.newFont("menu/assets/Tower_Print.ttf",22)
menu.font_menu = love.graphics.newFont("menu/assets/Tower_Print.ttf",24)
menu.icon = love.graphics.newImage("menu/assets/icon.png")
menu.icon:setFilter("nearest","nearest")
menu.bg = love.graphics.newImage("menu/assets/bg.png")
menu.bg:setFilter("nearest","nearest")
menu.button = love.graphics.newImage("menu/assets/button.png")
menu.button:setFilter("nearest","nearest")
menu.title = love.graphics.newImage("menu/assets/title.png")
menu.title:setFilter("nearest","nearest")
menu.title_glow = love.graphics.newImage("menu/assets/title_glow.png")
menu.title_glow:setFilter("nearest","nearest")

menu.padding = 64
menu.option = 0
menu.state = 1
menu.run = false;
scale_x,scale_y = 1,1
function menu:load(views)
  menu.view = views
  menu:calc_offset()
  menu.iconpos = menu.option*menu.button:getHeight()*scale_y+menu.offset+menu.button:getHeight()*scale_y/2
  menu.iconcurpos = menu.iconpos
end

function menu:calc_offset()
  menu.offset = 0--love.graphics.getHeight()/2-(menu.font_menu:getHeight()*#menu.view[menu.state])/2
end

function menu:toggle()
  menu.run = not menu.run
end

menu.title_fade = 0
function menu:draw()
  if menu.run then
    local orig_font = love.graphics.getFont()
    local orig_r, orig_g, orig_b, orig_a
    orig_r, orig_g, orig_b, orig_a = love.graphics.getColor( )
    love.graphics.setColor(255,255,255,255)
    scale_x = love.graphics.getWidth()/menu.bg:getWidth()
    scale_y = love.graphics.getHeight()/menu.bg:getHeight()
    love.graphics.draw(menu.bg,0,0,0,scale_x,scale_y)
    --love.graphics.setColor(0,0,0,127)
    --love.graphics.rectangle("fill",love.graphics.getWidth()*6/10,0,love.graphics.getWidth()*3/10,love.graphics.getHeight())
    love.graphics.setColor(255,255,255,96+96*math.abs(math.sin(menu.title_fade)))
    
    love.graphics.draw(menu.title_glow,scale_x*32,scale_y*32,0,scale_x,scale_y)
    love.graphics.setColor(255,255,255)
    love.graphics.draw(menu.title,scale_x*32,scale_y*32,0,scale_x,scale_y)
    if menu.view[menu.state].title ~= "" then
      love.graphics.setFont(menu.font_title)
      love.graphics.printf(
        menu.view[menu.state].title,
        love.graphics.getWidth()*1/10,
        love.graphics.getHeight()*4.5/10,
        love.graphics.getWidth()*5.5/10, 
        "center"
      )
    end
    
    love.graphics.setColor(255,255,255,192)
    love.graphics.setFont(menu.font_desc)
    love.graphics.printf(
      menu.view[menu.state].desc,
      love.graphics.getWidth()*1/10,
      love.graphics.getHeight()*6/10,
      love.graphics.getWidth()*5.5/10,
       "center"
     )
    love.graphics.setFont(menu.font_menu)
    for i,v in ipairs(menu.view[menu.state]) do
      love.graphics.draw(
        menu.button,
        love.graphics.getWidth()*7.5/10,
        (i-1)*menu.button:getHeight()*scale_y+menu.offset,0,scale_x,scale_y)
      love.graphics.printf(
        v.t,
        love.graphics.getWidth()*7.5/10,
        (i-1)*menu.button:getHeight()*scale_y+menu.offset+6*scale_y,
        love.graphics.getWidth()*2.5/10,
        "center"
      )
    end
    
    love.graphics.setColor(0,0,0,150)
    love.graphics.draw(
      menu.icon,
      love.graphics.getWidth()*7/10 + 5,
      menu.iconcurpos + 15,--wat
      math.rad(math.sin(love.timer.getTime()) * 10 - 5),scale_x,scale_y,
      0,
      menu.icon:getHeight()/2
    )
    love.graphics.setColor(255,255,255)
    love.graphics.draw(
      menu.icon,
      love.graphics.getWidth()*7/10,
      menu.iconcurpos,--wat
      math.rad(math.sin(love.timer.getTime()) * 10 - 5),scale_x,scale_y,
      0,
      menu.icon:getHeight()/2)
    if orig_font then
      love.graphics.setFont(orig_font)
    end
    love.graphics.setColor(orig_r,orig_g,orig_b,orig_a)
  end
end

function menu:update(dt)
  if menu.run then
    menu.title_fade = menu.title_fade + dt
    menu.iconpos = menu.option*menu.button:getHeight()*scale_y+menu.offset+menu.button:getHeight()*scale_y/2
    if menu.iconpos > menu.iconcurpos then
      menu.iconcurpos = menu.iconcurpos + math.abs(menu.iconcurpos-menu.iconpos)/2
    elseif menu.iconpos < menu.iconcurpos then
      menu.iconcurpos = menu.iconcurpos - math.abs(menu.iconcurpos-menu.iconpos)/2
    end
    local temp_test = menu:determine_mouse_choice(love.mouse.getX(),love.mouse.getY())
    if temp_test then
      menu.option = temp_test
    end
  end
end

function menu:keypressed(key)
  if menu.run then
    if key == "escape" then
      menu.option = #menu.view[menu.state]-1
    elseif key == "up" then
      menu.option = (menu.option - 1) % #menu.view[menu.state]
    elseif key == "down" then
      menu.option = (menu.option + 1) % #menu.view[menu.state]
    elseif key == "return" or key == "enter" or key ==" " then
      menu:callback_exec()
    end
  end
end

function menu:callback_exec()
  if menu.callback then
    menu:callback(menu.view[menu.state][menu.option+1].cb)
  else
    print("menu:callback not defined.")
  end
end

function menu:setstate(stateid)
  if menu.view[stateid] then
    menu.option = 0
    menu.state = stateid
  else
    print("Menu state does not exist.")
  end
end

function menu:determine_mouse_choice(x,y)
  local x_start = love.graphics.getWidth()*7.5/10
  local limit = love.graphics.getWidth()*2.5/10
  for i = 1,#menu.view[menu.state] do
    local y_start = (i-1)*menu.button:getHeight()*scale_y+menu.offset
    if x >= x_start and x <= x_start + limit and y >= y_start and y <= y_start + menu.button:getHeight()*scale_y then
       return i-1
    end
  end
end

function menu:mousepressed(x,y,button)
  if menu.run then
    local temp_test = menu:determine_mouse_choice(x,y)
    if temp_test then
      menu.option = temp_test
      menu:callback_exec()
    end
  end
end

return menu
