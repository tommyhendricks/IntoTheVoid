EnemySpawner = require("EnemySpawner")
require("TopGUI")

-- start at 0
--
local levelState = -1
local enemySpawned = false

local titleY = 400
local titleOpac = 1

local T = {}


function T.update(dt, projectiles, player)
  TopGUI.levelGUIInfo(3)


  if(global.levelReset) then
    EnemySpawner.reset()
    levelState = 0
    timeMove = true
    time = 0
    global.levelReset = false

  end

  if(levelState == -1) then
    global.backgroundMusic:pause()
    global.LevelMusic:play()
    levelState = 0
  end

  if(global.gameOver) then
    EnemySpawner.reset()
    levelState = -1
    global.gameState = 0
    global.gameOver = false
    global.LevelMusic:pause()
    global.backgroundMusic:play()
  end

  if(#EnemySpawner.EnemyGroup1 == 0) then
    enemySpawned = false
  end

  if(levelState == 0) then
    player.x = 300
    player.y = 700
    levelState = 1
    global.canEscape = false
    enemySpawned = false
  elseif(levelState == 1 and enemySpawned == false) then
    EnemySpawner.spawnEnemies(5, 1, 6, 1)
    enemySpawned = true
    levelState = 2
  elseif(levelState == 2 and enemySpawned == false) then
    EnemySpawner.spawnEnemies(5, 6, 7, 1)
    enemySpawned = true
    levelState = 3
  elseif(levelState == 3 and enemySpawned == false) then
    EnemySpawner.spawnEnemies(5, 1, 6, 1)
    EnemySpawner.spawnEnemies(5, 6, 7, 1)
    enemySpawned = true
    levelState = 4
  elseif(levelState == 4 and enemySpawned == false) then
    EnemySpawner.spawnEnemies(3, 8, 3, 1)
    EnemySpawner.spawnEnemies(3, 8, 2, 1)
    enemySpawned = true
    levelState = 5
  elseif(levelState == 5 and enemySpawned == false) then
    EnemySpawner.spawnEnemies(8, 1, 6, 1)
    EnemySpawner.spawnEnemies(1, 6, 7, 1)
    enemySpawned = true
    levelState = 6
  elseif(levelState == 6 and enemySpawned == false) then
    EnemySpawner.spawnEnemies(4, 6, 10, 1)
    enemySpawned = true
    levelState = 7
  elseif(levelState == 7 and enemySpawned == false) then
    EnemySpawner.spawnEnemies(4, 4, 4, 1)
    enemySpawned = true
    levelState = 8
  elseif(levelState == 8 and enemySpawned == false) then
    EnemySpawner.spawnEnemies(5, 2, 4, 1)
    EnemySpawner.spawnEnemies(5, 2, 5, 1)
    enemySpawned = true
    levelState = 9
  elseif(levelState == 9 and enemySpawned == false) then
    EnemySpawner.spawnEnemies(2, 6, 12, 1)
    enemySpawned = true
    levelState = 10
  elseif(levelState == 10 and enemySpawned == false) then
    EnemySpawner.spawnEnemies(5, 1, 8, 1)
    enemySpawned = true
    levelState = 11
  elseif(levelState == 11 and enemySpawned == false) then
    EnemySpawner.spawnEnemies(5, 1, 4, 1)
    EnemySpawner.spawnEnemies(5, 1, 5, 1)
    EnemySpawner.spawnEnemies(1, 6, 12, 1)
    enemySpawned = trued
    levelState = 12
  elseif(levelState == 12 and enemySpawned == false) then
    EnemySpawner.spawnEnemies(3, 8, 6, 1)
    EnemySpawner.spawnEnemies(3, 6, 12, 1)
    levelState = 13
    enemySpawned = true
  elseif(levelState == 13 and enemySpawned == false) then
    EnemySpawner.reset()
    global.gameState = 4
    global.canControl = false
    global.canShoot = false
    levelState = - 1
  end



  EnemySpawner.update(dt, projectiles)
end



 function T.draw()

   love.graphics.setNewFont("asests/AmericanCaptain.ttf", 64)

   if(titleY > 100) then
     love.graphics.setColor(.2,.8,1,titleOpac)
     love.graphics.print("Final Level", 275, titleY)
    end

   love.graphics.setColor(1,1,1,1)
   titleY = titleY - 1.5
   titleOpac = titleOpac - .005

   EnemySpawner.draw()
end

return T
