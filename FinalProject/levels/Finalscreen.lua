local T = {}


local enemyImages = {}
enemyImages[1] = love.graphics.newImage("Enemys/enemy1.png")
enemyImages[2] = love.graphics.newImage("Enemys/enemy2.png")
enemyImages[3] = love.graphics.newImage("Enemys/enemy3.png")
enemyImages[4] = love.graphics.newImage("Enemys/enemy4.png")
enemyImages[5] = love.graphics.newImage("Enemys/enemy5.png")
enemyImages[6] = love.graphics.newImage("Enemys/enemy6.png")
enemyImages[7] = love.graphics.newImage("Enemys/enemy7.png")
enemyImages[8] = love.graphics.newImage("Enemys/enemy8.png")


local pipeThing = love.graphics.newImage("asests/images/holeThing.png")

local homeBox = global.makeBox(277, 275, 150, 100,{1,1,1,1})


function T.mousepressed(x, y, button, isTouch)
  if(global.isPointInBox(x,y,homeBox)) then
    global.gameState = 0
  end
end

function T.update()
  if state == 0 then
    arrayOfImages1 = makeArraysOfImages()
    arrayOfImages2 = makeArraysOfImages()
    state = 1
  end


end


function T.draw()
    love.graphics.setNewFont("asests/AmericanCaptain.ttf", 64)
    love.graphics.printf("You Win!", 0, 100, global.w, 'center')
    love.graphics.setNewFont("asests/AmericanCaptain.ttf", 48)

    love.graphics.printf("You Killed:", 0, 300, global.w, 'center')
    love.graphics.printf(global.totalKilled, 0, 350, global.w, 'center')

    love.graphics.printf("Home", 0, 475, global.w, 'center')

    love.graphics.draw(enemyImages[1], 50, 50,0,.25 ,.25)
    love.graphics.draw(enemyImages[2], 50, 250,0,.25 ,.25)
    love.graphics.draw(enemyImages[3], 40, 450,0,.25 ,.25)
    love.graphics.draw(enemyImages[4], 50, 650,0,.25 ,.25)

    love.graphics.draw(enemyImages[5], global.w - 175, 50,0,.25 ,.25)
    love.graphics.draw(enemyImages[6], global.w - 175, 250,0,.25 ,.25)
    love.graphics.draw(enemyImages[7], global.w - 175, 450,0,.25 ,.25)
    love.graphics.draw(enemyImages[8], global.w - 175, 650,0,.25 ,.25)


end


return T
