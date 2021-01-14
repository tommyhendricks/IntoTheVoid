TopGUI = {}
local GUIInfo = {}

GUIInfo.levelProgress = 0

function TopGUI.updateGUIInfo(lives,health,level)
  GUIInfo.lives = lives
  GUIInfo.health = health
  GUIInfo.level = level
end

--Setters for the GUI
function TopGUI.livesGUIInfo(lives)
  GUIInfo.lives = lives
end

function TopGUI.healthGUIInfo(health)
  GUIInfo.health = health
end

function TopGUI.levelGUIInfo(level)
  GUIInfo.level = level
end


function TopGUI.update(dt)
  -- body...
end


function TopGUI.draw()
  love.graphics.setColor(.66,.66,.66,1)
  love.graphics.rectangle("fill", 0, 0, global.w, 50)
  love.graphics.setColor(1, 1,1,1)
  love.graphics.draw(global.heart, -20, -20)
  love.graphics.setColor(1,0,0,1)
  love.graphics.rectangle("fill", 50, 15, 15*GUIInfo.health, 25)
  love.graphics.setColor(1,1,1,1)
  love.graphics.setNewFont("asests/AmericanCaptain.ttf", 24)
  love.graphics.print("Level", global.w/2 - 25, 15)
  love.graphics.print(GUIInfo.level, global.w/2 + 25, 15)

  local xLoc = 540
  for i=1, GUIInfo.lives do
    love.graphics.draw(global.heart, xLoc, -20)
    xLoc = xLoc + 30
  end
end
