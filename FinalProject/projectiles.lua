local T = {}


T.gameProjectiles = {}


function T.draw()
    for i = 1, #T.gameProjectiles do
        T.gameProjectiles[i].draw()
    end
end

function T.update(dt)
    for i = #T.gameProjectiles,1, -1 do
        T.gameProjectiles[i].update(dt)
        if(T.gameProjectiles[i].active == false) then
            -- move last element to this spot
            T.gameProjectiles[i] = T.gameProjectiles[#T.gameProjectiles]
            -- have the last one point to nil
            T.gameProjectiles[#T.gameProjectiles] = nil
        end
    end
end


function T.reset()
  for i = 1, #T.gameProjectiles do
      T.gameProjectiles[i].active = false
  end

end


function T.makeProjectile(object,projType)
  local bullet = {
    active = true,
    pp = true,
    w = 10,
    h = 10,
    dy = 0,
    damage = object.damage,
    bulletType = projType
    }
  if(projType == "player") then
    bullet.y = object.hitbox.y - 5
    bullet.y = bullet.y
    bullet.x = object.hitbox.x + object.hitbox.w/2 - 5
    bullet.dy = -8
    bullet.pp = true
  elseif(projType == "enemy") then
    bullet.x = object.x + object.w/2
    bullet.y = object.y + object.h
    bullet.dy = 8
    bullet.pp = false
  end


  function bullet.draw()
    if(bullet.active) then
      if(bullet.damage == 1) then
        love.graphics.setColor(1,0,0,1)
      elseif(bullet.damage == 2) then
        love.graphics.setColor(.8,0,0,1)
      elseif(bullet.damage == 3) then
        love.graphics.setColor(.7,0,0,1)
      elseif(bullet.damage == 4) then
        love.graphics.setColor(.6,0,0,1)
      elseif(bullet.damage == 5) then
        love.graphics.setColor(.5,0,0,1)
      elseif(bullet.damage == 6) then
        love.graphics.setColor(.4,0,0,1)
      elseif(bullet.damage == 10) then
        love.graphics.setColor(.3,0,0,1)
      end
      love.graphics.rectangle("fill", bullet.x, bullet.y, 10, 10)
      love.graphics.setColor(1,1,1,1)
    end
  end

  function bullet.update()
    if(bullet.active) then
      bullet.y = bullet.y + bullet.dy
      if(bullet.y < 50 or bullet.y > global.h) then
        bullet.active = false
      end
    end
  end

  table.insert(T.gameProjectiles, bullet)




end
-- check which ship is shooting.
-- create the bullets at those x cords




return T
