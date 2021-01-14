global = {}


--Global Colors

global.white = {1,1,1,1}
global.black = {0,0,0,1}
global.red = {1, 0, 0, 1}
global.blue = {0, 0, 1, 1}
global.green = {0, 1, 0, 1}
global.cyan = {1, 0.5, 1, 1}

-- Global Vars
global.gameState = 0
--[[
Game State 0 = main screen
Game State 1 = credits
Game State 2 = shipSelection
Game State 3 = Totourial - level 0
Game State 4 = Totourial - level 1
]]


global.canEscape = false
global.canControl = false
global.canShoot = false
global.totorial = false
global.inTutorial = false
global.levelReset = false
global.gameOver = false
global.totalKilled = 0



global.gameName = "INTO THE VOID"
global.splashFont = love.graphics.newFont("asests/AmericanCaptain.ttf", 64)
global.w = love.graphics.getWidth()
global.h = love.graphics.getHeight()

global.movementSpeed = 400



global.cog = love.graphics.newImage("asests/Images/cog.png")
global.title = love.graphics.newImage("asests/Images/titleScreen.png")
global.on = love.graphics.newImage("asests/Images/onButton.png")
global.off = love.graphics.newImage("asests/Images/offButton.png")
global.backButton = love.graphics.newImage("asests/Images/backArrow.png")
global.arrow = love.graphics.newImage("asests/Images/Arrow.png")
global.StatsPicture = love.graphics.newImage("asests/Images/Stats.png")
global.confirmButton = love.graphics.newImage("asests/Images/confirmButton.png")
global.heart = love.graphics.newImage("asests/Images/Heart.png")


global.click = love.audio.newSource("asests/Sounds/click.mp3", "static")
global.shoot = love.audio.newSource("asests/Sounds/shooting.mp3", "static")
global.backgroundMusic = love.audio.newSource("asests/Sounds/playingGameMusic.mp3", "stream")
global.LevelMusic = love.audio.newSource("asests/Sounds/GameBackgroundMusic.mp3", "stream")
-- Global Functions

function global.makeBox(x, y, w, h, color)
  local temp = {}

  love.graphics.setColor(color)
  love.graphics.rectangle("fill", x, y, w, h)
  love.graphics.setColor(1, 1, 1, 1)

  temp.x = x
  temp.y = y
  temp.w = w
  temp.h = h
  temp.color = color

  return temp
end


function global.makeButton(label, x, y, w, h, textColor, buttonColor)
  local temp = {}


  love.graphics.setColor(textColor)
  love.graphics.rectangle("fill", x, y, w, h)
  love.graphics.setColor(buttonColor)
  love.graphics.printf(label, x, y+30, w, 'center')

  temp.x = x
  temp.y = y
  temp.w = w
  temp.h = h

  return temp

end


function global.isPointInBox(x, y, box)
  return ((x > box.x) and (x < box.x + box.w) and (y > box.y) and (y < box.y+box.h))
end


function global.isPlayerTryingToEscape(player)
  if(player.x <=0) then
    return true
  end

end


function global.collision_test(a,b)
	if((a.x <= (b.x + b.w)) and ((a.x+a.w) >= b.x)) and
		((a.y <=(b.y + b.h)) and ((a.y+a.h) >= b.y)) then
			return true
	end
	return false
end



function global.levelStart(player)
  player.canEscape = false
  player.canControl = true
  player.x = global.w/2
  player.y = global.h/2
  player.dx = 0
  player.dy = 0

end
