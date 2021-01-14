local T = {}
EnemySpawner = require("EnemySpawner")
T.timePassed = 0

local upArrow = love.graphics.newImage("asests/Images/upArrow.png")
local arrowY = 40
local arrowDY = .5
local messageX = 25
local enemySpawned = false
local tutorialDone = false

local playTime = true
local canClick = true
local message = 1

local stage1 = true
local stage2 = false
local stage3 = false

local ThingsToSay = {}
ThingsToSay[1] = "Welcome, I can see that You havent played before. (Click)"
ThingsToSay[2] = "The Controls are pretty simple."
ThingsToSay[3] = "Control your player by using the W,A,S,D keys."
ThingsToSay[4] = "Dont you try to leave the screen... Im watching you!"

ThingsToSay[5] = "Good Work looks like you are getting the hang of this."
ThingsToSay[6] = "Ok now for a couple more things before the fun stuff."
ThingsToSay[7] = "As you can see there is an amazing looking bar at the top of the screen"
ThingsToSay[8] = "I wonder who made that...."
ThingsToSay[9] = "This bar shows three things:"
ThingsToSay[10] = "Health"
ThingsToSay[11] = "Current Level"
ThingsToSay[12] = "Lives left"
ThingsToSay[13] = "Two of these are very important when it comes to you not dying"
ThingsToSay[14] = "Remember!! If you die you will go back to the start of the level"
ThingsToSay[15] = "Losing all your lives will send you back to the start screen"

ThingsToSay[16] = "OK now for the fun stuff."
ThingsToSay[17] = "You can shoot by pressing space bar. Go ahead give it a try."
ThingsToSay[18] = "You can shoot as much as you would like there are no limits."

ThingsToSay[19] = "OK now for a little target practice"
ThingsToSay[20] = "Each enemy is different."
ThingsToSay[21] = "Some do more damage and some have more health"
ThingsToSay[22] = "Enemy bullets with a darker color do more damage"
ThingsToSay[23] = "These guys shoot so look out!"
ThingsToSay[24] = "Here it comes"
ThingsToSay[25] = "Look out!!!"
ThingsToSay[26] = "Alright you got it(Click)"
ThingsToSay[27] = "I have taught you all you need to know good luck"
ThingsToSay[28] = ""

function T.update(dt, projectiles, player)
  global.backgroundMusic:pause()
  global.LevelMusic:play()
  global.inTutorial = true
  if (playTime) then
    T.timePassed = T.timePassed + dt
  end
  if(message >=10 and message <=12) then
    arrowY = arrowY + arrowDY
    if(arrowY < 30) then
      arrowDY = arrowDY * -1
    elseif(arrowY > 45) then
      arrowDY = arrowDY * -1
    end
  end

    if(tutorialDone) then
      player.dy = -300
      global.canEscape = true
      if(player.y < -100) then
        global.inTutorial = false
        player.dy = 0
        global.gameState = 11
      end
    end
    EnemySpawner.update(dt, projectiles)
end



function T.draw()
  love.graphics.setNewFont("asests/AmericanCaptain.ttf", 48)
  -- Stage 1 movement
  if (T.timePassed >= 3 and stage1) then
    playTime = false
    love.graphics.printf(ThingsToSay[message], 90,400,250, 'center' )
    if( message > 3) then
      global.canControl = true
    end
    if(message == 4 ) then
      playTime = true
      T.timePassed = 0
      stage1 = false
      stage2 = true
    end
  end

  -- Stage 2 GUI and what it means
  if (T.timePassed >= 3 and stage2) then

    playTime = false
    canClick = true
    if(message < 10 or message > 12) then
      love.graphics.printf(ThingsToSay[message], 90, 400, 250, 'center' )
    end
    if(message == 10) then
      love.graphics.printf(ThingsToSay[message], messageX, 120, 200, 'center' )
      love.graphics.draw(upArrow, messageX+50, arrowY, 0, 2, 2)
    elseif(message == 11) then
      messageX = global.w/2-120
      love.graphics.printf(ThingsToSay[message],messageX ,120,250, 'center' )
      love.graphics.draw(upArrow, messageX+60, arrowY,0,2,2)
    elseif(message == 12) then
      messageX = global.w - 200
      love.graphics.printf(ThingsToSay[message],messageX ,120,200, 'center' )
      love.graphics.draw(upArrow, messageX+75, arrowY,0,2,2)
    end
    if(message == 14) then
      playTime = true
      T.timePassed = 0
      stage2 = false
      stage3 = true
    end
  end
  -- Stage 3 shooting... The fun stuff
  if(T.timePassed >=3 and stage3) then
    playTime = false

    love.graphics.printf(ThingsToSay[message], 90, 400, 250, 'center' )

    if(message == 15) then
      global.canShoot = true
    end



    if(message == 25 and not(enemySpawned)) then
      EnemySpawner.spawnEnemies(1, 1, 1, 1)
      canClick = false
      enemySpawned = true
    end

    if(message == 25 and #EnemySpawner.EnemyGroup1 == 0) then
      canClick = true
      message = message +1
    end

    if(message == 28) then
      tutorialDone = true
    end

  end

  EnemySpawner.draw()

end

function T.mousepressed(x, y, button, isTouch)
  if(x > 0 and y > 0 and playTime == false) then
    if(message < #ThingsToSay and canClick) then
      message = message + 1
    end
  end
end

return T
