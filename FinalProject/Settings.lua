local T = {}



function T.draw()

  love.graphics.setNewFont("asests/AmericanCaptain.ttf", 64)
  love.graphics.draw(global.cog, 160, 70)
  love.graphics.printf("Settings", 0, 100, global.w, 'center')
  love.graphics.draw(global.cog, 450, 70)

  love.graphics.printf("Tutorial Mode", 0, 250, 350, 'center')
  T.OnOffBox = global.makeBox(global.w - 230,240, 150, 75,{1,1,1,0})

  love.graphics.draw(global.backButton, 10, global.h - 100,0,1.1,1.1)
  T.backArrow = global.makeBox(10, global.h - 100, 100, 100, {1,1,1,0})

  love.graphics.printf("Credits", 0, 500, global.w, 'center')
  love.graphics.setNewFont("asests/AmericanCaptain.ttf", 32)
  love.graphics.print("Music: ", 100 , 600)
  love.graphics.print("FoxSynergy(Kit Rosen) ", 200 , 600)
  --https://opengameart.org/users/foxsynergy?page=1
  love.graphics.print("Sound Effects: ", 100 , 650)
  love.graphics.print("ZapSplat", 270 , 650)
  --https://www.zapsplat.com/?s=lose+a+life&post_type=music&sound-effect-category-id
  love.graphics.print("Enemy's: ", 100 , 700)
  love.graphics.print("RunninBlood(Twitter)", 200 , 700)
  --https://twitter.com/RunninBlood/status/1093270259774251014


  if(global.totorial) then
    love.graphics.draw(global.on, global.w - 230 , 240,0 ,.65,.65)
  else
    love.graphics.draw(global.off, global.w - 230 , 240,0 ,.65,.65)
  end

end




function T.mousepressed(x, y, button, isTouch)
  if(global.isPointInBox(x,y,T.OnOffBox)) then
    global.click:play()
    global.totorial = not(global.totorial)
  end
  if(global.isPointInBox(x,y,T.backArrow)) then
    global.click:play()
    global.gameState = 0
  end
end



return T
