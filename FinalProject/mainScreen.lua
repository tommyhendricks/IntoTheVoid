local T = {}
local mainScreenVars = {}
mainScreenVars.time = 0
mainScreenVars.drawStart = false


function T.load()


end


function T.update(dt)
  mainScreenVars.time = mainScreenVars.time + dt
  if(mainScreenVars.time >=.85) then
    mainScreenVars.drawStart = not(mainScreenVars.drawStart)
    mainScreenVars.time = 0
  end

end


function T.draw()

  love.graphics.setColor(global.white)
  love.graphics.setFont(global.splashFont)
  if mainScreenVars.drawStart then
    love.graphics.printf("Press Space", 0, global.h - 200, global.w, 'center')
  end
  love.graphics.draw(global.title, global.w/2 - 210, 200, 0, .7, .7)
  love.graphics.draw(global.cog, global.w-100, global.h - 100)
  T.cogBox = global.makeBox( global.w-90, global.h - 90, 75, 75, {1,1,1,0})


end


function T.mousepressed(x, y, button, isTouch)
  if(global.isPointInBox(x,y,T.cogBox)) then
    global.click:play()
    global.gameState = 2
  end
end

function T.keypressed(key, scancode, isrepeat)
  if(key == "space") then
    global.gameState = 1
  end
end

return T
