local T = {}

local enemyShooting = love.audio.newSource("asests/Sounds/enemyLaser.mp3", "static")

T.EnemyGroup1 = {}

local patterns = { {{x=global.w + 100,y=100},{x=50,y=100},{x=global.w - 100,y=100},{x=50,y=100},{x=global.w - 100,y=100},{x=50,y=100}},
                   {{x=global.w + 100,y=100},{x=50,y=100},{x=50,y=300},{x=global.w + 100,y=300}},
                   {{x=-100,y=100},{x=global.w-100,y=100},{x=global.w-100,y=300},{x=-100,y=300}},
                   {{x=50,y=-100},{x=50,y=200},{x=global.w +100,y=200}},
                   {{x=global.w-100,y=-100},{x=global.w-100,y=200},{x=-100,y=200}},
                   {{x=-100,y=-50},{x=global.w+100,y=300}},
                   {{x=global.w+100,y=-50},{x=-100,y=300}},
                   {{x=global.w+100,y=-50},{x=50,y=300},{x=global.w+100,y=300}},
                   {{x=-100,y=-50},{x=global.w-100,y=300},{x=-100,y=300}},
                   {{x=-100,y=-50},{x=global.w-100,y=300},{x=global.w-100,y=50},{x=-100,y=300}},
                   {{x=global.w+100,y=50},{x=50,y=300},{x=100,y=50},{x=global.w+100,y=300}},
                   {{x=global.w+100,y=70},{x=global.w* 1/3,y=150},{x=global.w * 2/3,y=90},{x=-100,y=70}}
--12 total

}
--add patterns in here



local secondsBehind = .68

T.enemy1 = love.graphics.newImage("Enemys/enemy1.png")
T.enemy2 = love.graphics.newImage("Enemys/enemy2.png")
T.enemy3 = love.graphics.newImage("Enemys/enemy3.png")
T.enemy4 = love.graphics.newImage("Enemys/enemy4.png")
T.enemy5 = love.graphics.newImage("Enemys/enemy5.png")
T.enemy6 = love.graphics.newImage("Enemys/enemy6.png")
T.enemy7 = love.graphics.newImage("Enemys/enemy7.png")
T.enemy8 = love.graphics.newImage("Enemys/enemy8.png")



