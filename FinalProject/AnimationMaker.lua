require("TopGUI")

local ShipGettingHit = love.audio.newSource("asests/Sounds/shipGettingHit.mp3", "static")
local loseALife = love.audio.newSource("asests/Sounds/loseALife.mp3", "static")

local T = {}
T.debugging = false

function T.makeAnimation(object)
  local imageSheet = love.graphics.newImage(object.playerAnim)

  local r = {
    x = 300,
    y = 700,
    dx = 0,
    dy = 0,
    rotation = 0,
    xScale = 1,
    yScale = 1,
    health = object.playerShip.health,
    currentHealth = object.playerShip.health,
    damage = object.playerShip.damage,
    defence = object.playerShip.defence,
    shipType = object.playerShip.num,
    lives = 3,
    canEscape = false,
    hitbox = {
      x = 0,
      y = 0,
      w = 0,
      h = 0,
      rotation = 0,
      xScale = 1,
      yScale = 1,
    }

  }



  r.frame_index = 1
  r.frame_time_passed = 0
  r.seconds_per_frame = .13


  local shipLocations = {}

  local shipW = imageSheet:getWidth()
  local shipH = imageSheet:getHeight() / 6

  r.hitbox.w = shipW
  r.hitbox.h = shipH

  for r=0, 6 do
    shipLocations[r] = love.graphics.newQuad(0, shipH*r, shipW, shipH, imageSheet:getDimensions())
  end

  r.frameNum = 1

  function r.draw()


          if(global.gameState == 4) then
            love.graphics.draw(imageSheet, shipLocations[r.frameNum],
                300, 600, r.rotation, r.xScale, r.yScale)
          else
            love.graphics.draw(imageSheet, shipLocations[r.frameNum],
                r.x, r.y, r.rotation, r.xScale, r.yScale)
          end

          if(debugging == true) then
            love.graphics.setColor(1, 0,0,.3)
            love.graphics.rectangle("fill", r.hitbox.x, r.hitbox.y + 10, 100, 90)
            love.graphics.setColor(1,1,1,1)
          end


  end

  function r.nextFrame()
      r.frameNum = r.frameNum + 1
      if(r.frameNum >= 6) then
        r.frameNum = 1
      end
  end

  function r.update(dt, projectiles)
    r.x = r.x + (r.dx * dt)
    r.y = r.y + (r.dy * dt)
    r.hitbox.x = r.x
    r.hitbox.y = r.y

      if(r.hitbox.x < 0 and global.canEscape == false) then
        r.x = 0
      end
      if(r.hitbox.y < 50 and global.canEscape == false) then
        r.y = 50
      end
      if(r.hitbox.x + r.hitbox.w >= global.w and global.canEscape == false) then
        r.x = global.w - r.hitbox.w
      end
      if(r.hitbox.y + r.hitbox.h >= global.h and global.canEscape == false) then
        r.y = global.h - r.hitbox.h
      end

      for j = #projectiles.gameProjectiles,1, -1 do
        if(projectiles.gameProjectiles[j].bulletType == "enemy" and projectiles.gameProjectiles[j].active
        and global.collision_test(projectiles.gameProjectiles[j],r.hitbox)) then
          projectiles.gameProjectiles[j].active = false
          local number = love.math.random() *11
          if(number > r.defence) then
            r.currentHealth = r.currentHealth - projectiles.gameProjectiles[j].damage
            ShipGettingHit:play()
          end
          if(global.inTutorial) then
            r.currentHealth = r.health
            TopGUI.healthGUIInfo(r.currentHealth)
          elseif(r.currentHealth <= 0 and global.inTutorial == false) then
            r.lives = r.lives - 1
            TopGUI.livesGUIInfo(r.lives)
            if(r.lives < 0) then
              global.gameOver = true
              global.totalKilled = 0
            elseif(r.lives >= 0) then
              projectiles.reset()
              loseALife:play()
              global.levelReset = true
              r.currentHealth = r.health
            end
          end
        end
        TopGUI.healthGUIInfo(r.currentHealth)
      end



      r.frame_time_passed = r.frame_time_passed + dt

      while(r.frame_time_passed >= r.seconds_per_frame) do
          r.frame_time_passed = r.frame_time_passed - r.seconds_per_frame
          r.nextFrame()
      end
  end

  return r
end


return T
