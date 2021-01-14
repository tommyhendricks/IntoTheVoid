

local T = {}

T.playerAnim = null
T.plyerShip = null
T.anim = require("AnimationMaker")

local tsStats = {}

tsStats.num = 1
tsStats.health = 15
tsStats.damage = 3
tsStats.defence = 8
tsStats.image = love.graphics.newImage("asests/Ships/TankShipSingle.png")
tsStats.imageToQuad = "asests/Ships/TankShip.png"

local fsStats = {}

fsStats.num = 2
fsStats.health = 8
fsStats.damage = 6
fsStats.defence = 5
fsStats.image = love.graphics.newImage("asests/Ships/FighterShipSingle.png")
fsStats.imageToQuad = "asests/Ships/FighterShip.png"


local asStats = {}

asStats.num = 3
asStats.health = 12
asStats.damage = 5
asStats.defence = 7
asStats.image = love.graphics.newImage("asests/Ships/AverageShipSingle.png")
asStats.imageToQuad = "asests/Ships/AverageShip.png"


local currentShip =  fsStats




function T.update()



end


function T.draw()

  love.graphics.printf("Ship Selection", 0, 100, global.w, 'center')

  --love.graphics.draw(currentShip.image, global.w/2 - 210, 200,0,4,4)

  if(currentShip.num == 1) then
    love.graphics.draw(tsStats.image, global.w/2 - 210, 200,0,4,4)
    love.graphics.draw(global.arrow,global.w/2 - 175, 510, 0, -1.5, -1.5)
  elseif(currentShip.num == 2) then
    love.graphics.draw(fsStats.image, global.w/2 - 210, 200,0,4,4)
    love.graphics.draw(global.arrow,global.w/2 + 175, 400, 0, 1.5, 1.5)
    love.graphics.draw(global.arrow,global.w/2 - 175, 510, 0, -1.5, -1.5)
  elseif(currentShip.num == 3) then
    love.graphics.draw(asStats.image, global.w/2 - 210, 200,0,4,4)
    love.graphics.draw(global.arrow,global.w/2 + 175, 400, 0, 1.5, 1.5)
  end




  T.leftArrow = global.makeBox(global.w/2 + 235, 430, 50, 50, {0,0,0,0})
  T.rightArrow = global.makeBox(global.w/2 - 290, 430, 50, 50, {0,0,0,0})

  love.graphics.draw(global.StatsPicture,  global.w/2 - 310, 500,0,2,2)

  love.graphics.setColor(1,0,0,1)
  love.graphics.rectangle("fill", global.w/2 - 105, 590, 15 * currentShip.health, 25)
  love.graphics.setColor(0,0,1,1)
  love.graphics.rectangle("fill", global.w/2 - 105, 635, 15 * currentShip.defence, 25)
  love.graphics.setColor(0,1,0,1)
  love.graphics.rectangle("fill", global.w/2 - 105, 680, 15 * currentShip.damage, 25)

  love.graphics.setColor(1,1,1,1)

  love.graphics.draw(global.confirmButton, global.w/2 - 160, 650)

  T.confirmBox = global.makeBox(global.w/2 - 106, 723, 190,30, {0,0,0,0})

  love.graphics.draw(global.backButton, 10, global.h - 100,0,1.1,1.1)
  T.backArrow = global.makeBox(10, global.h - 100, 100, 100, {1,1,1,0})
end


function T.confirmShip()

  T.playerAnim = currentShip.imageToQuad
  T.playerShip = currentShip
  global.gameState = 3

end


function T.mousepressed(x, y, button, isTouch)
  if(global.isPointInBox(x,y,T.leftArrow)) then
    if (currentShip.num == 1) then
      currentShip = tsStats
    elseif (currentShip.num == 2) then
      currentShip = tsStats
    elseif(currentShip.num == 3) then
      currentShip = fsStats
    end
  end

  if(global.isPointInBox(x,y,T.rightArrow)) then
    if (currentShip.num == 1) then
      currentShip = fsStats
    elseif (currentShip.num == 2) then
      currentShip = asStats
    elseif(currentShip.num == 3) then
      currentShip = asStats
    end
  end

  if(global.isPointInBox(x,y,T.confirmBox)) then
    T.confirmShip()
  end

  if(global.isPointInBox(x,y,T.backArrow)) then
    global.gameState = 0
  end
  global.click:play()
end



return T