function T.makeEnemy(number, type, pattern, group)
  local Enemies = {}

  local enemy1 = {}
  enemy1.active = true
  enemy1.health = 3
  enemy1.damage = 1
  enemy1.speed = 200
  enemy1.sinceLastShot = 0
  enemy1.fireRate = 2
  enemy1.w = 75
  enemy1.h = 75
  enemy1.x = 0
  enemy1.y = 0
  enemy1.dx = 0
  enemy1.dy = 0
  enemy1.image = T.enemy1
  Enemies[1] = enemy1

  local enemy2 = {}
  enemy2.active = true
  enemy2.health = 4
  enemy2.damage = 2
  enemy2.speed = 200
  enemy2.sinceLastShot = 0
  enemy2.fireRate = 2
  enemy2.w = 75
  enemy2.h = 75
  enemy2.x = 0
  enemy2.y = 0
  enemy2.dx = 0
  enemy2.dy = 0
  enemy2.image = T.enemy2
  Enemies[2] = enemy2

  local enemy3 = {}
  enemy3.active = true
  enemy3.health = 5
  enemy3.damage = 3
  enemy3.speed = 200
  enemy3.sinceLastShot = 0
  enemy3.fireRate = 2
  enemy3.w = 75
  enemy3.h = 75
  enemy3.x = 0
  enemy3.y = 0
  enemy3.dx = 0
  enemy3.dy = 0
  enemy3.image = T.enemy3
  Enemies[3] = enemy3

  local enemy4 = {}
  enemy4.active = true
  enemy4.health = 6
  enemy4.damage = 3
  enemy4.speed = 200
  enemy4.sinceLastShot = 0
  enemy4.fireRate = 2
  enemy4.w = 75
  enemy4.h = 75
  enemy4.x = 0
  enemy4.y = 0
  enemy4.dx = 0
  enemy4.dy = 0
  enemy4.image = T.enemy4
  Enemies[4] = enemy4

  local enemy5 = {}
  enemy5.active = true
  enemy5.health = 5
  enemy5.damage = 10
  enemy5.speed = 200
  enemy5.sinceLastShot = 0
  enemy5.fireRate = 2
  enemy5.w = 75
  enemy5.h = 75
  enemy5.x = 0
  enemy5.y = 0
  enemy5.dx = 0
  enemy5.dy = 0
  enemy5.image = T.enemy5
  Enemies[5] = enemy5

  local enemy6 = {}
  enemy6.active = true
  enemy6.health = 7
  enemy6.damage = 2
  enemy6.speed = 200
  enemy6.sinceLastShot = 0
  enemy6.fireRate = 2
  enemy6.w = 75
  enemy6.h = 75
  enemy6.x = 0
  enemy6.y = 0
  enemy6.dx = 0
  enemy6.dy = 0
  enemy6.image = T.enemy6
  Enemies[6] = enemy6

  local enemy7 = {}
  enemy7.active = true
  enemy7.health = 10
  enemy7.damage = 4
  enemy7.speed = 200
  enemy7.sinceLastShot = 0
  enemy7.fireRate = 2
  enemy7.w = 75
  enemy7.h = 75
  enemy7.x = 0
  enemy7.y = 0
  enemy7.dx = 0
  enemy7.dy = 0
  enemy7.image = T.enemy7
  Enemies[7] = enemy7

  local enemy8 = {}
  enemy8.active = true
  enemy8.health = 15
  enemy8.damage = 4
  enemy8.speed = 200
  enemy8.sinceLastShot = 0
  enemy8.fireRate = 2
  enemy8.w = 75
  enemy8.h = 75
  enemy8.x = 0
  enemy8.y = 0
  enemy8.dx = 0
  enemy8.dy = 0
  enemy8.image = T.enemy8
  Enemies[8] = enemy8

  local Enemy = {}

  Enemy = Enemies[type]

  -- This will have the enemy spawn one distance behind the one infront of it
  -- will get the x and y of index 1 then get the x and y of index 2
  -- it will then calc the angle and based on the speed it will get the dx,dy
  -- Then spawns the enemy at x,y - its number of creation * dy * seconds behind
  Enemy.destList = patterns[pattern]

  Enemy.x = Enemy.destList[1].x
  Enemy.y = Enemy.destList[1].y

  Enemy.destIndex = 2

  local A = Enemy.destList[Enemy.destIndex].x - Enemy.x
  local B = Enemy.destList[Enemy.destIndex].y - Enemy.y

  local alpha = math.atan2(B, A)
  Enemy.dx = math.cos(alpha) * Enemy.speed
  Enemy.dy = math.sin(alpha) * Enemy.speed

  Enemy.x = Enemy.x - (Enemy.dx * number * secondsBehind)
  Enemy.y = Enemy.y - (Enemy.dy * number * secondsBehind)


  function Enemy.draw()
    if(Enemy.active) then
      love.graphics.draw(Enemy.image, Enemy.x, Enemy.y ,0 ,.15 ,.15)
      --love.graphics.rectangle("fill", Enemy.x, Enemy.y, 100,100)
    end
  end


  function Enemy.update(dt, projectiles)

    if(Enemy.active) then
      if((math.abs(Enemy.x-Enemy.destList[Enemy.destIndex].x) < 10) and (math.abs(Enemy.y-Enemy.destList[Enemy.destIndex].y) < 10)) then

        Enemy.destIndex = Enemy.destIndex+1

        if(Enemy.destIndex > #Enemy.destList) then
          Enemy.active = false

          return
        end

        local A = Enemy.destList[Enemy.destIndex].x - Enemy.x
        local B = Enemy.destList[Enemy.destIndex].y - Enemy.y

        local alpha = math.atan2(B, A)
        Enemy.dx = math.cos(alpha) * Enemy.speed
        Enemy.dy = math.sin(alpha) * Enemy.speed

      end
      Enemy.x = Enemy.x + (Enemy.dx * dt)
      Enemy.y = Enemy.y + (Enemy.dy * dt)

      for j = #projectiles.gameProjectiles,1, -1 do
        if(projectiles.gameProjectiles[j].bulletType == "player" and projectiles.gameProjectiles[j].active) then
          if(global.collision_test(projectiles.gameProjectiles[j], Enemy)) then
            Enemy.health = Enemy.health - projectiles.gameProjectiles[j].damage
            projectiles.gameProjectiles[j].active = false
            projectiles.gameProjectiles[j].damage = 0
            if(Enemy.health <= 0) then
              global.totalKilled = global.totalKilled + 1
              Enemy.active = false
              projectiles.gameProjectiles[j].active = false
              projectiles.gameProjectiles[j].damage = 0
            end
          end
        end
      end
      Enemy.sinceLastShot = Enemy.sinceLastShot + dt

      if(Enemy.sinceLastShot >= Enemy.fireRate) then
        local number = love.math.random(25)
        if(number == 1) then
          enemyShooting:play()
          projectiles.makeProjectile(Enemy, "enemy")
          Enemy.sinceLastShot = 0
        end
      end
      -- check projectiles
    end
  end


  table.insert(T.EnemyGroup1, Enemy)

end


function T.spawnEnemies(number, type, pattern, group)
  for i=1, number do
    T.makeEnemy(i, type, pattern, group)
  end

end


function T.draw()
  for i=1, #T.EnemyGroup1 do
    T.EnemyGroup1[i].draw()
  end
end


function T.update(dt, projectiles)
  for i = #T.EnemyGroup1,1, -1 do
      T.EnemyGroup1[i].update(dt, projectiles)

      if(T.EnemyGroup1[i].active == false) then
          -- move last element to this spot
          T.EnemyGroup1[i] = T.EnemyGroup1[#T.EnemyGroup1]
          -- have the last one point to nil
          T.EnemyGroup1[#T.EnemyGroup1] = nil
      end
  end

end


function T.reset()
  for i=1, #T.EnemyGroup1 do
    T.EnemyGroup1[i].active = false
  end
end

return T
