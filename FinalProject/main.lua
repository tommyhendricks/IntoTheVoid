--[[
Final Project
Title- Space
Author- Tommy H
Description- Fly through space past planets and monsters to make it to the end

--]]


love.window.setMode(700, 900)

local ms = require("mainScreen")
local st = require("Settings")
local ship = require("ShipSelection")
local animMaker = require("AnimationMaker")
local projectile = require("projectiles")
require("TiledHandler")
require("Functions")
require("TopGUI")

local timeSinceLastShot = 0

--Levels
local level0 = require("levels/level0")
local level1 = require("levels/level1")
local level2 = require("levels/level2")
local level3 = require("levels/level3")
local finalScreen = require("levels/Finalscreen")

local player



function love.mousepressed(x, y, button, isTouch)
  if(global.gameState == 0) then
    ms.mousepressed(x, y, button, isTouch)
  elseif(global.gameState == 1) then
    ship.mousepressed(x, y, button, isTouch)
  elseif(global.gameState == 2) then
    st.mousepressed(x, y, button, isTouch)
  elseif(global.gameState == 10) then
    level0.mousepressed(x, y, button, isTouch)
  elseif(global.gameState == 4) then
    finalScreen.mousepressed(x, y, button, isTouch)
  end
end

function love.keypressed(key, scancode, isrepeat)
  if(global.gameState == 0) then
    ms.keypressed(key, scancode, isrepeat)
  elseif (global.gameState >= 10 and global.canControl) then
    if(key == "d") then
      player.dx = player.dx + global.movementSpeed
    elseif(key == "a") then
      player.dx = player.dx - global.movementSpeed
    elseif(key == "w") then
      player.dy = player.dy - global.movementSpeed
    elseif(key == "s") then
      player.dy = player.dy + global.movementSpeed
    end
  end
end

function love.keyreleased(key)
  if(global.gameState >= 10 and global.canControl) then
    if(key == "d") then
      player.dx = player.dx - global.movementSpeed
    elseif(key == "a") then
      player.dx = player.dx + global.movementSpeed
    elseif(key == "w") then
      player.dy = player.dy + global.movementSpeed
    elseif(key == "s") then
      player.dy = player.dy - global.movementSpeed
    elseif(key == "space" and global.canShoot and timeSinceLastShot >=0.4) then
      timeSinceLastShot = 0
      global.shoot:play()
      projectile.makeProjectile(player, "player")
    end
  end
end

function love.load(arg)
  love.window.setTitle(global.gameName)
  plane = love.graphics.newImage("asests/Images/plane1.1.png")
  br = loadTiledMap("PixelBackground")
  enemy1 = love.graphics.newImage("Enemys/enemy2.png")
  enemy1width = enemy1:getWidth()
  enemy1height = enemy1:getHeight()
  global.backgroundMusic:setLooping(true)
  global.LevelMusic:setLooping(true)
  global.backgroundMusic:play()
end


function love.update(dt)
  timeSinceLastShot = timeSinceLastShot + dt

  if global.gameState == 0 then
    ms.update(dt)
    br.scrollTiles()
  elseif global.gameState == 1 then
    br.scrollTiles()
  elseif global.gameState == 2 then
    br.scrollTiles()
  elseif global.gameState == 3 then
    player = animMaker.makeAnimation(ship)
    if(global.totorial) then
      TopGUI.updateGUIInfo(3,ship.playerShip.health,0)
      global.gameState = 10
    elseif(not global.totorial) then
      TopGUI.updateGUIInfo(3,ship.playerShip.health,1)
      global.gameState = 11
      global.canShoot = true
      global.canControl = true
    end
  elseif global.gameState == 4 then
    br.scrollTiles()
    finalScreen.update(player)
    player.update(dt, projectile)
  elseif global.gameState == 10 then
    br.scrollTiles()
    TopGUI.update(dt)
    projectile.update(dt)
    player.update(dt, projectile)
    level0.update(dt, projectile, player)
  elseif global.gameState == 11 then
    br.scrollTiles(dt)
    projectile.update(dt)
    player.update(dt, projectile)
    level1.update(dt, projectile, player)
    TopGUI.update(dt)
  elseif global.gameState == 12 then
    br.scrollTiles(dt)
    projectile.update(dt)
    player.update(dt, projectile)
    level2.update(dt, projectile, player)
    TopGUI.update(dt)
  elseif global.gameState == 13 then
    br.scrollTiles(dt)
    projectile.update(dt)
    player.update(dt, projectile)
    level3.update(dt, projectile, player)
    TopGUI.update(dt)
  end


end



function love.draw()


  if global.gameState == 0 then
    br:draw()
    ms.draw()
  elseif global.gameState == 1 then
    br:draw()
    ship.draw()
  elseif global.gameState == 2 then
    br:draw()
    st.draw()
  elseif global.gameState == 4 then
    br:draw()
    finalScreen.draw()
    player.draw(dt, projectile)
  elseif global.gameState == 10 then
    br:draw()
    player.draw()
    TopGUI.draw()
    projectile.draw()
    level0.draw()
  elseif global.gameState == 11 then
    br:draw()
    projectile.draw()
    level1.draw()
    TopGUI.draw()
    player.draw()
  elseif global.gameState == 12 then
    br:draw()
    projectile.draw()
    level2.draw()
    TopGUI.draw()
    player.draw()
  elseif global.gameState == 13 then
    br:draw()
    projectile.draw()
    level3.draw()
    TopGUI.draw()
    player.draw()

  end


end
